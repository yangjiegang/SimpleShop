<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>manager</title>
</head>
<body>
    <div id="manager_tool" style="padding:5px">
        <div style="margin:0 0 5px 0">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="manager_tool.add();">add</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="manager_tool.edit();">edit</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="manager_tool.delete();">delete</a>
        </div>
    </div>
    <form id="manager_add" style="padding: 5px; color:#333;">
        <p>username<input type="text" name="username" class="textbox"></p>
        <p>password<input type="text" name="password" class="textbox"></p>
        <p>authority<input type="text" name="auth" id="auth" class="textbox"></p>
    </form>
    <form id="manager_edit" style="padding: 5px; color:#333;">
        <input type="hidden" name="id">
        <p>username<input type="text" name="username_edit" class="textbox" disabled></p>
        <p>password<input type="text" name="password_edit" class="textbox"></p>
        <p>authority<input type="text" name="auth_edit" id="auth_edit" class="textbox"></p>
    </form>
    <table id="manager"></table>

    <script src="../js/manager.js"></script>
</body>
</html>