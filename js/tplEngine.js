//$(document).ready(function(e){
//$(function(){
    function html_decode(str){
    var s = "";
    if (str.length == 0) return "";
    s = str.replace(/&lt;/g, "<");
    s = s.replace(/&gt;/g, ">");
    s = s.replace(/\n/g, "");
    return s;
    }

    var TemplateEngine = function(html, options) {
        var re = /<%([^%>]+)?%>/g, reExp = /(^( )?(if|for|else|switch|case|break|{|}))(.*)?/g, code = 'var r=[];\n', cursor = 0;
        var add = function(line, js) {
            js? (code += line.match(reExp) ? line + '\n' : 'r.push(' + line + ');\n') :
                (code += line != '' ? 'r.push("' + line.replace(/"/g, '\\"') + '");\n' : '');
            return add;
        }
        while(match = re.exec(html)) {
            add(html.slice(cursor, match.index))(match[1], true);
            cursor = match.index + match[0].length;
        }
        add(html.substr(cursor, html.length - cursor));
        code += 'return r.join("");';
        return new Function(code.replace(/[\r\t\n]/g, '')).apply(options);
    }

    function doTpl(data){
        var template = $("body").html();
        //console.log(template);
        //$("body>div").empty();
        $("body").html("");
        //var template = template.text();
        var tpl = html_decode(template);
/*        var data = {
            skills: ["js", "html", "css"],
            showSkills: true
        };*/
        var result = TemplateEngine(tpl,data);
        $("body").append(result);
    }
//});