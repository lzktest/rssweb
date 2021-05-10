package utils

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"time"
)

func GetData(){
	tr := &http.Transport{
		MaxIdleConns:       10,
		IdleConnTimeout:    30 * time.Second,
		DisableCompression: true,
	}
	client := &http.Client{Transport: tr}
	resp, err := client.Get("https://example.com")
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	fmt.Print(string(body))
}