package sevice

import (
	"encoding/xml"
	"io/ioutil"
	"net/http"
	"server/global"
	"server/model"
	"server/model/request"
	"server/model/response"
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
	err = tx.QueryRow("insert into rssdata(xmltype,xmltitle,xmldescription,xmllink,lastbuilddate,generator) values($1,$2,$3,$4,$5,$6) returning id","rss-xml",channel.Title,channel.Description,channel.Link,channel.LastBuildDate,channel.Generator).Scan(&rssid)
	if err !=nil {
		err =tx.Rollback()
		return atomtmp, err
	}
	for key,value := range channel.Items{
		_,err = tx.Exec("insert into rssdatasub(title,link,pubdate,description,createtim,rssdataid) values($1,$2,$3,$4,$5,$6)",value.Title,value.Link,value.Pubdate,value.Description,time.Now(),rssid)
	}
	_,err = tx.Exec("")
	fmt.Print(testxml)
	txml := response.Rss{}
	txml.RssData = testxml.RssData
	return txml,nil
}