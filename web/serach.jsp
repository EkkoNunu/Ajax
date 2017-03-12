
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
    <style>
      #mydiv{
        position: absolute;
        left: 50%;
        top: 50%;
        margin-left: -100px;
        margin-top: -50px;
      }
      .mouseOver{
        background: #708090;
        color: #fffafa;
      }
      .mouseOut{
        background: #fffafa;
        color: #000000;
      }
    </style>

  </head>

  <body>
    <div id="mydiv">
      <input type="text" size="50" id="keyword" onkeyup="getMoreContents()" onblur="keywordBlur()" onfocus="getMoreContents()">
      <input type="button" value="百度一下" width="50px">
      <div id="popDiv">
        <table id="content_table" bgcolor="#fffafa" border="0" cellpadding="o" cellspacing="0">
          <tbody id="content_table_body">

          </tbody>
        </table>
      </div>
    </div>
  </body>
  <script type="text/javascript">
    var xmlHttp;
    function getMoreContents(){
      var content = document.getElementById("keyword");
      if (content.value == ""){
        clearContent();
      }
      // 向服务器发送用户输入内容，采用ajax异步发送，所以要用XmlHttp对象
      xmlHttp = createXMLHttp();
      //向服务器发送数据
      var url = "SearchServlet?keyword=" + content.value;
      //true表示JavaScript脚本会在send()方法之后继续执行，而不会等待来自服务器的相应
      xmlHttp.open("GET",url,true)
      //xmlHttp绑定一个回调方法，这个回调方法会在xmlHttp状态被改变的时候被调用
      //xmlHttp状态0-4，只关心4（complete）这个状态，当完成之后再调用回调方法才有意义

      xmlHttp.onreadystatechange = callback;
      xmlHttp.send(null);


    }

    function createXMLHttp() {
      //对于大多数浏览器都适用
      var xmlHttp;
      if(window.XMLHttpRequest){
        xmlHttp = new XMLHttpRequest();
      }
      if(window.ActiveXObject){
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        if(!xmlHttp){
          xmlHttp = new ActiveXObject("Msxml2.XMLHTTP")
        }
      }
      return xmlHttp;
    }

    //回调函数
    function callback() {
      if(xmlHttp.readyState == 4){
        if(xmlHttp.status == 200){
          //交互成功获得响应数据是文本形式
          var result = xmlHttp.responseText;
          var json = eval("("+result+")");
          // 动态的显示这些数据，把这些数据展示到输入框的下面

          setContent(json);
        }
      }
    }

    // 设置关联数据的展示
    function setContent(contents) {

      clearContent();

       setLocation();
      //关联数据的长度

      var size = contents.length;
      for(var i =0;i<size;i++){
        //json格式数据的第I个元素
        var nextNode = contents[i];
        var tr = document.createElement("tr");
        var td = document.createElement("td");
        td.setAttribute("border","0");
        tr.setAttribute("bgcolor","#fffafa");
        td.onmouseover = function () {
          this.className = "mouseOver";
        };

        td.onmouseout = function () {
          this.className = "mouseOut";
        };

        td.onclick = function () {

        };
        var text = document.createTextNode(nextNode);
        td.appendChild(text);
        tr.appendChild(td);
        document.getElementById("content_table_body").appendChild(tr);
      }
    }

    //清空数据
    function clearContent() {

      var ContentTableBody = document.getElementById("content_table_body");
      var size = ContentTableBody.childNodes.length;
      for (var i = size-1;i>=0;i--){
        ContentTableBody.removeChild(ContentTableBody.childNodes[i]);
      }
        document.getElementById("popDiv").border = "none";
    }
    //当输入框失去焦点的时候清空
    function keywordBlur() {
      clearContent();

    }

    //设置显示关联信息的位置
    function setLocation() {

      //关联信息的显示位置要和输入框一致
      var content = document.getElementById("keyword");
      var width = content.offsetWidth;
      var left = content["offsetLeft"];//输入框距离左边框的距离
      var top = content["offsetTop"] + content.offsetHeight; //到顶部的距离

      var popDiv = document.getElementById("popDiv");
      popDiv.style.border = "black 1px solid";
      popDiv.style.left = left +"px";
      popDiv.style.top = top + "px";
      popDiv.style.width = width +"px";
      document.getElementById("content_table").style.width = width +"px";


    }
  </script>
</html>
