package request

// paging common input parameter structur
type PageInfo struct {
	Page 	int `json:"page" from:"page"`
	PageSize int `json:"pageSize" from:"pageSize"`
}
