package sevice

import (
	"database/sql"
	"encoding/xml"
	"errors"
	"io"
	"strings"

	"io/ioutil"
	"net/http"
	"server/global"
	"server/model"
	"server/model/request"
	"server/model/response"
	"go.uber.org/zap"
	"time"
	"fmt"
)

//获取数据源列表
func GetSourceList(){
	//var addrsource []map[string]string
	rows,err := global.GVA_DB.Query("select id,xmllink,cycletime,updatetime from rssdata where status=true")
	//global.GVA_LOG.Error("载入队列ing!", zap.Any("err", err))
	if err !=nil {
		global.GVA_LOG.Error("插入失败!", zap.Any("err", err))
		return
	}
	for rows.Next(){
		var idtmp,sourceaddrtmp,sourcecycle string
		var updatetime time.Time
		err := rows.Scan(&idtmp,&sourceaddrtmp,&sourcecycle,&updatetime)
		if err != nil {
			global.GVA_LOG.Error("获取url队列失败!", zap.Any("err", err))
			return
		}
		//var addrs map[string]string
		minutes,_ := time.ParseDuration(sourcecycle+"m")
		//fmt.Print(time.Now().Sub(updatetime))
		if time.Now().After(updatetime.Add(minutes)){
			global.GVA_LOG.Info(idtmp)
			global.GVA_LOG.Info(sourceaddrtmp)
			go GetData(idtmp,sourceaddrtmp)
		}
		//fmt.Print(updatetime)

		//addrsource = append(addrsource,map[string]string{"id":idtmp,"sourceaddr":sourceaddrtmp,"sourcecycle":sourcecycle})
	}
	time.Sleep(2 * time.Second)
}
//发起获取数据源请求
func GetData(id string,xmllink string){
	tr := &http.Transport{
		MaxIdleConns:       10,
		IdleConnTimeout:    30 * time.Second,
		DisableCompression: true,
	}
	client := &http.Client{Transport: tr}
	resp, _ := client.Get(xmllink)
	//resp, _ := client.Get("http://www.4sbooks.com/feed")
	//resp, _ := client.Get("http://vdaily.iu.vc/old-weekly.xml")
	//headtype := resp.Header.Get("content-type")
	//fmt.Print(headtype)
	//defer resp.Body.Close()
	body, _ := ioutil.ReadAll(resp.Body)
	//fmt.Print(string(body))
	//xmlresult, err := CheckTag(string(body),"rss")
	//fmt.Print(xmlresult, err)
	if xmlresult, err := CheckTag(string(body),"rss"); err==nil && xmlresult {
		testxml := request.Rss{}
		xml.Unmarshal(body,&testxml)
		tx,_ := global.GVA_DB.Begin()
		channel := testxml.ChannelRss
		for _,value := range channel.Items{
			var title string
			err :=tx.QueryRow("select title from rssdatasub where title=$1",value.Title).Scan(&title)
			if errors.Is(err,sql.ErrNoRows){
				_,err = tx.Exec("insert into rssdatasub(title,link,pubdate,description,createtime,rssdataid,rssdoc) values($1,$2,$3,$4,$5,$6,$7)",value.Title,value.Link,value.Pubdate,value.Description,time.Now(),id,string(body))
				if err != nil{
					global.GVA_LOG.Warn("sub插入失败!", zap.Any("warning", err))
					err =tx.Rollback()
					return
				}

			}
		}
		_,err = tx.Exec("update rssdata set updatetime=$1 where id=$2",time.Now(),id)
		if err != nil{
			global.GVA_LOG.Warn("updatetime 更新失败!", zap.Any("warning", err))
			err =tx.Rollback()
			return
		}
		err := tx.Commit()
		if err != nil {
			global.GVA_LOG.Error("getdata commit失败!", zap.Any("err", err))
			return
		}
	}
	if xmlresult, err := CheckTag(string(body),"feed"); err==nil && xmlresult {
		testxml := request.Atom{}
		xml.Unmarshal(body,&testxml)
		tx,_ := global.GVA_DB.Begin()
		for _,value := range testxml.Entrys{
			var title string
			err :=tx.QueryRow("select title from rssdatasub where title=$1",value.Title).Scan(&title)
			if errors.Is(err,sql.ErrNoRows){
				_,err = tx.Exec("insert into rssdatasub(title,link,pubdate,description,createtime,rssdataid,rssdoc) values($1,$2,$3,$4,$5,$6,$7)",value.Title,value.Link,value.Published,value.Context,time.Now(),id,string(body))
				if err != nil{
					global.GVA_LOG.Warn("sub插入失败!", zap.Any("warning", err))
					err =tx.Rollback()
					return
				}
			}
		}
		global.GVA_LOG.Warn("updatetime 更新!", zap.Any("warning", id))
		_,err = tx.Exec("update rssdata set updatetime=$1 where id=$2",time.Now(),id)
		if err != nil{
			global.GVA_LOG.Warn("updatetime 更新失败!", zap.Any("warning", err))
			err =tx.Rollback()
			return
		}
		err := tx.Commit()
		if err != nil {
			global.GVA_LOG.Error("getdata commit 失败!", zap.Any("err", err))
			return
		}
	}
}
// 读取数据库，构造rss结构体
func GetRssDataJson(rssdataid string)(atomtmp response.Rss, err error){
	var rssdataidtmp string
	fmt.Print(rssdataid)
   err = global.GVA_DB.QueryRow("select id,xmltitle,xmldescription,xmllink from rssdata where id=$1",rssdataid).Scan(&rssdataidtmp,&atomtmp.RssData.ChannelRss.Title,&atomtmp.RssData.ChannelRss.Description,&atomtmp.RssData.ChannelRss.Link)
	if err != nil {
		global.GVA_LOG.Error("commit失败!", zap.Any("err", err))
		return atomtmp, err
	}
	fmt.Println(rssdataidtmp)
	rows ,err := global.GVA_DB.Query("select title,link,pubdate,description from rssdatasub where rssdataid =$1 ;",rssdataidtmp)
	if err != nil {
		global.GVA_LOG.Error("commit失败!", zap.Any("err", err))
		return atomtmp, err
	} else {
		for rows.Next(){
			var itemtmp model.Item
			err = rows.Scan(&itemtmp.Title,&itemtmp.Link,&itemtmp.Pubdate,&itemtmp.Description)
			if err != nil {
				return atomtmp,err
			}
			atomtmp.RssData.ChannelRss.Items = append(atomtmp.RssData.ChannelRss.Items, itemtmp)
		}
	}
	return atomtmp,nil
}
//检查xml是否有某个节点
func CheckTag(src , tag string)(bool, error){
	decoder := xml.NewDecoder(strings.NewReader(src))
	for {
		t, err := decoder.Token()
		if err !=nil {
			if err == io.EOF{
				return false, nil
			}
			return false, nil
		}
		if se, ok := t.(xml.StartElement); ok{
			if se.Name.Local == tag {
				return true, nil
			}
		}
	}
}

