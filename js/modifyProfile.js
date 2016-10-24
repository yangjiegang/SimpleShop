jQuery(function(){
  var dat = { name: 'my name', description: 'short description' };
  var CutJson = {"name":"", "position":{}};
  $("#buttonUpload").click(function(){     
      //上传文件
    if ($("#fileToUpload").val().length > 0) {
        ajaxFileUpload();
    }
    else {
        alert("请选择图片");
    }

    function ajaxFileUpload() {
        $.ajaxFileUpload({
            url:'upload.php',//处理图片脚本
            secureuri :false,
            data: {data:dat},
            fileElementId :'fileToUpload',//file控件id
            dataType : 'JSON',
            success : function (data, status){                
                //$("#img1").attr("src", data);
                //alert("你请求的name是" + data.name + "     " + "你请求的description是:" + data.description);
                window.data = JSON.parse(data);  //data为接收方(receivePic.php)返回的数据，稍后描述         
        //此时开始对取回的数据处理出需要的图片名，宽高，并计算出原图比例尺，开始设定裁剪需要的计算量        
                //alert(data['img']);
                var orignW = window.data['width'],//存储原图的宽高，用于计算
                    orignH = window.data['height'],
                    //aspectRatio = JSON.parse(picFormat)[index].width/JSON.parse(picFormat)[index].height,//提前设定的裁剪宽高比，规定随后裁剪的宽高比例
                    aspectRatio = 0.7;
                    frameW = 260,  //原图的缩略图固定宽度，作为一个画布，限定宽度，高度自适应，保证了原图比例
                    frameH = 0,
                    prevFrameW = 140,  //预览图容器的高宽，宽度固定，高为需要裁剪的宽高比决定
                    prevFrameH = 140/aspectRatio,
                    rangeX   = 1,  //初始缩放比例
                    rangeY   = 1,
                    prevImgW = prevFrameW,  //初始裁剪预览图宽高
                    prevImgH = prevFrameW;
                //wrap = $("div#wrap");
                //cut = $("div#cutImg");
                //imgTar = wrap.find("#imgBack"),  //画布
                imgTar = $("#imgBack");
                imgCut = $("img.cutImg");//预览图         
                imgTar.attr("src",window.data.img);//显示已上传的图片，此时图片已在服务器上
                frameH = Math.round(frameW*orignH/orignW);//根据原图宽高比和画布固定宽计算画布高，即$imgTar加载上传图后的高。此处不能简单用.height()获取，有DOM加载的延迟
                $("div.preview").css('height',Math.round(prevFrameH)+"px");//设置裁剪后的预览图的容器高，注意此时的高度应由裁剪宽高比决定，而非原图宽高比
    //alert($("div.preview").html());
                imgCut.attr("src",imgTar.attr("src"));
        //准备存放图片数据的变量，便于传回裁剪坐标
                //CutJson = {"name":"", "position":{}};
                CutJson.name = window.data.filename;
                CutJson.position = {};
        //准备好数据后，开始配置imgAreaSelect使得图片可选区
                var imgArea = imgTar.imgAreaSelect({ //配置imgAreaSelect
                    instance: true,  //配置为一个实例，使得绑定的imgAreaSelect对象可通过imgArea来设置
                    handles: true,   //选区样式，四边上8个方框,设为corners 4个
                    fadeSpeed: 300, //选区阴影建立和消失的渐变
                    aspectRatio:'1:'+(1/aspectRatio), //比例尺 
                    onSelectChange: function(img,selection){//选区改变时的触发事件
                    /*selection包括x1,y1,x2,y2,width,height几个量，分别为选区的偏移和高宽。*/
                        rangeX   = selection.width/frameW;  //依据选取高宽和画布高宽换算出缩放比例
                        rangeY   = selection.height/frameH;
                        prevImgW = prevFrameW/rangeX; //根据缩放比例和预览图容器高宽得出预览图的高宽
                        prevImgH = prevFrameH/rangeY;
        //实时调整预览图预览裁剪后效果，可参见http://odyniec.net/projects/imgareaselect/ 的Live Example
                        imgCut.css({
                            'width' : Math.round(prevImgW)+"px",
                            'height' : Math.round(prevImgH)+"px",
                            'margin-left':"-"+Math.round((prevFrameW/selection.width)*selection.x1)+"px",
                            'margin-top' :"-"+Math.round((prevFrameH/selection.height)*selection.y1)+"px"
                         
                        });
                        //imgCut.attr("src",window.data.img);
                    },
                    onSelectEnd: function(img,selection){//放开选区后的触发事件
                        //计算实际对于原图的裁剪坐标
                        CutJson.position.x1 = Math.round(orignW*selection.x1/frameW);
                        CutJson.position.y1 = Math.round(orignH*selection.y1/frameH);
                        CutJson.position.width  = Math.round(rangeX*orignW);
                        CutJson.position.height = Math.round(rangeY*orignH);
                    }
                });

                $("#getCut").click(function(){
                    $.ajax({
                        type: "POST",
                        url : "cutPic.php",
                        data: { 'name':window.data.img, 'position':JSON.stringify(CutJson.position) },
                        success: function(dat){
                            //alert(dat);
                            imgTar.attr('src',dat); //裁剪成功传回生成的新图文件名，将结果图显示到页面
                        },
                        error: function(data, status, e){
                            alert(e);
                        }
                   });
                });

                if(typeof(data.error) != 'undefined'){
                    if(data.error != ''){
                        alert(data.error);
                    }else{
                        alert(data.msg);
                    }
                }
            },
            error: function(data, status, e){
                alert(e);
            }
        });
    }
    return false;
  });
});