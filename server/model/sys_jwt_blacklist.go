package model

import (
	"server/global"
)

type JwtBlacklist struct {
	global.GVA_MODEL
	Jwt string
}
