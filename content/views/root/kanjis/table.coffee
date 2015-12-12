React = require "react"
reactDOM = require "reactDOM"
KanjiCard = require "./card"
changeKanji = require "./changekanji"

table = document.getElementById "allKanji"

renderGlyphs = (arr, tdCount) ->
	tr = table.querySelector "tr"
	arr.forEach (item, i, arr) ->
		glyph = item.glyph
		td = document.createElement "td"
		td.innerHTML = glyph
		if tr.getElementsByTagName("td").length > tdCount
			tr = document.createElement "tr"
			table.children[0].appendChild tr
			tr.appendChild td
		else
			tr.appendChild td
	table.addEventListener "click", (event) ->
		target = event.target
		return if target.tagName != "TD"
		for i in arr
			if i.glyph == target.textContent
				glyph = i
		React.render <KanjiCard glyph=glyph />, document.getElementById "card"
		do changeKanji

downloadGlyphs = (tdCount) ->
	if not table
		return
	xhr = new XMLHttpRequest
	xhr.onreadystatechange = ->
		if @readyState != 4
			return
		glyphs = JSON.parse @responseText
		renderGlyphs glyphs, tdCount
	xhr.open 'GET', "/renderKanji/all"
	xhr.setRequestHeader "X-Requested-With", "XMLHttpRequest"
	xhr.send()

module.exports = downloadGlyphs