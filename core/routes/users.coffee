express = require('express')
router = express.Router()
multer = require "multer"
User = require('../modelsDB/user').User
AuthError = require('../modelsDB/user').AuthError
HttpError = require('../error').HttpError
checkRight = require '../middleware/checkRight'

upload = do multer

router.route "/"
	.get checkRight, (req, res, next) ->
		User.find {}, (err, users) ->
			next err if err
			renderVar = 
				title: "Пользователи"
				users: users
				superAdmin: no
			User.findById req.session.user, (err, user) ->
				next err if err
				if user.right == "SuperAdmin"
					renderVar.superAdmin = on
				res.render "users", renderVar

router.route "/auth"
	.get (req, res) ->
		res.render "users", title: "Логин", auth: on
	.post upload.array(), (req, res, next) ->
		username = req.body.username
		password = req.body.password
		console.log username, password
		User.authorize username, password, (err, user) ->
			if err
				if err instanceof AuthError
					return next new HttpError 403, err.message
				else
					return next err
			req.session.user = user._id
			res.send "success"

router.route "/logout"
	.post (req, res, next) ->
		req.session.destroy (err) ->
			next err if err
		res.redirect "auth"

router.post "/upright", (req, res, next) ->
	id = req.body.id
	fields = right: req.body.right
	User.findByIdAndUpdate id, fields, (err, field) ->
		next err if err
		res.redirect "auth"

router.route "/remove"
	.post checkRight, (req, res, next) ->
		id = req.body.id
		User.findById id, (err, user) ->
			next err if err
			user.remove (err, user) ->
				next err if err
				res.redirect ""

module.exports = router