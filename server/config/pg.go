package config

type Pg struct {
	Host         string `mapstructure:"host" json:"host" yaml:"host"`
	Port         string `mapstructure:"port" json:"port" yaml:"port"`
	Dbname       string `mapstructure:"dbname" json:"dbname" yaml:"dbname"`
	Username     string `mapstructure:"username" json:"username" yaml:"username"`
	Password     string `mapstructure:"password" json:"password" yaml:"password"`
	Sslmode      string `mapstructure:"sslmode" json:"sslmode" yaml:"sslmode"`
	Timezone     string `mapstructure:"timezone" json:"timezone" yaml:"timezone"`
	MaxIdleConns int    `mapstructure:"max-idle-conns" json:"maxIdleConns" yaml:"max-idle-conns"`
	MaxOpenConns int    `mapstructure:"max-open-conns" json:"maxOpenConns" yaml:"max-open-conns"`
	LogMode      bool   `mapstructure:"log-mode" json:"logMode" yaml:"log-mode"`
	LogZap       bool   `mapstructure:"log-zap" json:"logZap" yaml:"log-zap"`
}
