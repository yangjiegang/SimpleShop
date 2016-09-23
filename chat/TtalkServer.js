var express = require('express'),
    app = express(),
    server = require('http').createServer(app),
    io = require('socket.io').listen(server);

//specify the html we will use
app.use('/', express.static(__dirname));

server.listen(3000);//for local test

var Set = function(){
    this.arr = [];
}
Set.prototype={
    add:function(x){
        var flag=true;
        for (var i = this.arr.length - 1; i >= 0; i--) {
            if(this.arr[i]==x){
                flag=false;
                break;
            }
        }
        if(flag==true){
            this.arr.push(x);
        }
        return flag;
    },
    size:function(){
        return this.arr.length;
    },
    get:function(i){
        return this.arr[i];
    },
}

var nameSet = new Set();
nameSet.add("robot");
var sktList={};

//handle the socket
io.sockets.on('connection', function(socket) {

	socket.on("login",function(nickname){
		if(nameSet.add(nickname)==true){
			sktList[nickname]=socket;
            socket.nickname=nickname;
            socket.usrIndex = sktList.length;
			io.sockets.emit('loginSuccess', nameSet);//confirm the connection
		}else if (nameSet.add(nickname)==false) {
			socket.emit('loginFailed',nickname);//send back nameSet
		}

	});
	//p2p message
	socket.on("p2pMsg", function(from, dest, msg){
		for (nickname in sktList) {
			if(nickname==dest){
				sktList[nickname].emit("p2pMsg", from, msg);
			}
		}
	});
    //new image get
    socket.on('p2pImg', function(from, dest, imgData) {
		for (nickname in sktList) {
			if(nickname==dest){
				sktList[nickname].emit("p2pImg", from, imgData);
			}
		}
    });
    socket.on("disconnect", function() {
        for(nickname in sktList){
            if (nickname == socket.nickname) {
                sktList[nickname]=null;
            }
        }
        io.sockets.emit("logout", socket.nickname);
    });
});