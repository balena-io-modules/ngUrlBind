# Find plugins at https://npmjs.org/browse/keyword/gulpplugin
gulp = require 'gulp'
coffee = require 'gulp-coffee'
wrapUMD = require 'gulp-wrap-umd'
replace = require 'gulp-replace'

gulp.task 'build', ->
	# huge hack alert: before writing ngUrlBind.js,
	# we have to replace 'root.jsurl' with 'root.JSURL'
	# as jsurl publishes itself differently to global
	# and differently to npm, which isn't anticiated
	# by the UMD wrapper.

	gulp.src('src/ngUrlBind.coffee')
	.pipe(coffee(bare: true))
	.pipe(wrapUMD(
			namespace: 'ngUrlBind'
			deps: ['angular','jsurl']
	))
	.pipe(replace(',root.jsurl);', ',root.JSURL);'))
	.pipe(gulp.dest('./dist/'));

# The default task (called when you run `gulp`)
gulp.task 'default', ->
	gulp.run 'build'

	# Watch files and run tasks if they change
	gulp.watch [
		'src/ngUrlBind.coffee'
	], (event) ->
		gulp.run 'build'
