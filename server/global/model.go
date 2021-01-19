package global

import (
	"database/sql"
	"time"
)
type GVA_MODEL struct {
	ID 	uint
	CreatedAt time.Time
	UpdatedAt time.Time
	DeletedAt sql.NullTime "json:-"
}
