express      =                 require "express"
path         =                    require "path"
favicon      =           require "serve-favicon"
logger       =                  require "morgan"
cookieParser =           require "cookie-parser"
bodyParser   =             require "body-parser"
errorhandler =            require "errorhandler"
session      =         require "express-session"
config       =                require "./config"
mongoose     =         require "./libs/mongoose"
HttpError    =      require("./error").HttpError
routes       =          require "./routes/index"
routes       =          require "./routes/index"
modKanji     =       require "./routes/modKanji"
renderKanji  =    require "./routes/renderKanji"
users        =          require "./routes/users"

### Пример для БД ###
require "./database"

app = do express

### view engine setup###
app.set "views", path.join(__dirname, "../content/views")
app.set "view engine", "jade"

### Static folder ###
app.use express.static path.join __dirname, "public"

### Favion ###
app.use favicon path.join __dirname, "public", "favicon.ico"

### Loggong ###
app.use logger "dev"

### Form parser ###
app.use do bodyParser.json
app.use bodyParser.urlencoded extended: on

### Sessions ###
app.use do cookieParser
sessionStore = require "./libs/sessionSrote"
app.use session
	secret: config.get "session:secret"
	key: config.get "session:key"
	cookie: config.get "session:cookie"
	saveUninitialized: true
	resave: true
	store: sessionStore

### My middleware ###
app.use require "./middleware/sendHttpError"
app.use require "./middleware/loadUser"

### Routes ###
app.use "/", routes
app.use "/modKanji", modKanji
app.use "/renderKanji", renderKanji
app.use "/users", users

### Error 404 ###
app.use (req, res, next) ->
	error = 
		message: "Страница не найдена."
		status: 404
		title: 404
	res.render "error", error

### Error handler ###
app.use (err, req, res, next) ->
	if typeof err == "number"
		err = new HttpError(err)
	if err instanceof HttpError
		res.sendHttpError err
	else
		if app.get("env") == "development"
			errorhandler() err, req, res, next
		else
			console.log error err
			err = new HttpError(500)
			res.sendHttpError err
	return

module.exports = app