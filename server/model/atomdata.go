package model

import (
	"encoding/xml"
	"time"
)

type AtomData struct {
	XMLName xml.Name `xml:"feed"`
	Xmlns string `xml:"xmlns,attr"`
	Title string  `xml:"title"`
	Subtitle string  `xml:"subtitle"`
	Link1  []Link  `xml:"link"`
	Id  string   `xml:"id"`
	Updated time.Time `xml:"updated"`
	Rights  string  `xml:"rights"`
	Entrys  []Entry	`xml:"entry"`
}

type Entry struct{
	Title string	`xml:"title"`
	Link string     `xml:"link"`
	Id    string    `xml:"id"`
	Published time.Time `xml:"published"`
	Updated   time.Time  `xml:"updated"`
	Author   Author `xml:"author"`
	Context  string `xml:"content"`

}
type Link struct{
	Rel  string `xml:"rel,attr"`
	Link1attr1 string `xml:"href,attr"`
}

type Author struct{
	Name   string `xml:"name"`
	Uri    string `xml:"uri"`
}