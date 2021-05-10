package response

import (
	"time"
    "github.com/google/uuid"
)

// rss channel
type Channel struct {
	Title  string
	Link   string
	Description string
	Language    string
	Copyright   string
	WebMaster   string
	PubDate	    time.Time
	LastBuildDate  time.Time
	CateGory	string
	Generator   string
	Docs 		string
	Cloud		Cloud
	Ttl			int64
	Image		Image
	Rating		string
	Item		Item
}
//处理向云注册以获得频道更新的通知
type Cloud struct{
	Domain		string
	Port 		string
	Path 		string
	RegisterProcedure	string
	Protocol   	string
}
// 图片
type Image struct{
	Url  string
	Title string
	Link  string
	Width int
	Height int
	Description string
}
// item
type Item struct {
	Title string
	Link  string
	Description  string
	Author   string
	Category   string
	Comments   string
	Enclosure  string
	Guid       uuid.UUID
	Pubdate 	time.Time
	Source     string
}