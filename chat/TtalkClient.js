window.onload = function() {
    var logBtn = document.getElementById("logBtn");
    var usrBox = document.getElementById("usrBox");
    var sndBtn = document.getElementById("sndBtn");
    var msgInput = document.getElementById("msgInput");
    var msgPanel = document.getElementById("msgPanel");
    var destLable = document.getElementById("dest");
    var sendImage = document.getElementById('sendImage');
    var imgBtn = document.getElementsByClassName("imgBtn")[0];
    var robotP = document.getElementById("sysUsr").getElementsByTagName("p")[0];
    var tTalk = new TTalk();
    tTalk.init();
};

buyer = getvl("buyer");
seller = getvl("seller");

function boxTab() {
    var usrLst = $(".user");
    var winLst = $(".msgBox");
    usrLst.each(function(i) {
        $(this).bind("click", function() {
            winLst.eq(i).css("display", "block");
            winLst.eq(i).siblings().css("display", "none");
            $("#dest").text($(this).text());
        });
    });
}

function showBtn() {
    var logBtn = document.getElementById("logBtn");
    sndBtn.style.display = "block";
    logBtn.style.display = "none";
}

function colorTab(p, div) {
    if (div.style.display == "block") {
        p.style.background = "grey";
    } else if (div.style.display == "none") {
        p.style.background = "red";
    }
}

var TTalk = function() {
    this.socket = null;
    this.myName = null;
    this.nameSet = null;
};

