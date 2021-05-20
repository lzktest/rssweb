package sevice

import (

	"encoding/xml"
	"errors"

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

//func GetData()(atomtmp response.Atom, err error){
//	tr := &http.Transport{
//		MaxIdleConns:       10,
//		IdleConnTimeout:    30 * time.Second,
//		DisableCompression: true,
//	}
//	client := &http.Client{Transport: tr}
//	resp, _ := client.Get("http://vdaily.iu.vc/old-weekly.xml")
//	headtype := resp.Header.Get("content-type")
//	fmt.Print(headtype)
//	//defer resp.Body.Close()
//	body, _ := ioutil.ReadAll(resp.Body)
//	//fmt.Print(string(body))
//	testxml := request.Atom{}
//	xml.Unmarshal(body,&testxml)
//	txml := response.Atom{}
//	txml.Xmlns = testxml.Xmlns
//	txml.Title = testxml.Title
//	txml.Subtitle = testxml.Subtitle
//	txml.Link1 = testxml.Link1
//	txml.Id = testxml.Id
//	txml.Updated = testxml.Updated
//	txml.Rights = testxml.Rights
//	txml.Entrys = testxml.Entrys
//	//fmt.Print(testxml)
//	return txml,nil
//}
func GetSourceList(){
	//var addrsource []map[string]string
	rows,err := global.GVA_DB.Query("select id,xmllink,cycletime,updatetime from rssdata where status=true")
	global.GVA_LOG.Error("载入队列ing!", zap.Any("err", err))
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
		minutes,_ := time.ParseDuration(sourcecycle+"s")
		//fmt.Print(time.Now().Sub(updatetime))
		if time.Now().After(updatetime.Add(minutes)){
			fmt.Print("已到更新时间")
			go GetData(idtmp,sourceaddrtmp)
		}
		//fmt.Print(updatetime)

		//addrsource = append(addrsource,map[string]string{"id":idtmp,"sourceaddr":sourceaddrtmp,"sourcecycle":sourcecycle})
	}
	//fmt.Print(addrsource)
}
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
	headtype := resp.Header.Get("content-type")
	fmt.Print(headtype)
	//defer resp.Body.Close()
	body, _ := ioutil.ReadAll(resp.Body)
	//fmt.Print(string(body))
	testxml := request.Rss{}
	xml.Unmarshal(body,&testxml)
	tx,_ := global.GVA_DB.Begin()
	channel := testxml.ChannelRss
	//var rssid string
	//err :=tx.QueryRow("select id,xmllink,xmltitle from rssdata where xmldescription=$1",channel.Description).Scan(&rssid)
	//fmt.Print(rssid)
	//if err !=nil && !errors.Is(err,sql.ErrNoRows){
	//	global.GVA_LOG.Error("查询失败!", zap.Any("err", err))
	//	return
	//}
	//if len(rssid)<=0{
	//	err = tx.QueryRow("insert into rssdata(xmltype,xmltitle,xmldescription,xmllink,lastbuilddate,generator,rsssourcelistid) values($1,$2,$3,$4,$5,$6,$7) returning id","rss-xml",channel.Title,channel.Description,channel.Link,channel.LastBuildDate,channel.Generator,id).Scan(&rssid)
	//	if err !=nil {
	//		global.GVA_LOG.Error("插入失败!", zap.Any("err", err))
	//		err =tx.Rollback()
	//		return
	//	}
	//}

	for _,value := range channel.Items{
		_,err := tx.Exec("insert into rssdatasub(title,link,pubdate,description,createtime,rssdataid,rssdoc) values($1,$2,$3,$4,$5,$6,$7)",value.Title,value.Link,value.Pubdate,value.Description,time.Now(),id,string(body))
		if err != nil && !errors.Is(err,errors.New("duplicate key value violates unique constraint")) {
			global.GVA_LOG.Warn("sub插入失败!", zap.Any("warning", err))
			err =tx.Rollback()
			//return
		}
	}
	err := tx.Commit()
	if err != nil {
		global.GVA_LOG.Error("getdata commit失败!", zap.Any("err", err))
		return
	}
	//fmt.Print(testxml)
	//txml := response.Rss{}
	//txml.RssData = testxml.RssData
}

func GetRssDataJson(rssdataid string)(atomtmp response.Rss, err error){
	var rssdataidtmp string
	fmt.Print(rssdataid)
   err = global.GVA_DB.QueryRow("select id,xmltitle,xmldescription,xmllink,lastbuilddate,generator from rssdata where id=$1",rssdataid).Scan(&rssdataidtmp,&atomtmp.RssData.ChannelRss.Title,&atomtmp.RssData.ChannelRss.Description,&atomtmp.RssData.ChannelRss.Link,&atomtmp.RssData.ChannelRss.LastBuildDate,&atomtmp.RssData.ChannelRss.Generator)
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
   fmt.Print(atomtmp)
	return atomtmp,nil
}

//func GetRssDataJson(rssdataid string)(atomtmp response.Rss, err error){
//	rows ,err := global.GVA_DB.Query("select title,link,pubdate,description from rssdatasub where rssdataid =$1 ;",rssdataid)
//	if err != nil {
//		global.GVA_LOG.Error("commit失败!", zap.Any("err", err))
//		return atomtmp, err
//	} else {
//		for rows.Next(){
//			var itemtmp model.Item
//			err = rows.Scan(&itemtmp.Title,&itemtmp.Link,&itemtmp.Pubdate,&itemtmp.Description)
//			if err != nil {
//				return atomtmp,err
//			}
//			atomtmp.RssData.ChannelRss.Items = append(atomtmp.RssData.ChannelRss.Items, itemtmp)
//		}
//	}
//	fmt.Print(atomtmp)
//	return atomtmp,nil
//}