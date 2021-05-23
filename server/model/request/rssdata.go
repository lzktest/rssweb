package request

import (
	"server/model"
)

// rss channel
type Rss struct {
	model.RssData
}
type RssIdsReq struct {
	Ids []string `json:"ids" form:"ids"`
}