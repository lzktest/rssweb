module server

go 1.15

require (
	github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751
	github.com/casbin/casbin v1.9.1
	github.com/casbin/casbin/v2 v2.20.0
	github.com/dgrijalva/jwt-go v3.2.0+incompatible
	github.com/fsnotify/fsnotify v1.4.9
	github.com/fvbock/endless v0.0.0-20170109170031-447134032cb6 // indirect
	github.com/gin-gonic/gin v1.6.3
	github.com/go-pg/pg v8.0.7+incompatible
	github.com/go-redis/redis v6.15.9+incompatible
	github.com/google/uuid v1.1.2
	github.com/jackc/pgx v3.6.2+incompatible
	github.com/lestrrat-go/file-rotatelogs v2.4.0+incompatible
	github.com/lestrrat-go/strftime v1.0.3 // indirect
	github.com/lib/pq v1.9.0
	github.com/lzktest/casbinpgandadapter v1.0.1
	github.com/mojocn/base64Captcha v1.3.1
	github.com/satori/go.uuid v1.2.0
	github.com/spf13/viper v1.7.1
	github.com/swaggo/gin-swagger v1.3.0
	github.com/swaggo/swag v1.7.0
	github.com/unrolled/secure v1.0.8
	go.uber.org/zap v1.10.0
	gorm.io/driver/mysql v1.0.3
	gorm.io/driver/postgres v1.0.5
	gorm.io/gorm v1.20.8
	mellium.im/sasl v0.2.1 // indirect
)

replace casbinpgandadapter => github.com/lzktest/casbinpgandadapter v1.0.0
