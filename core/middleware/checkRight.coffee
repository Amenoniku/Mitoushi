User = require("../modelsDB/user").User
HttpError = require("../error").HttpError


module.exports = (req, res, next) ->
	if req.session.user
		User.findById req.session.user, (err, user) ->
			return next err if err
			switch user.right
				when "SuperAdmin"
					do next
				when "admin"
					do next
				when "newbie"
					return next new HttpError 403, "Недостаточно прав"
				else
					return next new HttpError 403, "У вас пролеммы с аккаунтом обратитесь к администратору"
	else
		return next new HttpError 401, "Вы не авторизированы"
