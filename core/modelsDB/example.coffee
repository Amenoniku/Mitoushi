mongoose = require "../libs/mongoose"
async = require "async"
util = require "util"
HttpError = require("../error").HttpError

Schema = mongoose.Schema

schema = new Schema
	# Example schema
	# glyph:
	# 	type: String
	# 	unique: on
	# 	required: on

# schema.statics.go = (glyph, next) ->
# 	Glyph = @.
# 	fields = new Glyph glyph
# 	fields.save (err) ->
# 		if err
# 			do next new SaveError err.message
# 		do next

# exports.Glyph = mongoose.model("Glyph", schema)

class SaveError
	constructor: (message) ->
		Error.apply @, arguments
		Error.captureStackTrace @, SaveError
		@message = message

util.inherits SaveError, Error

exports.SaveError = SaveError