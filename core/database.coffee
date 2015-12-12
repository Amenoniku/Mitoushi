mongoose = require('./libs/mongoose')
Glyph = require('./modelsDB/glyph').Glyph
async = require 'async'

open = (callback) ->
	mongoose.connection.on "open", callback

dropDatabase = (callback) ->
	db = mongoose.connection.db
	db.dropDatabase callback

requireModels = (callback) ->
	require './modelsDB/glyph'
	async.each Object.keys(mongoose.models), (modelName, callback) ->
		mongoose.models[modelName].ensureIndexes callback
	, callback

createUsers = (callback) ->
	glyph = [{
		glyph: "一"
		romaji: "ichi"
		JLPT: "5"
		glyphKey: "1 - 一"
		quanLine: "1"
		extraLine: "0"
		value: "один"
		onYomi: [
					"イチ, ichi, целый, весь, единый (в сочетаниях)"
					"イツ, itsu, целый, весь, единый (в сочетаниях)"
				]
		kunYomi: [
					"一つ, hitotsu, 1) один, одна, одно"
				]
	},{
		glyph: "人"
		romaji: "hito"
		JLPT: "5"
		glyphKey: "9 - 人（イ）"
		quanLine: "2"
		extraLine: "0"
		value: "человек"
		onYomi: [
					"ニン nin (в соч. счётный суфф. для людей)"
					"ジン jin (в соч. счётный суфф. национальности)"
				]
		kunYomi: [
					"人 ひと hito 1) человек, люди 2) другой; другие"
					"人の ひとの hitono чужой"
					"人々 ひとびと hitobito люди, народ"
					"人々 にんにん ninnin каждый [человек]"
				]
		images: 
			static: ["../images/hito0.gif",
					"../images/hito1.gif"]
	}]
	async.each glyph, (glyphData, callback) ->
		glyph = new Glyph glyphData
		glyph.save callback
	, callback

async.series [
	open
	dropDatabase
	requireModels
	createUsers
], (err, result) ->
	console.log arguments
	mongoose.disconnect