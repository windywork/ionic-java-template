'use strict';
var gulp = require('gulp');
var env = require('gulp-util').env;
var log = require('gulp-util').log;
var jshint = require('gulp-jshint');
var rename = require('gulp-rename');
var concat = require('gulp-concat');
var minifyCss = require('gulp-minify-css');
var sass = require('gulp-sass');
var uglify = require('gulp-uglify');
var ngmin = require('gulp-ngmin');
var stripDebug = require('gulp-strip-debug');
/*定义目录*/
var paths = {
  ionicLibJs: ['www/src/lib/ionic/js/ionic.js', 
    	'www/src/lib/ionic/js/angular/angular.js',
    	'www/src/lib/ionic/js/angular/angular-animate.js',
    	'www/src/lib/ionic/js/angular/angular-sanitize.js',
    	'www/src/lib/ionic/js/angular-ui/angular-ui-router.js',
    	'www/src/lib/ionic/js/ionic-angular.js'],
   ionicLibScss:['www/src/lib/ionic/scss/ionic.scss'],
   referLibJs:[
		'www/src/lib/hprose/hprose-html5.js', 
    	'www/src/lib/hprose/angular.hprose.js',
    	'www/src/lib/ngCordova/ng-cordova.js',
    	'www/src/lib/sockjs/sockjs.min.js',
    	'www/src/lib/sockjs/angular.sockjs.js'
   ],
   appJs:[
	    	'www/src/js/config.js', 
	    	'www/src/js/services.js',
	    	'www/src/js/app.js', 
	    	'www/src/js/filter.js',
	    	'www/src/js/directive.js',
	    	'www/src/js/routers.js',
	    	'www/src/js/controllers/*.js'
   ],
   appCss: 'www/src/css/*.css'
};

/*生成ionic类库*/
gulp.task('buildIonicLib', function(done) {
     gulp.src(paths.ionicLibScss)
    .pipe(sass({
      errLogToConsole: true
    }))
    .pipe(minifyCss({
      keepSpecialComments: 0
    }))
    .pipe(rename({ extname: '.min.css' }))
    .pipe(gulp.dest('./www/css/'));
    

    gulp.src(paths.ionicLibJs).pipe(uglify())
        .pipe(concat('ionic.bundle.min.js'))
        .pipe(gulp.dest('./www/js/'));
});

/*生成第三方类库*/
gulp.task('buildReferLib', function(done) {
     gulp.src(paths.referLibJs)
     	.pipe(uglify())
        .pipe(concat('refer.lib.min.js'))
        .pipe(gulp.dest('./www/js/'));
});

/*编译项目*/
gulp.task('buildAppCode', function(){
  log('Linting Files');
  gulp.src(paths.appCss)
	.pipe(minifyCss({
		keepSpecialComments: 0
	})).pipe(concat('app.min.css'))
	.on( 'error', function(e){console.log(e)})
	.pipe(gulp.dest('./www/css/'));
	
  	gulp.src(paths.appJs)
        //.pipe(ngmin({dynamic: false}))
        //.pipe(stripDebug())
        //.pipe(uglify({outSourceMap: false}))
        .pipe(concat('app.min.js'))
        .pipe(gulp.dest('./www/js/'));
});



gulp.task('watch', function(){
  log('Watching Files');
  gulp.watch(paths.appJs, ['buildAppCode']);
});

gulp.task('default', ['buildIonicLib','buildReferLib','buildAppCode', 'watch']);

var taskToRun = env.dev ? 'default' : 'buildAppCode';

gulp.start(taskToRun);