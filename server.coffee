express         = require 'express'
errorHandler    = require 'errorhandler'
http            = require "http"
path            = require "path"

routes = require "./routes"
CONFIG = require "./config.json"

app = express()

app.locals = CONFIG.views.vars

app.set "views", path.join __dirname, CONFIG.views.path
app.set "view engine", CONFIG.views.engine
app.use express.static path.join __dirname, CONFIG.publicPath

switch CONFIG.environment
    when "development"
        app.use errorHandler()

app.get '/', routes.index

server = http.createServer app
server.listen CONFIG.port, ()->
    console.log "Server listening @%s", CONFIG.port