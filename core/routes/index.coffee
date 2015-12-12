express = require('express')
router = express.Router()

### GET home page. ###

router.get "/", (req, res, next) ->
	res.render "root", title: "Главная"

router.get "/test", (req, res, next) ->
	res.render "test"

module.exports = router