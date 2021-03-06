package sevice

import (
	"errors"
	"fmt"
	"go.uber.org/zap"
	"server/global"
	"server/model"
	"server/model/request"
	"server/utils"
	"strings"

	"github.com/casbin/casbin/util"
	casbin "github.com/casbin/casbin/v2"
	_ "github.com/lib/pq"
	pgadapter "github.com/lzktest/casbinpgandadapter"
)

// @author: [piexlmax](https://github.com/piexlmax)
// @function: Casbin
// @description: 持久化到数据库  引入自定义规则
// @return: *casbin.Enforcer

func Casbin() *casbin.Enforcer {
	a, err := pgadapter.NewAdapter("postgres","user=" + global.GVA_CONFIG.Pg.Username + " password=" + global.GVA_CONFIG.Pg.Password + " host=" + global.GVA_CONFIG.Pg.Host + " port=" + global.GVA_CONFIG.Pg.Port + " dbname=" + global.GVA_CONFIG.Pg.Dbname + " sslmode=" + global.GVA_CONFIG.Pg.Sslmode)
	//a, err := pgadapter.NewAdapter(global.GVA_DB, "casbin_rule")
	if err != nil {
		global.GVA_LOG.Error("casbin Fail, please check pgadapter:", zap.Any("err",err))
	}
	e, err := casbin.NewEnforcer(global.GVA_CONFIG.Casbin.ModelPath, a)
	if err != nil {
		global.GVA_LOG.Error("NewEnforcer Fail, please check casbin ModelPath:", zap.Any("err",err))
	}
	e.AddFunction("ParamsMatch", ParamsMatchFunc)
	if err := e.LoadPolicy(); err != nil {
		global.GVA_LOG.Error("loadPolicy Fail, please check casbin ModelPath:", zap.Any("err",err))
	}
	return e
}

// @author: [piexlmax](https://github.com/piexlmax)
// @func GetPolicyPathByAuthorityId
// @description: 获取权限列表
// @param: authorityId string
// @return: pathMaps []request.CasbinInfo
func GetPolicyPathByAuthorityId(authorityId string) (pathMaps []request.CasbinInfo) {
	e := Casbin()
	list := e.GetFilteredPolicy(0, authorityId)
	for _, v := range list {
		pathMaps = append(pathMaps, request.CasbinInfo{
			Path:   v[1],
			Method: v[2],
		})
	}
	return pathMaps
}

// @author: [piexlmax](https://github.com/piexlmax)
// @function: UpdateCasbin
// @description: 更新casbin权限
// @param: authorityId string, casbinInfos []request.CasbinInfo
// @return: error
func UpdateCasbin(authorityId string, casbinInfos []request.CasbinInfo) error {
	ClearCasbin(0, authorityId)
	rules := [][]string{}
	for _, v := range casbinInfos {
		cm := model.CasbinModel{
			Ptype:       "p",
			AuthorityId: authorityId,
			Path:        v.Path,
			Method:      v.Method,
		}
		rules = append(rules, []string{cm.AuthorityId, cm.Path, cm.Method})
	}
	print(rules)
	e := Casbin()

	if success, err := e.AddPolicies(rules); err != nil {
		global.GVA_LOG.Error("Addpolicies Fail:", zap.Any("err",err))
	} else {
		if success == false {
			return errors.New("存在相同api,添加失败,请联系管理员")
		}
	}

	return nil
}

// @author: [piexlmax](https://github.com/piexlmax)
// @function: UpdateCasbinApi
// @description: API更新随动
// @param: oldPath string, newPath string, oldMethod string, newMethod string
// @return: error

func UpdateCasbinApi(oldPath string, newPath string, oldMethod string, newMethod string) error {
	upsql, err := global.GVA_DB.Prepare("update casbin_rule set v1=$1,v2=$2 where v1=$3 and v2 = $4")
	utils.CheckErr(err)
	res, err := upsql.Exec(newPath, newMethod, oldPath, oldMethod)
	utils.CheckErr(err)
	affect, err := res.RowsAffected()
	fmt.Print("aaa: %v", affect)
	utils.CheckErr(err)
	return err
}

// @author: [piexlmax](https://github.com/piexlmax)
// @function: ClearCasbin
// @description: 清楚匹配的权限
// @param: v int, p ...string
// @return: bool

func ClearCasbin(v int, p ...string) bool {
	e := Casbin()
	success, _ := e.RemoveFilteredPolicy(v, p...)
	return success
}

// @author: [piexlmax](https://github.com/piexlmax)
// @function: ParamsMatch
// @description: 自定义规则函数
// @param: fullNameKey1 string, key2 string
// @return: bool

func ParamsMatch(fullNameKey1 string, key2 string) bool {
	key1 := strings.Split(fullNameKey1, "?")[0]
	// 剥离路径和再使用casbin的keyMatch2
	return util.KeyMatch2(key1, key2)
}

// @author: [piexlmax] (https://github.com/piexlmax)
// @function: ParamsMatchFunc
// @description: 自定义规则函数
// @param: args ...interface{}
// @return: interface{}, error

func ParamsMatchFunc(args ...interface{}) (interface{}, error) {
	name1 := args[0].(string)
	name2 := args[1].(string)
	return ParamsMatch(name1, name2), nil
}
