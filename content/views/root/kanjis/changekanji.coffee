class ChangeKanji
	constructor: ->
		@icon = document.getElementById("modIcon").cloneNode no
		@form = document.forms.changeKanji.cloneNode on
		@formRemove = document.forms.remove.cloneNode on

	showIcon: (event) =>
		value = null
		target = event.target
		while target != document.getElementById "kanji-card"
			if target.className == "field"
				target.appendChild @icon
				@icon.addEventListener "click", @showForm
				return
			target = target.parentNode

	showForm: (event) =>
		@form.addEventListener "submit", @submitForm
		value = null
		target = event.target
		allP = target.parentNode.getElementsByTagName "p"
		allImg = target.parentNode.getElementsByTagName("img")[0]
		inps = @form.getElementsByTagName "input"
		if inps.length != 0
			for i in inps
				@form.removeChild inps[0]
		target.parentNode.appendChild @form
		@form.style.top = @form.parentNode.firstChild.offsetHeight + "px"
		if target.parentNode.children[0].tagName == "IMG"
			@form.style.top = 0
			inp = document.createElement "input"
			inp.type = "file"
			inp.name = @form.parentNode.firstChild.src.slice @form.parentNode.firstChild.src.lastIndexOf "/"
			@form.appendChild inp
			return
		for i in allP
			inp = document.createElement "input"
			inp.classList.add "kanjiReading"
			inp.type = "text"
			inp.name = @form.parentNode.firstChild.dataset.val
			inp.value = i.innerHTML
			inp.style.top = i.previousSibling.offsetHeight + "px"
			@form.appendChild inp

	submitForm: (e) ->
		do e.preventDefault
		form = @
		_id = document.getElementById("_id").cloneNode no
		_id.value = document.getElementById("glyphId").innerHTML
		@.appendChild _id
		xhr = new XMLHttpRequest
		readings = @.querySelectorAll ".kanjiReading"
		for i in readings
			if not i.value
				@.removeChild i
		xhr.onreadystatechange = ->
			if @readyState != 4
				return
			if @responseText == "Изменение сохранены."
				form.removeChild _id
				inps = form.getElementsByTagName "input"
				allP = form.parentNode.getElementsByTagName "p"
				for i in [0...allP.length]
					if not inps[i]
						break
					allP[i].innerHTML = inps[i].value
				form.parentNode.removeChild form
				alert "Изменение сохранены."
		xhr.open "POST", "/modKanji/change"
		xhr.setRequestHeader "X-Requested-With", "XMLHttpRequest"
		formData = new FormData document.forms.changeKanji
		xhr.send formData

	remove: ->
		_id = document.getElementById("_id").cloneNode no
		_id.value = document.getElementById("glyphId").innerHTML
		console.log _id.value
		@formRemove.appendChild _id
		document.getElementById("kanji-card").appendChild @formRemove

checkRight = ->
	return if not document.getElementById "blockChangeKanji"
	card = document.getElementById "kanji-card"
	change = new ChangeKanji
	card.addEventListener "mouseover", change.showIcon
	do change.remove

module.exports = checkRight