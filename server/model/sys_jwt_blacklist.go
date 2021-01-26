package model

import (
	"server/global"
)

type JwtBlocklist struct {
	global.GVA_MODEL
	Jwt string
}
