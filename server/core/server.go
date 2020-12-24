package core

import (
	"fmt"
	"server/global"
)

type server interface {
	ListenAndServe() error
}

func RunWindowsServer() {
	if global.GVA_CONFIG.System.UseMultipoint {
		fmt.Printf("test")
	}

}
