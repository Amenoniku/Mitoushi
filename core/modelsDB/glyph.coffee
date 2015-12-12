mongoose = require "../libs/mongoose"
async = require "async"
util = require 'util'
HttpError = require('../error').HttpError

Schema = mongoose.Schema

schema = new Schema
	glyph:
		type: String
		unique: on
		required: on
	romaji:
		type: String
		unique: on
		required: on
	JLPT:
		type: String
		required: on
	glyphKey:
		type: String
		required: on
	quanLine:
		type: String
		required: on
	extraLine:
		type: String
		required: on
	value:
		type: String
		required: on
	onYomi:
		type: Array
	kunYomi:
		type: Array
	images:
		static:
			type: Array
		steps:
			type: Array


schema.statics.go = (glyph, next) ->
	Glyph = @
	fields = new Glyph glyph
	fields.save (err) ->
		if err
			do next new SaveError err.message
		do next

exports.Glyph = mongoose.model("Glyph", schema)

class SaveError
	constructor: (message) ->
		Error.apply @, arguments
		Error.captureStackTrace @, SaveError
		@message = message

util.inherits SaveError, Error

exports.SaveError = SaveError