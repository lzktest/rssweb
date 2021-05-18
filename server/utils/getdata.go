package utils

import (
	"encoding/xml"
	//"fmt"
	"io/ioutil"
	"net/http"
	"server/model/request"
	"time"
)

func GetData()(atomtmp request.Xml, err error){
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
	testxml := request.Xml{}
	xml.Unmarshal(body,&testxml)
	//fmt.Print(testxml)
	return testxml,nil
	//output, _:=xml.MarshalIndent(testxml," ", "  ")
	//fmt.Print(string(output))
}