gulp = require "gulp"
gulpif = require "gulp-if"
jade = require "gulp-jade"
cached = require "gulp-cached"
plumber = require "gulp-plumber"
rename = require "gulp-rename"
prettify = require "gulp-html-prettify"
paths = require "../paths"
inheritance = require "gulp-jade-inheritance"

data = 
	timestamp: +new Date

gulp.task "jade", ->
	gulp.src "content/views/layout-default/*.jade"
		.pipe do plumber
		.pipe cached "jade"
		.pipe gulpif global.watch, inheritance basedir: "content"
		.pipe jade data: data
		.pipe prettify
			brace_style: "expand"
			indent_size: 1
			indent_char: "\t"
			indent_inner_html: true
			preserve_newlines: true
		.pipe rename dirname: "."
		.pipe gulp.dest paths.dist