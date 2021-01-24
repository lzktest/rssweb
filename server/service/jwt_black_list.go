package sevice

import (
	"database/sql"
	"errors"
	"server/global"
	"server/model"
	"time"
)

//@author: [piexlmax]
//@function: JsonInBlacklist
//@description: 拉黑jwt
//@param: jwtList model.JwtBlacklist
//@return: err error
func JsonInblacklist(jwtList model.JwtBlacklist)(err error){
	_, err = global.GVA_DB.Exec("insert into sys_jwt_blacklist(id,created_at,updated_at,jwt) values($1,$2,$3,$4)",jwtList.ID,jwtList.CreatedAt,jwtList.UpdatedAt,jwtList.Jwt)
	return err
}

// @author:[piexlmax]
// @function: IsBlacklist
// @description: 判断jwt是否在黑名单内部
// @param: jwtList model.JwtBlacklist
// @return: err error
func IsBlacklist(jwt string) bool {
	var jwtrow model.JwtBlocklist
	_, err := global.GVA_DB.QueryRow("select jwt from sys_jwt_blacklist where jwt = $1 ;",jwt).Scan(&jwtrow.Jwt)
	if errors.Is(err, sql.ErrNoRows) {
		return false
	}
	return true
}

//@author: [piexlmax](https://github.com/piexlmax)
//@function: GetRedisJWT
//@description: 从redis取jwt
//@param: userName string
//@return: err error, redisJWT string

func GetRedisJWT(userName string)(err error, redisJWT string){
	redisJWT, err = global.GVA_REDIS.Get(userName).Result()
	return err, redisJwt
}

//@author: [piexlmax](https://github.com/piexlmax)
//@function: SetRedisJWT
//@description: jwt存入redis并设置过期时间
//@param: userName string
//@return: err error, redisJWT string
func SetRedisJWT(jwt string, userName string) (err error){
	// 此处过期时间等于jwt过期时间
	timer := 60 * 60 * 24 * 7 *time.Second
	err = global.GVA_REDIS.Set(userName, jwt, timer).Err()
	return err
}
