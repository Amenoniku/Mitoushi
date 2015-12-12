gulp = require "gulp"
runSequence = require "run-sequence"
browserSync = require "browser-sync"
reload = browserSync.reload

gulp.task "watch", ->
	global.watch = on

	gulp.watch "content/sprite/**/*.png", ["sprite"]

	gulp.watch "content/{styles,views}/**/*.styl", ["styles", ->
		reload "assets/styles/content.min.css"
		]

	gulp.watch "content/views/**/*.jade", reload
		# runSequence "jade",

	# gulp.watch "core/**/*", reload

	gulp.watch "content/resources/**/*", ["copy:resources", reload]
	gulp.watch "content/images/**/*", ["copy:images", reload]

	gulp.watch "content/**/*.{coffee,cjsx}", reload

	gulp.watch "content/icons/**/*.svg", ["svg", reload]