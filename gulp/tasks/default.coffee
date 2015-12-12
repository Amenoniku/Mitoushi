gulp = require "gulp"
gutil = require "gulp-util"
runSequence = require "run-sequence"

gulp.task "stylesDependences", ->
	runSequence ["sprite", "icons", "styles"]

gulp.task "default", ["del", "watch"], ->
	runSequence [
			"stylesDependences",
			"jade",
			"scripts"
			"copy"
		], "server"

gulp.task "build", ["del"], ->
	gulp.start(
		"stylesDependences"
		"jade"
		"scripts"
		"copy"
	)