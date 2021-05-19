package sevice

import (
	"database/sql"
	"encoding/xml"
	"errors"
	"io/ioutil"
	"net/http"
	"server/global"
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
func GetData()(atomtmp response.Rss, err error){
	tr := &http.Transport{
		MaxIdleConns:       10,
		IdleConnTimeout:    30 * time.Second,
		DisableCompression: true,
	}
	client := &http.Client{Transport: tr}
	resp, _ := client.Get("http://www.4sbooks.com/feed")
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
	var rssid string
	err =tx.QueryRow("select id from rssdata where xmldescription=$1",channel.Description).Scan(&rssid)
	fmt.Print(rssid)
	if err !=nil && !errors.Is(err,sql.ErrNoRows){
		global.GVA_LOG.Error("查询失败!", zap.Any("err", err))
		return atomtmp,err
	}
	if len(rssid)<=0{
		err = tx.QueryRow("insert into rssdata(xmltype,xmltitle,xmldescription,xmllink,lastbuilddate,generator) values($1,$2,$3,$4,$5,$6) returning id","rss-xml",channel.Title,channel.Description,channel.Link,channel.LastBuildDate,channel.Generator).Scan(&rssid)
		if err !=nil {
			global.GVA_LOG.Error("插入失败!", zap.Any("err", err))
			err =tx.Rollback()
			return atomtmp, err
		}
	}
	fmt.Print(rssid)

	for _,value := range channel.Items{
		_,err = tx.Exec("insert into rssdatasub(title,link,pubdate,description,createtime,rssdataid,rssdoc) values($1,$2,$3,$4,$5,$6,$7)",value.Title,value.Link,value.Pubdate,value.Description,time.Now(),rssid,string(body))
		if err != nil {
			global.GVA_LOG.Error("sub插入失败!", zap.Any("err", err))
			err =tx.Rollback()
			return atomtmp, err
		}
	}
	err = tx.Commit()
	if err != nil {
		global.GVA_LOG.Error("commit失败!", zap.Any("err", err))
		return atomtmp, err
	}
	//fmt.Print(testxml)
	//txml := response.Rss{}
	//txml.RssData = testxml.RssData
	return atomtmp,nil
}
func GetRssDataJson(rssdataid string)(atomtmp response.Rss, err error){
	var rssdataidtmp string
	fmt.Print(rssdataid)
    err = global.GVA_DB.QueryRow("select id,xmltitle,xmldescription,xmllink,lastbuilddate,generator from rssdata where id=$1",rssdataid).Scan(&rssdataidtmp,&atomtmp.RssData.ChannelRss.Title,&atomtmp.RssData.ChannelRss.Description,&atomtmp.RssData.ChannelRss.Link,&atomtmp.RssData.ChannelRss.LastBuildDate,&atomtmp.RssData.ChannelRss.Generator)
	if err != nil {
		global.GVA_LOG.Error("commit失败!", zap.Any("err", err))
		return atomtmp, err
	}
    fmt.Print(atomtmp)
	return atomtmp,nil
}