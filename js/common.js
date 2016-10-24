$(".megamenu").megamenu();

if ($("#uid").text() !== "") {
	$("li").eq(2).hide();//登陆状态
	//$("li").eq(4).hide();
	$(".navbar-nav>h2>li").eq(2).hide();
	$(".navbar-nav h2 li").eq(4).hide();
} else {
	$("li").eq(3).hide();//匿名状态
	$("li").eq(4).hide();
	//$("td.action").css("display","none");
	//$("td.action>a").eq(2).hide();
	$("td.action").each(function (k, v) {
		$(this).find("a").eq(0).siblings().hide();
		//$(this).eq(2).hide();
	});
}

$(function () {
	$.ajax({
		url: "/PEMarket/ctrl/controler.php",
		type: "POST",
		data: {
			action: 'state',
		},
		success: function (callback) {
			// console.info(callback);
			if (callback === "") {
				confirm("login firstly pls.");
				// self.location.href="login.html";
			} else {
				$("div.cssmenu>ul>li").eq(3).find("a").text(callback);
			}
		},
		error: function (e) {
			console.error('e');
		}
	});
});

function getvl(name) {
	var reg = new RegExp("(^|\\?|&)" + name + "=([^&]*)(\\s|&|$)", "i");
	if (reg.test(location.href)) return unescape(RegExp.$2.replace(/\+/g, " "));
	return "";
}

$("input[name='search']").bind("click", function(){
	var search = this.value;
	// var search = $("input[name='search']").val();
	self.location.href="goodslist.html?search="+search;
});