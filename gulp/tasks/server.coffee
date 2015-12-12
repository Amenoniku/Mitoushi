gulp = require "gulp"
gutil = require "gulp-util"
browserSync = require("browser-sync").create()

gulp.task "server", ->
	browserSync.init
		files: ["core/**/*", "content/**/*"]
		open: !!gutil.env.open
		reloadOnRestart: true
		port: gutil.env.port or 9000
		proxy: "localhost:8000"
		tunnel: !!gutil.env.tunnel