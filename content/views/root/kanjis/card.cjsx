React = require "react"
reactDOM = require "reactDOM"

KanjiCard = React.createClass
	displayName: "KanjiCard"
	render: ->
		glyph = @props.glyph
		<div id="kanji-card", className="kanji-card">
			<p className="close", onClick={@handleCloseClick}>✗</p>
			<aside id="left", className="left">
				<div className="field">
					<img src={glyph.images.static[0]} alt={glyph.glyph} />
				</div>
				<div className="info">
					<div className="field">
						<h4 data-val="glyph">Иероглиф</h4>
						<p>{glyph.glyph}</p>
					</div>
					<div className="field">
						<h4 data-val="JLPT">Уровень JLPT</h4>
						<p>{glyph.JLPT}</p>
					</div>
					<div className="field">
						<h4 data-val="glyphKey">Иероглиф ключ</h4>
						<p>{glyph.glyphKey}</p>
					</div>
					<div className="field">
						<h4 data-val="value">Значение</h4>
						<p>{glyph.value}</p>
					</div>
					<div className="field">
						<h4 data-val="quanLine">Количество черт</h4>
						<p>{glyph.quanLine}</p>
					</div>
					<div className="field">
						<h4 data-val="extraLine">Доп. черты</h4>
						<p>{glyph.extraLine}</p>
					</div>
				</div>
				<div className="field">
					<img src={glyph.images.static[1]} alt={glyph.glyph} />
				</div>
			</aside>
			<aside className="right">
				<div className="field">
					<h3 data-val="onYomi">Он ёми</h3>
					{glyph.onYomi.map (yomi) ->
						<p>{yomi}</p>}
				</div>
				<div className="field">
					<h3 data-val="kunYomi">Кун ёми</h3>
					{glyph.kunYomi.map (yomi) ->
						<p>{yomi}</p>}
				</div>
				<div className="field" className="phrases">
					<h3>Cловосочетание</h3>
					<p>test</p>
					<p>test</p>
				</div>
			</aside>
			<p id="glyphId", hidden>{glyph._id}</p>
		</div>
	handleCloseClick: (e) ->
		node = e.target.parentNode
		node.parentNode.removeChild node

module.exports = KanjiCard