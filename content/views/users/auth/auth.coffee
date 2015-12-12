"use strict"

if not window.fetch
	require "fetch"
	require "promise"

form = document.getElementById "formAuth"

if form then form.addEventListener "submit", (event) ->
	do event.preventDefault
	fetch("/users/auth"
		method: @method
		body: new FormData @
		credentials: "include"
	).then (res) ->
		if res.status != 200
			return alert "Ошибка. Статус Код: #{res.status}"
		do res.text
	.then (text) ->
		if text == "success"
			window.location.replace "/"
		else
			alert text
	.catch (err) ->
		alert err