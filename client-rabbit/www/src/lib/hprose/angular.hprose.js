'use strict';

angular.module('bd.hprose', [])
  .value('HproseHttpClient', window.hprose.HttpClient)
  .provider('hproseFactory', function () {

    // expose to provider
    this.$get = function (HproseHttpClient, $timeout,$ionicLoading) {

      var asyncAngularify = function (obj,args,callback) {
        return callback ? function () {
          $timeout(function () {
            callback.apply(obj, args);
          }, 0);
        } : angular.noop;
      };

      return function hproseFactory (options) {
        options = options || {};
        var apis = options.apis || {};
	
        var md = {
		  apis:apis,
		  runing:{},
          call: function (m,args,callback,scope,loading) {
	          var _then=this;
	          var i=m.lastIndexOf('.');
	          var p=m.substring(0,i);
 			  var method=m.substring(i+1,m.length);

			  var client=null;
			  if(_then.runing[p]){
				  client=_then.runing[p];
			  }else{
			    console.debug('register service:'+_then.apis[p]);
				if(!_then.apis[p]){
				   console.error('api not find.');
			    }
				client=new HproseHttpClient(_then.apis[p]);  
				_then.runing[p]=client;
			  }
			  console.debug('call method -'+method+':\n'+JSON.stringify(args));
    		  args.unshift(method);
			  args.push(function(result) {//error
				    if(loading)$ionicLoading.hide();
				   asyncAngularify(scope?scope:_then,[result],callback)();
			  });
			  args.push(function(name, err) {
				    if(loading)$ionicLoading.hide();
				    console.error('call '+name+' method error - '+JSON.stringify(err));
			  });
			  
			  if(loading){
				  $ionicLoading.show({ template: '正在加载数据..'});
			  }
				
			  client.invoke.apply(null, args);
			 
              return this;
          }
        };

        return md;
      };
    };

    this.$get.$inject = ['HproseHttpClient', '$timeout','$ionicLoading'];

  });
