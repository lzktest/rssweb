package response

import (
	"time"
    "github.com/google/uuid"
)

// rss channel
type Rss struct {
	Title  string  `xml:"title" json:"title"`
	Link   string	`xml:"link" json:"link"`
	Description string `xml:"description" json:"description"`
	Language    string  `xml:"language" json:"language"`
	Copyright   string  `xml:"copyright" json:"copyright"`
	WebMaster   string  `xml:"webmaster" json:"web_master"`
	PubDate	    time.Time  `xml:"pubdate" json:"pub_date"`
	LastBuildDate  time.Time `xml:"lastbuilddate" json:"last_build_date"`
	CateGory	string  `xml:"category" json:"cate_gory"`
	Generator   string  `xml:"generator" json:"generator"`
	Docs 		string  `xml:"docs" json:"docs"`
	Cloud		Cloud   `xml:"cloud" json:"cloud"`
	Ttl			int64   `xml:"ttl" json:"ttl"`
	Image		Image   `xml:"image" json:"image"`
	Rating		string  `xml:"rating" json:"rating"`
	Item		Item    `xml:"item" json:"item"`
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
	Guid       uuid.UUID `xml:"guid" json:"guid"`
	Pubdate 	time.Time `xml:"pubdate" json:"pubdate"`
	Source     string  `xml:"source" json:"source"`
}