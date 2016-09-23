$( function () {
    $("#goods").datagrid({
        url:"../ctrl/goods_data.php",
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
        sortOrder:'asc',
        toolbar:"goods_tool",
        columns:[[
            {
                field:"id",
                title:"GoodsID",
                width:50,
                checkbox: true,
            },
            {
                field:"gname",
                title:"GoodsName",
                width:150,
            },
            {
                field:"stock",
                title:"stock",
                width:50,
            },
            {
                field:"price",
                title:"price",
                width:100,
            },
            {
                field:"gdesc",
                title:"goods description",
                width:350,
            },
        ]]
    });

    $("#goods_add").dialog({
        width:400,
        // height:600,
        title:"add_goods",
        modal:true,
        closed:true,
        buttons:[
            {
                text:"submit",
                iconCls:"icon-add",
                handler:function(){
                    if($("#goods_add").form('validate')){
                        $.ajax({
                            url:"../ctrl/add_goods.php",
                            type:"POST",
                            data:{
                                "gname":$("input[name='gname']").val(),
                                "price":$("input[name='price']").val(),
                                "stock":$("input[name='stock']").val(),
                                "gdesc":$("textarea[name='gdesc']").val(),
                            },
                            beforeSend:function(){
                                $.messager.progress({
                                    text:"is adding goods..."
                                });
                            },
                            success:function(data, response, status){
                                $.messager.progress("close");
                                if (data>0){
                                    // location.href="admin.php";
                                    $.messager.show({
                                        title:"inform",
                                        msg:"add_goods operation successfully",
                                    });
                                    $("#goods_add").dialog("close").form("reset");
                                    $("#goods").datagrid("reload");
                                } else {
                                    $.messager.alert("add goods failed", "unknown error!");
                                    // $("#price").select();
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
                    $("#goods_add").dialog("close").form("reset");
                },
            },
        ]
    });

    $("#goods_edit").dialog({
        width:400,
        // height:600,
        title:"edit_goods",
        modal:true,
        closed:true,
        buttons:[{
                text:"submit",
                iconCls:"icon-edit",
                handler:function(){
                    if($("#goods_edit").form('validate')){
                        $.ajax({
                            url:"../ctrl/edit_goods.php",
                            type:"POST",
                            data:{
                                gid:$("input[name='gid']").val(),
                                gname_edit:$("input[name='gname_edit']").val(),
                                price_edit:$("input[name='price_edit']").val(),
                                stock_edit:$("input[name='stock_edit']").val(),
                                gdesc_edit:$("textarea[name='gdesc_edit']").val(),
                            },
                            beforeSend: function(){
                                $.messager.progress({
                                    text:"is editing goods...",
                                });
                            },
                            success: function(data, response, status){
                                $.messager.progress("close");
                                if(data>0){
                                    $.messager.show({
                                        title:"inform",
                                        msg:"edit goods successfully!"
                                    });
                                    $("#goods_edit").dialog("close").form("reset");
                                    $("#goods").datagrid("reload");
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
                    $("#goods_edit").dialog("close").form("reset");
                },
            }],
    });

    goods_tool = {
        add : function(){
            $("#goods_add").dialog("open");
        },
        edit: function(){
            var rows = $("#goods").datagrid("getSelections");
            if (rows.length > 1) {
                alert("no more than one goods could be selection");
            } else if (rows.length == 1) {
                $.ajax({
                        url:"../ctrl/get_goods.php",
                        type:"POST",
                        data:{
                            id:rows[0].id,
                        },
                        beforeSend:function(){
                            $.messager.progress({
                                text:"is getting data of goods..."
                            });
                        },
                        success:function(data, response, status){
                            $.messager.progress("close");
                            if (data){
                                data = $.parseJSON(data);
                                // var auth = data[0].auth.split(",");
                                // console.log(data[0]);alert(auth);
                                $("#goods_edit").form("load", {
                                    "id":data[0].id,
                                    "gname_edit":data[0].gname,
                                    "price_edit":data[0].price,
                                    "stock_edit":data[0].stock,
                                    "gdesc_edit":data[0].gdesc,
                                    // auth_eidt:data[0].auth,
                                }).dialog("open");
            // console.log($("textarea[name='gdesc_edit']").val());
            //  console.log($("textarea[name='gdesc_edit']").text());
                            } else {
                                $.messager.alert("get goods data failed", "unknown error!");
                            }
                        }
                    });
            } else {
                confirm("at least one goods selections");
            }
        }, 
        delete: function(){
            var rows = $("#goods").datagrid("getSelections");
            if(rows.length > 0){
                $.messager.confirm("confirm delete", "Are you sure you want to delete them?", function(flag){
                    if(flag){
                        var ids = [];
                        for(var i=0; i<rows.length; i++){
                                ids.push(rows[i].id);
                            }
                            $.ajax({
                                url:"../ctrl/delete_goods.php",
                                type:"POST",
                                data:{
                                    ids: ids.join(","),
                                },
                                beforeSend: function(){
                                    $.messager.progress({
                                        text:"is deleting goods...",
                                    });
                                },
                                success: function(data, response, status){
                                    $.messager.progress("close");
                                    if(data>0){
                                        $.messager.show({
                                            title:"inform",
                                            msg: data + " goods was deleted successfully!"
                                        });
                                        // $("#goods_edit").dialog("close").form("reset");
                                        $("#goods").datagrid("reload");
                                        $("#goods").datagrid("unselectAll");
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

   $("input[name='gname']").validatebox({
       required:true,
       missingMessage:"not allow blank gname!",
       invalidMessage:"invalid gname",
   });
   $("input[name='price']").validatebox({
       required:true,
       validType:"length[1,10]",
       missingMessage:"not allow blank price!",
       invalidMessage:"invalid price",
   });
   $("input[name='stock']").validatebox({
       required:true,
       validType:"length[1,10]",
       missingMessage:"not allow blank stock!",
       invalidMessage:"invalid price",
   });
   $("input[name='gdesc']").validatebox({
       required:true,
       validType:"length[10,100]",
       missingMessage:"not allow blank description!",
       invalidMessage:"invalid price",
   });

   if(!$("input[name='gname']").validatebox("isValid")){
       $("input[name='gname']").focus();
   } else if(!$("input[name='price']").validatebox("isValid")){
       $("input[name='price']").focus();
   } else if(!$("input[name='stock']").validatebox("isValid")){
       $("input[name='stock']").focus();
   } else if(!$("input[name='gdesc']").validatebox("isValid")){
       $("input[name='gdesc']").focus();
   } else {

   }

});