'use strict';

angular.module('bd.sockjs', [])
  .value('SockJS', window.SockJS)
  .provider('socketFactory', function () {

    // expose to provider
    this.$get = function (SockJS, $timeout) {

      var asyncAngularify = function (socket, callback) {
        return callback ? function () {
          var args = arguments;
          $timeout(function () {
            callback.apply(socket, args);
          }, 0);
        } : angular.noop;
      };

      return function socketFactory (options) {
        options = options || {};
        var socket = options.socket || null;
		var handlers={};
		var events={};
		var isRegHandler=false;
        var wrappedSocket = {
	      open:function(){
		      if(socket){
			      socket.close();
			      socket=null;
		      }
			  socket=new SockJS(options.url);
			  for(var lab in events){
				 socket[lab]=function(e){
		             for(var l in events['on'+e.type]){
			             events['on'+e.type][l](e);
		             }
	             }
			  }
		  },
		  close: function () {
            return socket.close.apply(socket, arguments);
          },
		  send: function () {
            return socket.send.apply(socket, arguments);
          },
          addHandler:function(h,callback){
	         if(!handlers[h]){
		        handlers[h]=[];
	         }
			 handlers[h][handlers[h].length]=asyncAngularify(socket, callback);
			 if(!isRegHandler){
				 this.setEvent('message',function(e){
					  	var o=JSON.parse(e.data);
			         	if(handlers.hasOwnProperty(o.handler)){
				   		    if(handlers[o.handler])
				         	for(var lab in handlers[o.handler]){
					         	handlers[o.handler][lab](o.value);
				         	}
			         	}
				 });
				 isRegHandler=true;
			 }
			 return this;
          },
          removeHandler:function(handler){
	          delete handlers[handler];
	          return this;
          },
          setEvent: function (event, callback) {
	         var e='on' + event;
	         if(!events[e]){
		        events[e]=[];
	         }
            events[e][events[e].length] = asyncAngularify(socket, callback);
            if(socket&&!socket[e]){
	             socket[e]=function(e){
		             for(var l in events['on'+e.type]){
			             events['on'+e.type][l](e);
		             }
	             }
            }
            return this;
          },
          removeEvent: function(event) {
            delete events['on' + event];
            if(socket) delete socket['on' + event];
            return this;
          }
        };

        return wrappedSocket;
      };
    };

    this.$get.$inject = ['SockJS', '$timeout'];

  });