// 获取rssdatalist
func GetRssDataList()(rss []model.RssDatas,err error){
	rows,err := global.GVA_DB.Query("select id,xmltype,xmltitle,xmldescription,xmllink,status,cycletime from rssdata")
	if err != nil{
		global.GVA_LOG.Error("select 获取xmllist失败!", zap.Any("err", err))
		return rss,err
	}
	for rows.Next(){
		var rsstmp model.RssDatas
		err = rows.Scan(&rsstmp.Id,&rsstmp.Xmltype,&rsstmp.XmlTitle,&rsstmp.XmlDescription,&rsstmp.XmlLink,&rsstmp.Status,&rsstmp.CycleTime)
		if err != nil {
			global.GVA_LOG.Error("select 获取xmllist失败!", zap.Any("err", err))
			return rss,err
		}
		rss = append(rss, rsstmp)
	}
	return rss, err
}

// 添加rssdatalist
func AddRssDataList(rss model.RssDatas)(err error){
	_,err = global.GVA_DB.Exec("insert into rssdata(xmltype,xmltitle,xmldescription,xmllink,status,cycletime) values($1,$2,$3,$4,$5,$6);",rss.Xmltype,rss.XmlTitle,rss.XmlDescription,rss.XmlLink,rss.Status,rss.CycleTime)
	return err
}
// 修改rssdatalist
func UpdateRssDataList(rss model.RssDatas)(err error){
	_,err = global.GVA_DB.Exec("update rssdata set xmltype=$1,xmltitle=$2,xmldescription=$3,xmllink=$4,status=$5,cycletime=$6 where id=$7;",rss.Xmltype,rss.XmlTitle,rss.XmlDescription,rss.XmlLink,rss.Status,rss.CycleTime,rss.Id)
	return err
}

// 删除rssdatalist
func DeleteDataList(rss request.RssIdsReq)(err error){
	tx ,_ := global.GVA_DB.Begin()
	for _,value := range rss.Ids{
		_,err = tx.Exec("delete from rssdata where id = $1;",value)
		if err !=nil{
			global.GVA_LOG.Error("delete rssdata 失败!", zap.Any("id", value))
			tx.Rollback()
			return err
		}
	}
	err = tx.Commit()
	return err
}

// 根据id获取rssdata
func GetRssDataListbyId(id string)(rsstmp model.RssDatas,err error){
	err = global.GVA_DB.QueryRow("select id,xmltype,xmltitle,xmldescription,xmllink,status,cycletime from rssdata where id=$1",id).Scan(&rsstmp.Id,&rsstmp.Xmltype,&rsstmp.XmlTitle,&rsstmp.XmlDescription,&rsstmp.XmlLink,&rsstmp.Status,&rsstmp.CycleTime)
	return rsstmp, err
}