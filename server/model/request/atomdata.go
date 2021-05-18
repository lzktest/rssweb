package request

import "time"

type Xml struct {
	Feed string `xml:"feed"`
	Title string  `xml:"title"`
	Subtitle string  `xml:"subtitle"`
	Id  string   `xml:"id"`
	Updated time.Time `xml:"updated"`
	rights  string  `xml:"rights"`
	Entrys  []Entry	`xml:"entry"`
}

type Entry struct{
	Title string	`xml:"title"`
	Id    string    `xml:"id"`
	Published time.Time `xml:"published"`
	Updated   time.Time  `xml:"updated"`
	Author   Author `xml:"author"`
	context  string `xml:"context"`

}
type Author struct{
	Name   string `xml:"Name"`
	Uri    string `xml:"uri"`
}