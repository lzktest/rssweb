package model

import (
	"encoding/xml"
)

// rss channel
type RssData struct {
	XMLName  xml.Name `xml:"rss"`
	Version  string `xml:"version,attr"`
	ChannelRss ChannelRss `xml:-`
}
type ChannelNode struct {
	ChannelRss ChannelRss `xml:"channel"`
}
type ChannelRss struct {
	XMLName xml.Name `xml:"channel"`
	Title  string  `xml:"title" json:"title"`
	//Atom  Atomlink `xml:"atom"`
	Link   string	`xml:"link" json:"link"`
	Description string `xml:"description" json:"description"`
	Language    string  `xml:"language" json:"language"`
	Copyright   string  `xml:"copyright" json:"copyright"`
	WebMaster   string  `xml:"webmaster" json:"web_master"`
	PubDate	    string  `xml:"pubdate" json:"pub_date"`
	LastBuildDate  string `xml:"lastBuildDate" json:"lastBuildDate"`
	CateGory	string  `xml:"category" json:"cate_gory"`
	Generator   string  `xml:"generator" json:"generator"`
	Docs 		string  `xml:"docs" json:"docs"`
	Cloud		Cloud   `xml:"cloud" json:"cloud"`
	Ttl			int64   `xml:"ttl" json:"ttl"`
	Images		Image   `xml:"image" json:"image"`
	Rating		string  `xml:"rating" json:"rating"`
	Items		[]Item	`xml:"item" json:"item"`
}

type Atomlink struct {
	AtomType string `xml:"type,attr"`
}

//处理向云注册以获得频道更新的通知
type Cloud struct{
	Domain		string  `xml:"domain" json:"domain"`
	Port 		string  `xml:"port" json:"port"`
	Path 		string  `xml:"path" json:"path"`
	RegisterProcedure	string `xml:"registerprocedure" json:"register_procedure"`
	Protocol   	string  `xml:"protocol" json:"protocol"`
}
// 图片
type Image struct{
	Url  string `xml:"url" json:"url"`
	Title string `xml:"title" json:"title"`
	Link  string `xml:"link" json:"link"`
	Width int  `xml:"width" json:"width"`
	Height int  `xml:"height" json:"height"`
	Description string `xml:"description" json:"description"`
}
// item
type Item struct {
	Title string  `xml:"title" json:"title"`
	Link  string	`xml:"link" json:"link"`
	Description  string `xml:"description" json:"description"`
	Author   string   `xml:"author" json:"author"`
	Category   string  `xml:"category" json:"category"`
	Comments   string  `xml:"comments" json:"comments"`
	Enclosure  string  `xml:"enclosure" json:"enclosure"`
	Guid       string  `xml:"guid" json:"guid"`
	Pubdate    string  `xml:"pubDate" json:"pubDate"`
	Source     string  `xml:"source" json:"source"`
}

// rssdata
type RssDatas struct {
	Id string  `json:"id"`
	Xmltype string `json:"xmltype"`
	XmlTitle string `json:"xmltitle"`
	XmlDescription string `json:"xmldescription"`
	XmlLink string `json:"xmllink"`
	Status bool `json:"status"`
	CycleTime string `json:"cycletime"`
}
type RssDataList struct{
	RssDataLists []RssDatas `json:"rssDataList"`
}
type LoadRssDataList struct{
	LoadRssList []LoadRssList `json:"loadRssList"`
}
type LoadRssList struct{
	Title string `json:"title"`
	Type string `json:"type"`
	HtmlUrl string `json:"htmlUrl"`
	XmlUrl string `json:"xmlUrl"`
}