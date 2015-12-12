form = document.forms.newGlyph
if form
	form.addEventListener "submit", (e) ->
		do e.preventDefault
		readings = @.querySelectorAll ".kanjiReading"
		for i in readings
			if not i.value
				i.parentNode.removeChild i
		xhr = new XMLHttpRequest
		xhr.onreadystatechange = ->
			if @readyState != 4
				return
			res = JSON.parse @responseText
			if res.message
				if res.message.indexOf("duplicate key") != -1
					alert "Первые 2 поля должны быть уникальны"
				if res.message.indexOf("validation failed") != -1
					alert "Поля должны быть заполнены. И хватить баловаться с HTML куллхацкеры"
			else
				alert res.success
		xhr.open "POST", "/modKanji/add"
		xhr.setRequestHeader "X-Requested-With", "XMLHttpRequest"
		formData = new FormData document.forms.newGlyph
		xhr.send formData
		# xhr.timeout = 3000
	
	form.addEventListener "click", (event) ->
		target = event.target
		if target.id == "addVal"
			preElem = target.previousSibling
			if preElem.parentNode.getElementsByTagName("input").length > 19 then return
			oldType = preElem.getAttribute "type"
			oldName = preElem.getAttribute "name"
			newInp = document.createElement "input"
			newInp.setAttribute "type", oldType
			newInp.setAttribute "name", oldName
			newInp.classList.add "kanjiReading"
			newInp.classList.add "form-control"
			preElem.parentNode.insertBefore newInp, target
	