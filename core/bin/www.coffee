# !/usr/bin/env node
###*
# Module dependencies.
###

app = require "../app"
debug = require("debug")("VWSK:server")
http = require "http"
config = require "../config"

###
# Normalize a port into a number, string, or false.
###

normalizePort = (val) ->
	`var port`
	port = parseInt(val, 10)
	if isNaN(port)
		# named pipe
		return val
	if port >= 0
		# port number
		return port
	false

###
# Event listener for HTTP server "error" event.
###

onError = (error) ->
	if error.syscall != "listen"
		throw error
	bind = if typeof port == "string" then "Pipe " + port else "Port " + port
	# handle specific listen errors with friendly messages
	switch error.code
		when "EACCES"
			console.error bind + " requires elevated privileges"
			process.exit 1
		when "EADDRINUSE"
			console.error bind + " is already in use"
			process.exit 1
		else
			throw error
	return

###
# Event listener for HTTP server "listening" event.
###

onListening = ->
	addr = server.address()
	bind = if typeof addr == "string" then "pipe " + addr else "port " + addr.port
	debug "Listening on " + bind
	return

app.set "port", port

###
# Create HTTP server.
###

server = http.createServer(app)

###
# Get port from environment and store in Express.
###

port = normalizePort process.env.PORT or config.get "port" or "8000"

###
# Listen on provided port, on all network interfaces.
###

server.listen port
server.on "error", onError
server.on "listening", onListening
