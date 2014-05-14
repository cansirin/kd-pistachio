gulp        = require 'gulp'
util        = require 'gulp-util'
coffee      = require 'gulp-coffee'
replace     = require 'gulp-replace'
rename      = require 'gulp-rename'
browserify  = require 'browserify'
coffeeify   = require 'coffeeify'
source      = require 'vinyl-source-stream'

coffee4Node = -> (coffee bare: yes, sourceMap: yes).on 'error', util.log

gulp.task 'build', ->
  gulp.src './src/kd-pistachio/*.coffee'
    .pipe coffee4Node()
    .pipe replace '.coffee', '.js'
    .pipe gulp.dest './lib/kd-pistachio'

gulp.task 'browserify', ->
  browserify
    entries     : ['./src/kd-pistachio/kd-pistachio.coffee']
    debug       : yes
  .require './src/kd-pistachio/kd-pistachio.coffee', expose: 'kd-pistachio'
  .transform 'coffeeify'
  .bundle()
  .pipe source 'kd-pistachio.coffee'
  .pipe rename 'kd-pistachio.js'
  .pipe gulp.dest 'browser'

gulp.task 'default', ['build', 'browserify']
