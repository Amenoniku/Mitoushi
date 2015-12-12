express    = require "express"
router     = do express.Router
multiparty = require "multiparty"
fs         = require "fs"
pathModule = require "path"
Glyph      = require("../modelsDB/glyph").Glyph
SaveError  = require("../modelsDB/glyph").SaveError
HttpError  = require("../error").HttpError
User       = require("../modelsDB/user").User
checkRight = require "../middleware/checkRight"

router.route "/"
	.get checkRight, (req, res, next) ->
		res.render "addkanji", title: "Добавление Иероглифов"

router.route "/add"
	.post checkRight, (req, res, next) ->
		contentType = req.headers["content-type"]
		if contentType and contentType.indexOf("multipart") != 0
			do next
		form = new multiparty.Form()
		form.parse req, (err, fields, files) ->
			return next err if err
			for k, v of files
				v.forEach (item, i, arr) ->
					if item.originalFilename == ""
						delete arr[i]
			count = 0
			extraArr = []
			for k, v of files
				v.forEach (item, i, arr) ->
					newName = fields.romaji.join() + (count + "") + pathModule.extname item.path
					path = "public/images/#{newName}"
					myPath = path.slice path.indexOf("/images")
					extraArr.splice i, 1, myPath
					count++
					return
				fields[k] = extraArr
			Glyph.go fields, (err) ->
				if err
					if err instanceof SaveError
						return next new HttpError 402, err.message
					else
						return next err
				count = 0
				for k, v of files
					v.forEach (item, i, arr) ->
						newName = fields.romaji.join() + (count + "") + pathModule.extname item.path
						path = "public/images/#{newName}"
						file = fs.createReadStream decodeURIComponent item.path
						out = fs.createWriteStream path
						file.pipe out
						file.on "error", (err) ->
							console.error err
						res.on "close", ->
							do file.destroy
						count++
				res.send {"success"}
		return

router.route "/change"
	.post checkRight, (req, res, next) ->
		form = new multiparty.Form()
		form.parse req, (err, fields, files) ->
			return next err if err
			fileName = Object.keys(files)[0]
			if files.hasOwnProperty fileName
				files[fileName].forEach (item, i, arr) ->
					if pathModule.extname item.path
						file = fs.createReadStream decodeURIComponent item.path
						out = fs.createWriteStream "public/images#{fileName}"
						console.log file.path
						file.pipe out
						file.on "error", (err) ->
							console.error err
						res.on "close", ->
							do file.destroy
			id = fields.id.join()
			Glyph.findByIdAndUpdate id, fields, (err, field) ->
				next err if err
				if not field
					return do next
				res.send "Изменение сохранены."

router.route "/remove"
	.post checkRight, (req, res, next) ->
		id = req.body.id
		Glyph.findById id, (err, glyph) ->
			next err if err
			glyph.remove (err, glyph) ->
				next err if err
				glyph.images.static.forEach (item, i, arr)->
					fs.unlink "./public#{item}", (err) ->
						next err if err
				res.redirect "/"

module.exports = router