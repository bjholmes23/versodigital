var path = require('path');
var gulp = require('gulp');
var less = require('gulp-less');
var serve = require('gulp-serve');
var inject = require('gulp-inject');
var uglify = require('gulp-uglify');
var concat = require('gulp-concat');
var wiredep = require('wiredep').stream;
var sourcemaps = require('gulp-sourcemaps');

function handleErrors(err) {
  console.error(err);
}

gulp.task('less', function () {
  return gulp.src('./src/less/style.less')
    .pipe(less({
      env: 'development',
      relativeUrls: false,
      paths: [ path.join(__dirname, 'less') ]
    }))
    .pipe(gulp.dest('./css'));
});

gulp.task('uglify', function () {
  return gulp.src(['./src/js/**/*.js'])
    .pipe(sourcemaps.init())
    .pipe(concat('scripts.js'))
    .pipe(uglify())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('./js'))
    .on('error', handleErrors);
});

gulp.task('inject', ['less', 'uglify'], function () {
  return gulp.src('./src/index.html')
    .pipe(wiredep({
      ignorePath:  /\.\.\//,
      exclude: ['bower_components/masonry', 'bower_components/outlayer']
    }))
    .pipe(inject(
      gulp.src(['./css/**/*.css', './js/*.js'], { read: false }), { addRootSlash: false }
    )).pipe(gulp.dest('./'));
});

gulp.task('serve', ['inject'], serve('./'));

gulp.task('default', ['serve']);
gulp.task('build', ['inject']);