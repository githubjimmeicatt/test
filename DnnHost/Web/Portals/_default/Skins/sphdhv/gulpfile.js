'use strict';

/*

1.  Install Gulp globally:
    ----------------------------------------
    npm install -g gulp

2.  Install project dependencies:
    ----------------------------------------
    npm install (from Skins folder)

3.  Run default task
    ----------------------------------------
    gulp

*/

// Load plugins

var gulp			=	require('gulp');
var plumber         =   require('gulp-plumber');
var	sass			=	require('gulp-sass');
var watch           =   require('gulp-watch');

/**
 * Style tasks
 */

gulp.task('sass', function () {
	return gulp.src('./assets/scss/**/*.scss')
        .pipe(plumber())
		.pipe(sass())
		.pipe(gulp.dest('./assets/css/'));
});

// Default task

gulp.task('default', ['sass'], function(){
    
    // watch for sass changes
    
    watch('./assets/scss/**/*.scss', function(){
    
        gulp.start('sass');
    
    });
    
});