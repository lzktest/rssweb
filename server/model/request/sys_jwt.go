package request

import (
	"github.com/dgrijalva/jwt-go"
	uuid "github.com/satori/go.uuid"
)

// Custom claims structure
type CustomClaims struct {
	UUID 	uuid.UUID
	ID 		uint
	UserName string
	NickName string
	AuthorityId string
	BufferTime int64
	jwt.StandardClaims
}