<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>GoodsManager</title>
</head>
<body>
    <div id="goods_tool" style="padding:5px">
        <div style="margin:0 0 5px 0">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="goods_tool.add();">add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="goods_tool.edit();">edit</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="goods_tool.delete();">delete</a>
        </div>
    </div>
    <form id="goods_add" style="padding: 5px; color:#333;">
        <p>GoodsName<input type="text" name="gname" class="textbox"></p>
        <p>price<input type="text" name="price" class="textbox"></p>
        <p>stock<input type="text" name="stock" class="textbox"></p>
        <!--<p>GoodsDescription<input type="text" name="gdesc" class="textbox"></p>-->
        <p><label>Description:</label></p>
        <textarea name="gdesc" cols="30" rows="10"></textarea>
    </form>
    <form id="goods_edit" style="padding: 5px; color:#333;">
        <input type="hidden" name="gid">
        <p>GoodsName<input type="text" name="gname_edit" class="textbox"></p>
        <p>price<input type="text" name="price_edit" class="textbox"></p>
        <p>stock<input type="text" name="stock_edit" class="textbox"></p>
        <!--<p>GoodsDescription<input type="text" name="gdesc_edit" class="textbox"></p>-->
        <p><label>Description:</label></p>
        <textarea name="gdesc_edit" cols="30" rows="10"></textarea>
    </form>
    <table id="goods"></table>

    <script src="../js/goodsManager.js"></script>
</body>
</html>