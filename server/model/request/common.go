package request

// paging common input parameter structur
type PageInfo struct {
	Page 	int `json:"page" from:"page"`
	PageSize int `json:"pageSize" from:"pageSize"`
}
// Find by id structure
type GetById struct {
	Id float64 `json:"id" form:"id"`
}

type IdsReq struct {
	Ids []int `json:"ids" form:"ids"`
}

type Empty struct{}