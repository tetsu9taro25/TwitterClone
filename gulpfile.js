/*jslint node: true */

/**
 * Plugins
 */
var gulp = require('gulp')
  , path = require('path')
  , rename = require('gulp-rename')
  , concat = require('gulp-concat')
  , uglify = require('gulp-uglify')
  , jshint = require('gulp-jshint')
  , stylish = require('jshint-stylish')
  , sass = require('gulp-sass')
  , coffee = require('gulp-coffee')
  , prefix = require('gulp-autoprefixer')
  , csslint = require('gulp-csslint')
  , htmlhint = require('gulp-htmlhint')
  , plumber = require('gulp-plumber')
  , notify = require('gulp-notify')
  , indirection = 'static';
/**
 * Paths
 */
var paths = {
  scripts: [
    indirection + '/**/_*.js'
  ],
  jshint: [
    'gulpfile.js',
    indirection + '/**/*.js',
    '!' + indirection + '/**/all.min.js',
    '!' + indirection + '/**/vendor/**/*.js',
    '!' + indirection + '/**/bootstrap/**/*.js'
  ],
  styles: [
    indirection + '/**/*.scss',
    '!' + indirection + '/**/_*.scss'
  ],
  htmlhint: [
    'tmpl/*.tx',
  ],
  watch: {
    styles: [
      indirection + '/**/*.scss'
    ],
    htmlhint: [
      'tmpl/*.tx',
    ]
  }
};

/**
 * Options
 */
var options = {
  scripts: {
    uglify: {
      preserveComments: 'some',
      outSourceMap: false
    }
  },
  styles: {
    sass: {
      paths: [indirection + '/**/scss']
    },
    prefix: ['> 1%', 'last 2 version', 'safari 5', 'ie 8', 'ie 9', 'ios 6', 'android 4']
  }
};

/**
 * Concatenate and minify scripts.
 */
gulp.task('scripts', function() {
  gulp
    .src(paths.scripts)
    .pipe(plumber())
    .pipe(concat('all.min.js'))
    .pipe(uglify(options.scripts.uglify))
    .pipe(gulp.dest(indirection + '/common/js/'));
});

/**
 * jshint
 */
gulp.task('jshint', function() {
  gulp
    .src(paths.jshint)
    .pipe(plumber())
    .pipe(jshint('.jshintrc'))
    .pipe(jshint.reporter(stylish))
    .pipe(jshint.reporter('fail'))
    .on('error', notify.onError("<%= error.message %>"));
});

/**
 * Compile scss and csslint.
 */
gulp.task('styles', function() {
  gulp
    .src(paths.styles)
    .pipe(plumber({errorHandler: notify.onError("<%= error.message %>")}))
    .pipe(sass(options.styles.sass))
    .pipe(prefix(options.styles.prefix))
    .pipe(rename(function(data) {
      data.dirname = path.join(data.dirname, '..', 'css');
    }))
    .pipe(gulp.dest(indirection + '/'))
    .pipe(csslint('.csslintrc'))
    .pipe(csslint.reporter());
});

/**
 * Htmlint
 */
gulp.task('htmlhint', function() {
  gulp
    .src(paths.htmlhint)
    .pipe(plumber())
    .pipe(htmlhint('.htmlhintrc'))
    .pipe(htmlhint.reporter())
    .pipe(htmlhint.failReporter())
    .on('error', notify.onError());
});

/**
 * Task dependencies.
 */
gulp.task('all', ['scripts', 'jshint', 'styles', 'htmlhint']);

/**
 * Watch.
 */
gulp.task('watch', function() {
  gulp.watch(paths.scripts, ['scripts']);
  gulp.watch(paths.jshint, ['jshint']);
  gulp.watch(paths.watch.styles, ['styles']);
  gulp.watch(paths.watch.html,['htmlhint']);
});

/**
 * Default task.
 */
gulp.task('default', ['watch']);
