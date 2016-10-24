$(function () {
   $("#login").dialog({
       title:"login",
       width:300,
       height:180,
       iconCls:"icon-refresh",
       modal:true,
       buttons:"#btn",
   }); 
   $("#username").validatebox({
       required:true,
       missingMessage:"not allow blank username!",
       invalidMessage:"invalid username",
   });
   $("#password").validatebox({
       required:true,
       validType:"length[3,30]",
       missingMessage:"not allow blank password!",
       invalidMessage:"invalid password",
   });
   if(!$("#username").validatebox("isValid")){
       $("#username").focus();
   } else if(!$("#password").validatebox("isValid")){
       $("#password").focus();
   }
   $('#btn a').click(function(){
        if(!$("#username").validatebox("isValid")){
            $("#username").focus();
        } else if (!$("#password").validatebox("isValid")){
            $("#password").focus();
        } else {
            //alert("submitting");
            $.ajax({
                url:"../ctrl/checkLogin.php",
                type:"POST",
                data:{
                    "username":$("#username").val(),
                    "password":$("#password").val(),
                },
                beforeSend:function(){
                    $.messager.progress({
                        text:"is logining..."
                    });
                },
                success:function(data, response, status){
                    $.messager.progress("close");
                    if (data>0){
                        location.href="admin.php";
                    } else {
                        $.messager.alert("login failed", "username or password wrong!");
                        $("#password").select();
                    }
                }
            });
        }
   });
});