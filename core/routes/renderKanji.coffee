express = require('express')
router = express.Router()
Glyph = require('../modelsDB/glyph').Glyph
ObjectID = require('mongodb').ObjectID


router.get "/all", (req, res, next) ->
	# if not req.headers["x-requested-with"]
	# 	return res.redirect "/"
	Glyph.find {}, (err, glyphs) ->
		next err if err
		res.format
			json: ->
				res.send glyphs

router.get "/:id", (req, res, next) ->
	# if not req.headers["x-requested-with"]
	# 	return res.redirect "/"
	try
		id = new ObjectID req.params.id
	catch e
		return do next
	Glyph.find id, (err, glyph) ->
		next err if err
		if not glyph[0]
			return do next
			res.format
				json: ->
					res.send glyph[0]

module.exports = router