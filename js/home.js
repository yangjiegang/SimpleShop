//leftsidebar
$(function(){
	var myUlDiv = $("#myUl");
	//var myUl = myul.find("ul");
	myUlDiv.css("display","none");
	function navPosition(){
		var navTop = myUlDiv.offset().top;
		if(navTop<150){
			myUlDiv.css("display","none");
		}else{
			myUlDiv.css("display","block");
		}
		var resArray = new Array();
		resArray[1] = $("div.main>ul").eq(0).offset().top;
		resArray[2] = $("div.main>ul").eq(1).offset().top;
		resArray[3] = $("div.main>ul").eq(2).offset().top;
		resArray[4] = $("div.main>ul").eq(3).offset().top;
		resArray[5] = $("div.main>ul").eq(4).offset().top;
		resArray[6] = $("div.main>ul").eq(5).offset().top;
		resArray[7] = $("div.main>ul").eq(6).offset().top;
/*		resArray[1] = $("#ula").offset().top;
		resArray[2] = $("#ulb").offset().top;
		resArray[3] = $("#ulc").offset().top;*/
		for(i in resArray){
			if(resArray[i]<navTop && navTop<resArray[i]+100){
				//console.log(navTop+"+"+resArray[3]);
				$("#myUl ul li a").css("background-color","black");
				$("#myUl ul li:nth-child("+i+") a").css("background-color","red");
			}else if(navTop>resArray[7]+200){
				myUlDiv.css("display","none");
			}
		}
	}
	$(window).scroll(navPosition);
});
//rightsidebar
var gLi = $(".rightsidebar>ul.list-group>li");
var uLi = $(".rightsidebar>ul.list-unstyled>li");
var index = 0;
gLi.bind("mouseover",function(){
	index = $(this).index();
	$(this).css("opacity","0");
	uLi.eq(index).css("opacity","1");
	uLi.eq(index).siblings().css("opacity","0");
});
gLi.bind("mouseout",function(){
	index = $(this).index();
	$(this).css("opacity","1");
	uLi.eq(index).css("opacity","0");
});
uLi.bind("mouseover",function(){
	index = $(this).index();
	$(this).css("opacity","1");
	gLi.eq(index).css("opacity","0");
});
uLi.bind("mouseout",function(){
	index = $(this).index();
	$(this).css("opacity","0");
	gLi.eq(index).css("opacity","1");
});
var flag = true;
uLi.click(
	function()
	{	
		index = $(this).index();
		if (flag==true)
		{
			var aHtml = "<div class='module md-"+index+"'><p>content here.</p></div>";
			$(".rightsidebar").append(aHtml);
			flag = false;
		}
		else if(flag==false)
		{
			try
			{
				if($(".md-"+index).length>0)
				{
					$(".md-"+index).remove();
					flag=true;
				}
				else
				{
					flag=false;
				}

			}catch(err)
			{
				console.log(err.message);
			}
		}
		else
		{
			return false;
		}
	}
);