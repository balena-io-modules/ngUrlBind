# Find plugins at https://npmjs.org/browse/keyword/gulpplugin
gulp      = require 'gulp'
coffee    = require 'gulp-coffee'
wrapUMD   = require 'gulp-wrap-umd'
replace   = require 'gulp-replace'
markdown  = require 'gulp-markdown'
rename    = require 'gulp-rename'
header    = require 'gulp-header'

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

	gulp.src('README.md')
	.pipe(markdown())
	.pipe(header("<link href='http://kevinburke.bitbucket.org/markdowncss/markdown.css'' rel='stylesheet'></link>\n"))
	.pipe(rename('index.html'))
	.pipe(gulp.dest('./docs/'))

# The default task (called when you run `gulp`)
gulp.task 'default', ->
	gulp.run 'build'

	# Watch files and run tasks if they change
	gulp.watch [
		'src/ngUrlBind.coffee'
		'README.md'
	], (event) ->
		gulp.run 'build'
