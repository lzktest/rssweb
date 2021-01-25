package middleware

import (
	"server/global"
	"server/model"
	"server/model/response"
	services "server/service"
	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"strconv"
	"time"
)

func JWTAuth() gin.HandlerFunc{
	return func(c *gin.Context){
		// jwt坚强头部信息 x-token 登录时会返回token信息 这里可能选哟前端把token存储到cookie或本地localstorage中
		token := c.Request.Header.Get("x-token")
		if token == ""{
			response.FailWithDetailed(gin.H{"reload": true}, "未登录或非法访问", c)
			c.Abort()
			return
		}
		if services.IsBlacklist(token) {
			response.FailWithDetailed(gin.H{"reload": true}, "您的账户登录或令牌失效", c)
			c.Abort()
			return
		}
		j := NewJWT()
		// parseToken 解析token包含的信息
		claims, err := j.ParseToken(token)
		if err != nil {
			if err == TokenExpired {
				response.FailWithDetailed(gin.H{"reload":true}, err.Error(), c)
				c.Abort()
				return
			}
		}
		if err, _ = services.FindUserByUuid(claims.UUID.String()); err != nil {
			_ = services.JsonInBlackList(model.JwtBlacklist{Jwt: token})
			response.FailWithDetailed(gin.H{"reload":true}, err.Error(), c)
			c.Abort()
		}
		if claims.ExpiresAt-time.Now().Unix() < claims.BufferTime {
			claims.ExpiresAt = time.Now().Unix() + global.GVA_CONFIG.JWT.ExpiresTime
			newToken, _ := j.CreateToken(*claims)
			newClaims, _ := j.ParseToken(newToken)
			c.Header("new-token", newToken)
			c.Header("new-expires-at", strconv.FormatFloat(newClaims.ExpiresAt, 10))
			if global.GVA_CONFIG.System.UserMultipoint {
				err, RedisJwtToken := services.GetRedisJWT(newClaims.UserName)
				if err != nil {
					global.GVA_LOG.Error("get redis jwt failed", zap.Any("err", err))
				} else {
					_ = services.JsonInBlacklist(model.JwtBlacklist{Jwt: RedisJwtToken})
				}
				_ = services.SetRedisJWT(newToken,newClaims.Username)
			}
		}
		c.Set("claims", claims)
		c.Next()
	}
}
type JWT struct {
	SigningKey []byte
}

func NewJWT() *JWT {
	return &JWT{
		[]byte(global.GVA_CONFIG.JWT.SigningKey),
	}
}

// 创建一个token
func (j *JWT) CreateToken(claims request.CustomClaims)(string, error){
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString(j.SigningKey)
}

// 解析token
func (j *JWT) ParseToken(tokenString string)(*request.CustomClaims, error){
	token, err := jwtParseWithClaims(tokenString, &request.CustomClaims{}, func(token *jwt.Token)(i interface{}, e error){
		return j.SigningKey, nil
	})
	if err != nil {
		if ve, ok := err.(*jwt.ValidationError); ok {
			if ve.Errors&jwt.ValidationErrorMalformed != 0 {
				return nil, TokenMalformed
			} else if ve.Errors&jwt.ValidationErrorExpired != 0 {
				return nil, TokenExpired
			} else if ve.Errors&jwt.ValidationErrorNotValidYet != 0 {
				return nil, TokenNotValidYet
			} else {
				return nil, TokenInvalid
			}
		}
	}
	if token != nil {
		if claims, ok := token.Claims.(*request.CustomClaims); ok && token.Valid{
			return claims, nil
		}
		return nil, TokenInvalid
	} else {
		return nil, TokenInvalid
	}
}