TTalk.prototype = {
    init: function() {
        var that = this;
        var imgBtn = document.getElementsByClassName("imgBtn")[0];
        this.socket = io.connect();
        this.socket.on('connect', function() {
            console.log("connect to server successfully! login pls.");
        });

        this.socket.on('loginSuccess', function(nameSet02) {
            that.nameSet = nameSet02;
            usrBox.innerHTML = "";
            for (var i = 0; i < that.nameSet.arr.length; i++) {
                var nameP = document.createElement("P");
                nameP.className = "user";
                nameP.innerText = that.nameSet.arr[i];
                usrBox.appendChild(nameP);
                var msgBox = document.createElement("div");
                msgBox.className = "msgBox";
                msgBox.style.display = "none";
                msgPanel.appendChild(msgBox);
            }
            boxTab();
        });

        this.socket.on("loginFailed", function(nickname) {
            alert(nickname + " is existed!");
        });
        this.socket.on("p2pMsg", function(from, msg) {
            that.displayNewMsg(from, "me", msg, false);
        });
        this.socket.on('p2pImg', function(from, img) {
            that.displayImage(from, "me", img, false);
        });
        this.socket.on("logout", function(nickname) {
            console.log(nickname + " has logout!");
            for (var i = 0; i < that.nameSet.arr.length; i++) {
                if (nickname == that.nameSet.arr[i]) {
                    var msgBox = document.getElementsByClassName("msgBox")[i];
                    msgBox.style.display = "none";
                    var msgP = document.getElementsByClassName("user")[i];
                    msgP.style.display = "none";
                    that.nameSet.arr.splice(i, 1);
                    console.log(that.nameSet.arr);
                    return;
                }
            }
            boxTab();
        });

        sndBtn.onclick = function() {
            var destLable = document.getElementById("dest"); //be changed so that need defined again?
            var dest = destLable.innerText;
            var P2PMsg = msgInput.value;
            if (dest == "robot") {
                that.displayNewMsg(that.myName, dest, P2PMsg, true);
                that.robotClient(P2PMsg);
            } else {
                that.socket.emit("p2pMsg", that.myName, dest, P2PMsg);
                that.displayNewMsg(that.myName, dest, P2PMsg, true);
            }
            msgInput.value = "";
            return;
        };
        function autoLogin() {
            var nickname = buyer;
            that.socket.emit("login", nickname);
            document.title = 'TTalk | ' + nickname;
            that.myName = nickname;
            msgInput.value = "";
            showBtn(); //better to be execute after loginSuccess
            return;
        }

        function greeting() {
            var destLable = document.getElementById("dest"); //be changed so that need defined again?
            destLable.innerText = seller;
            var dest = seller;
            var P2PMsg = "Hello!";
            if (dest == "robot") {
                robotClient(P2PMsg);
            } else {
                that.socket.emit("p2pMsg", that.myName, dest, P2PMsg);
                that.displayNewMsg(that.myName, dest, P2PMsg, true);
            }
            msgInput.value = "";
            return;
        }
        autoLogin();
        greeting();
        
        imgBtn.onclick = function() {
            sendImage.click();
        };

        sendImage.addEventListener('change', function() {
            if (this.files.length !== 0) {
                var file = this.files[0];
                var reader = new FileReader();
                if (!reader) {
                    console.log('!your browser doesn\'t support fileReader');
                    this.value = '';
                    return;
                }
                reader.onload = function(e) {
                    this.value = '';
                    var dest = document.getElementById("dest").innerText;
                    that.socket.emit('p2pImg', that.myName, dest, e.target.result);
                    that.displayImage('me', dest, e.target.result, true);
                    msgInput.value = "";
                };
                reader.readAsDataURL(file);
            }
        }, false);
    },

    displayNewMsg: function(from, dest, message, isSnd) { //user to append
        var that = this;
        var newMsg = document.createElement("p");
        var pubTime = new Date().toTimeString().substr(0, 8);
        newMsg.innerHTML = from + " at " + pubTime + " to " + dest + " say: <br/>" + message;
        var index = 0;
        if (isSnd === true) { //send message
            for (var i = 0; i < that.nameSet.arr.length; i++) {
                if (that.nameSet.arr[i] == dest) {
                    index = i;
                }
            }
        } else if (isSnd === false) { //recieve message
            for (var j = 0; j < that.nameSet.arr.length; j++) {
                if (that.nameSet.arr[j] == from) {
                    index = j;
                }
            }
        }
        var msgBox = document.getElementsByClassName("msgBox")[index];
        msgBox.appendChild(newMsg);
        msgBox.scrollTop = msgPanel.scrollHeight;
        var msgP = document.getElementsByClassName("user")[index];
        setInterval(function() { colorTab(msgP, msgBox); }, 500);
    },
    displayImage: function(from, dest, imgData, isSnd) {
        var that = this;
        var msgToDisplay = document.createElement('p');
        var date = new Date().toTimeString().substr(0, 8);
        msgToDisplay.innerHTML = from + ' at ' + date + ' to ' + dest + ' say: <br/>' + '<a href="' + imgData + '" target="_blank"><img src="' + imgData + '"/></a>';

        var index = 0;
        if (isSnd === true) { //send message
            for (var i = 0; i < that.nameSet.arr.length; i++) {
                if (that.nameSet.arr[i] == dest) {
                    index = i;
                }
            }
        } else if (isSnd === false) { //recieve message
            for (var j = 0; j < that.nameSet.arr.length; j++) {
                if (that.nameSet.arr[j] == from) {
                    index = j;
                }
            }
        }
        var msgBox = document.getElementsByClassName("msgBox")[index];
        msgBox.appendChild(msgToDisplay);
        msgBox.scrollTop = msgBox.scrollHeight;
        var msgP = document.getElementsByClassName("user")[index];
        setInterval(function() { colorTab(msgP, msgBox); }, 500);
    },
    robotClient: function(message) {
        var that = this;
        $.ajax({
            url: "http://127.0.0.1:8080/PEMarket/chat/robotServer.php?",
            data: { "message": message },
            type: "GET",
            dataType: "jsonp",
            jsonp: "jsoncallback",
            crossDomain: true,
            success: function(jsonStr) {
                that.displayNewMsg("robot", "me", jsonStr, false);
            },
            error: function() {
                console.log('robot ajax error');
            },
        });
    }
};
