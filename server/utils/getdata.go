package utils

import (
	"encoding/xml"
	"fmt"
	"io/ioutil"
	"net/http"
	"server/model/response"
	"time"
)

func GetData(){
	tr := &http.Transport{
		MaxIdleConns:       10,
		IdleConnTimeout:    30 * time.Second,
		DisableCompression: true,
	}
	client := &http.Client{Transport: tr}
	resp, _ := client.Get("http://vdaily.iu.vc/old-weekly.xml")
	defer resp.Body.Close()
	body, _ := ioutil.ReadAll(resp.Body)
	//fmt.Print(string(body))
	testxml := response.Channel{}
	xml.Unmarshal(body,&testxml)
	fmt.Print(testxml)
}