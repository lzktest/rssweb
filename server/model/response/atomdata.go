package response

import (
	"server/model"
)

type Atom struct {
	//Link1  xml.EndElement  `xml:"link"`
	//Link1attr1 string `xml"href",attr`
	model.AtomData
}
