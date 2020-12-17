package config

// type Mysql struct {
// 	Path         string `mapstructure:"path" json:"path" yaml:"path"`
// 	Config       string `mapstructure:"config" json:"config" yaml:"config"`
// 	Dbname       string `mapstructure:"db-name" json:"dbname" yaml:"db-name"`
// 	Username     string `mapstructure:"username" json:"username" yaml:"username"`
// 	Password     string `mapstructure:"password" json:"password" yaml:"password"`
// 	MaxIdleConns int    `mapstructure:"max-idle-conns" json:"maxIdleConns" yaml:"max-idle-conns"`
// 	MaxOpenConns int    `mapstructure:"max-open-conns" json:"maxOpenConns" yaml:"max-open-conns"`
// 	LogMode      bool   `mapstructure:"log-mode" json:"logMode" yaml:"log-mode"`
// 	LogZap       bool   `mapstructure:"log-zap" json:"logZap" yaml:"log-zap"`
// }

type Pg struct {
	Host         string `mapstructure:"host" json:"host" yaml:"host"`
	User         string `mapstructure:"user" json:"user" yaml:"user"`
	Password     string `mapstructure:"password" json:"password" yaml:"password"`
	Dbname       string `mapstructure:"dbname" json:"dbname" yaml:"dbname"`
	Port         string `mapstructure:"port" json:"port" yaml:"port"`
	SslMode      string `mapstructure:"sslmode" json:"sslmode" yaml:"sslmode"`
	TimeZone     string `mapstructure:"timezone" josn:"timezone" yaml:"timezone"`
	MaxIdleConns int    `mapstructure:"max-idle-conns" json:"maxIdleConns" yaml:"max-idle-conns"`
	MaxOpenConns int    `mapstructure:"max-open-conns" json:"maxOpenConns" yaml:"max-open-conns"`
	LogMode      bool   `mapstructure:"log-mode" json:"logMode" yaml:"log-mode"`
	LogZap       bool   `mapstructure:"log-zap" json:"logZap" yaml:"log-zap"`
}
