$( function () {
    $("#manager").datagrid({
        url:"../ctrl/manager_data.php",
        fit:true,
        fitColumns:true,
        striped:true,
        rownumbers:true,
        border:false,
        pagination:true,
        pageSize:10,
        pageList:[10,20,30],
        pageNumber:1,
        sortName:"id",
        sortOrder:'desc',
        toolbar:"manager_tool",
        columns:[[
            {
                field:"id",
                title:"ID",
                width:150,
                checkbox: true,
            },
            {
                field:"username",
                title:"name",
                width:150,
            },
            {
                field:"auth",
                title:"authority",
                width:150,
            },
            {
                field:"level",
                title:"userLevel",
                width:150,
            },
        ]]
    });

    $("#auth").combotree({
        url:"../ctrl/nav.php",
        lines:true,
        required:true,
        multiple:true,
        checkbox:true,
        onlyLeafCheck:true,
        onLoadSuccess: function(node, data){
            var that = this;
            if(data){
                $(data).each(function(index, value){
                    if (this.state == "closed"){
                        $(that).tree("expandAll");
                    }
                });
            }
        },
    });

    $("#manager_add").dialog({
        width:400,
        // height:600,
        title:"add_manage",
        modal:true,
        closed:true,
        buttons:[
            {
                text:"submit",
                iconCls:"icon-add",
                handler:function(){
                    if($("#manager_add").form('validate')){
                        $.ajax({
                            url:"../ctrl/add_manager.php",
                            type:"POST",
                            data:{
                                "username":$("input[name='username']").val(),
                                "password":$("input[name='password']").val(),
                                "auth":$("#auth").combotree("getText"),
                            },
                            beforeSend:function(){
                                $.messager.progress({
                                    text:"is sendning..."
                                });
                            },
                            success:function(data, response, status){
                                $.messager.progress("close");
                                if (data>0){
                                    // location.href="admin.php";
                                    $.messager.show({
                                        title:"inform",
                                        msg:"add_manager operation successfully",
                                    });
                                    $("#manager_add").dialog("close").form("reset");
                                    $("#manager").datagrid("reload");
                                } else {
                                    $.messager.alert("add failed", "unknown error!");
                                    // $("#password").select();
                                }
                            }
                        });
                    }
                },
            },
            {
                text:"cancel",
                iconCls:"icon-redo",
                handler:function(){
                    $("#manager_add").dialog("close").form("reset");
                },
            },
        ]
    });

    $("#manager_edit").dialog({
        width:400,
        // height:600,
        title:"edit_manage",
        modal:true,
        closed:true,
        buttons:[{
                text:"submit",
                iconCls:"icon-edit",
                handler:function(){
                    if($("#manager_edit").form('validate')){
                        $.ajax({
                            url:"../ctrl/edit_manager.php",
                            type:"POST",
                            data:{
                                id:$("input[name='id']").val(),
                                password_edit:$("input[name='password_edit']").val(),
                                // auth_edit:$("input[name='auth_edit']").val(),
                                auth_edit:$("#auth_edit").combotree("getText"),
                            },
                            beforeSend: function(){
                                $.messager.progress({
                                    text:"is editing...",
                                });
                            },
                            success: function(data, response, status){
                                $.messager.progress("close");
                                if(data>0){
                                    $.messager.show({
                                        title:"inform",
                                        msg:"edit manager successfully!"
                                    });
                                    $("#manager_edit").dialog("close").form("reset");
                                    $("#manager").datagrid("reload");
                                }else{
                                    $.messager.alert("error", "unknown error or no change!");
                                }
                            }
                        });
                    }
                },
            },
            {
                text:"cancel",
                iconCls:"icon-redo",
                handler:function(){
                    $("#manager_edit").dialog("close").form("reset");
                },
            }],
    });

    manager_tool = {
        add : function(){
            $("#manager_add").dialog("open");
        },
        edit: function(){
            var rows = $("#manager").datagrid("getSelections");
            if (rows.length > 1) {
                alert("no more than one selection");
            } else if (rows.length == 1) {
                $.ajax({
                        url:"../ctrl/get_manager.php",
                        type:"POST",
                        data:{
                            id:rows[0].id,
                        },
                        beforeSend:function(){
                            $.messager.progress({
                                text:"is getting..."
                            });
                        },
                        success:function(data, response, status){
                            $.messager.progress("close");
                            if (data){
                                data = $.parseJSON(data);
                                var auth = data[0].auth.split(",");
                                // console.log(data[0]);alert(auth);
                                $("#manager_edit").form("load", {
                                    id:data[0].id,
                                    username_edit:data[0].username,
                                    password_edit:data[0].password,
                                    // auth_eidt:data[0].auth,
                                }).dialog("open");
                                // $("#manager_edit").dialog('open');
                                $("#auth_edit").combotree({
                                    url:"../ctrl/nav.php",
                                    lines:true,
                                    required:true,
                                    multiple:true,
                                    checkbox:true,
                                    onlyLeafCheck:true,
                                    onLoadSuccess: function(node, data){
                                        var that = this;
                                        if(data){
                                            $(data).each(function(index, value){
                                                if ($.inArray(value.text, auth)!=-1 ){
                                                    $(that).tree("check", value.target);
                                                }
                                                if (this.state == "closed"){
                                                    $(that).tree("expandAll");
                                                }
                                            });
                                        }
                                    },
                                });
                            } else {
                                $.messager.alert("get data failed", "unknown error!");
                            }
                        }
                    });
            } else {
                confirm("at least one selections");
            }
        }, 
        delete: function(){
            var rows = $("#manager").datagrid("getSelections");
            if(rows.length > 0){
                $.messager.confirm("confirm delete", "Are you sure you want to delete them?", function(flag){
                    if(flag){
                        var ids = [];
                        for(var i=0; i<rows.length; i++){
                                ids.push(rows[i].id);
                            }
                            $.ajax({
                                url:"../ctrl/delete_manager.php",
                                type:"POST",
                                data:{
                                    ids: ids.join(","),
                                },
                                beforeSend: function(){
                                    $.messager.progress({
                                        text:"is deleting...",
                                    });
                                },
                                success: function(data, response, status){
                                    $.messager.progress("close");
                                    if(data>0){
                                        $.messager.show({
                                            title:"inform",
                                            msg: data + " managers was deleted successfully!"
                                        });
                                        // $("#manager_edit").dialog("close").form("reset");
                                        $("#manager").datagrid("reload");
                                        $("#manager").datagrid("unselectAll");
                                    }else{
                                        $.messager.alert("error", "unknown error!");
                                    }
                                }
                            });
                    }
                });    
            }else{
                $.messager.alert("error", "choose what you want to be deleted, pls.", "info");
            }
        },
    };

   $("input[name='username']").validatebox({
       required:true,
       missingMessage:"not allow blank username!",
       invalidMessage:"invalid username",
   });
   $("input[name='password']").validatebox({
       required:true,
       validType:"length[3,30]",
       missingMessage:"not allow blank password!",
       invalidMessage:"invalid password",
   });
   $("input[name='password_edit']").validatebox({
       validType:"length[3,30]",
       missingMessage:"no blank password!",
       invalidMessage:"invalid password",
   });
   if(!$("input[name='username']").validatebox("isValid")){
       $("input[name='username']").focus();
   } else if(!$("input[name='password']").validatebox("isValid")){
       $("input[name='password']").focus();
   }

});