'use strict';

var autoprefixer = require('gulp-autoprefixer'),
    combineMq = require('gulp-combine-mq'),
    gulp = require('gulp'),
    csso = require('gulp-csso'),
    sass = require('gulp-sass'),
    sprite = require('gulp-svg-sprite'),
    watch = require('gulp-watch');

//
// Config

// Sass

var sassConfig = {
    precision: 10
};

// SVG

var svgConfig = {
    dest: '.',
	mode: {
		symbol: {
            dest: '.',
            sprite: './icons.symbol.svg'
        }
	}
};

// Autoprefixer

var autoPrefixerConfig = {
    browsers: ['last 3 versions']
};

//
// Sass task

gulp.task('sass', function(){

    return gulp.src('./assets/scss/**/*.scss')
        .pipe(sass(sassConfig))
        .pipe(autoprefixer(autoPrefixerConfig))
        .pipe(combineMq())
        .pipe(csso())
        .pipe(gulp.dest('./assets/css/'));

});

//
// SVG task

gulp.task('svg', function(){

    return gulp.src('./assets/icons/input/*.svg')
        .pipe(sprite(svgConfig))
        .pipe(gulp.dest('./assets/icons/output/'));

});

//
// Default task

gulp.task('default', ['sass', 'svg'], function(){

    gulp.watch('./assets/scss/**/*.scss', function(){

        gulp.start('sass');

    });

});