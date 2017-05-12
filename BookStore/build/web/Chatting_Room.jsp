<%-- 
    Document   : Chatting_Room
    Created on : 2017-4-25, 9:30:30
    Author     : lycronaldo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap-theme.min.css" rel="stylesheet">
        <link href="https://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <title>聊天室</title>
        <%
            String userid = (String)request.getSession().getAttribute("User");
            String username = (String)request.getAttribute("username");
        %>
    </head>
    <body>
        <div class="container">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <nav class="navbar navbar-default navbar-inverse">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span><span class="icon-bar"></span>
                                <span class="icon-bar"></span></button>
                            <a class="navbar-brand" href="#"><strong>Storm BookStore</strong></a>
                        </div>
                        <div class="collapse navbar-collapse">
                            <%
                                if(userid!=null)
                                {
                            %>
                            <ul class="nav navbar-nav">
                                <li>
                                    <a href="javascript:document.Jump_To_BookStore.submit();">书店</a>
                                </li>
                            </ul>
                            <%
                                }
                            %>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="javascript:document.Jump_To_User_Register.submit();">注册</a></li>
                                <li><a href="javascript:document.Jump_To_User_Login.submit();">登录</a></li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">菜单<strong class="caret"></strong></a>
                                    <%
                                        if(userid != null)
                                        {
                                    %>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="javascript:document.Jump_To_User_Center.submit();">用户中心</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li>
                                            <a href="javascript:document.Jump_To_Chatting_Room.submit();">聊天室</a>
                                        </li>
                                    </ul>
                                    <%
                                        }
                                    %>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>
                <div class="col-md-12 column" style="text-align: center">
                    <h1 style="text-align: center;color: darkmagenta;font-family: 'Arial Black'">
                        <strong>聊天室</strong>
                    </h1>
                    <div class="col-md-3 column"></div>
                    <div class="col-md-6 column" style="text-align: center">
                        <div class="col-sm-12 column info" id="chatting" style="color: red;font-size: x-large"></div>
                        <div class="col-sm-3"></div>
                        <div class="col-sm-6">
                            <div class="col-sm-12 column">
                                <textarea contenteditable="true" class="form-control" id="input" placeholder="请输入聊天内容"></textarea>
                            </div>
                            <div class="col-sm-12 column" style="text-align: right">
                                <button class="btn btn-primary" onclick="Send_Message()">发送消息</button>
                            </div>
                        </div>
                        <div class="col-sm-3"></div>
                    </div>
                    <div class="col-md-3 column"></div>
                    <button class="btn btn-danger" onclick="Close_Message()">退出聊天</button>
                </div>
            </div>
        </div>
        <script>
            var websocket = new WebSocket("ws://localhost:8080/BookStore/chat");
            websocket.onmessage = function(event)
            {
                var message = document.getElementById("chatting");
                message.innerHTML += event.data + "<br/>";
            };
            function Send_Message()
            {
                var script = document.getElementById("input").value;
                var username = document.getElementById("username").value;
                websocket.send(username + " : " + script);
            }
            function Close_Message()
            {
                websocket.close();
                window.location.href = "/BookStore/index.jsp";
            }
        </script>
    </body>
    <footer>
        <input type="hidden" id="username" value="<%=username%>"/>
        <form name="Jump_To_User_Register" action="Jump_To_User_Register" method="post"></form>
        <form name="Jump_To_User_Login" action="Jump_To_User_Login" method="post"></form>
        <form name="Jump_To_BookStore" action="Jump_To_BookStore" method="post">
            <input type="hidden" name="userid" value="<%=userid%>"/>
        </form>
        <form name="Jump_To_Manager_Login" action="Jump_To_Manager_Login" method="post"></form>
        <form name="Jump_To_Chatting_Room" action="Jump_To_Chatting_Room" method="post">
            <input type="hidden" name="userid" value="<%=userid%>"/>
        </form>
        <form name="Jump_To_User_Center" action="Jump_To_User_Center" method="post">
            <input type="hidden" name="userid" value="<%=userid%>"/>
        </form>
    </footer>
</html>
