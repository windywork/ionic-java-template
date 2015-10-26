var app=angular.module('starter', ['ionic', 'starter.controllers','ngCordova','bd.sockjs','bd.hprose']).run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if (window.StatusBar) {
      StatusBar.styleLightContent();
    }
  });
}).factory('$socket' , function(socketFactory,$state,$rootScope,$ionicLoading,$ionicPopup,$timeout,$cordovaLocalNotification){
   var factory=socketFactory({url:config.socket_uri});
    factory.setEvent('open',function() {
	    console.log('socket open..');
	});
	factory.setEvent('error',function(e){
		 $ionicLoading.show({ template: '网络错误',duration:2000,noBackdrop:true});
	});
	factory.setEvent('close',function(){
	     $ionicLoading.show({ template: '网络断开',duration:2000,noBackdrop:true});
	});
   return factory;
}).factory('$hprose', function (hproseFactory) {
   return hproseFactory({
    	apis: window.hprose_apis
  	});
});
