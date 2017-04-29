<%-- 
    Document   : User_Center
    Created on : 2017-4-20, 9:55:22
    Author     : lycronaldo
--%>

<%@page import="WebApp.Entity.User.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap-theme.min.css" rel="stylesheet">
        <link href="https://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <title>个人中心</title>
        <%
            String cond = (String)request.getAttribute("cond");
            String userid= (String)request.getSession().getAttribute("User");
            if(cond != null)
            {
                if(cond.equals("nouser"))
                    out.println("<script>alert('用户名或密码错误');</script>");
                else if(cond.equals("error"))
                    out.println("<script>alert('服务器错误');</script>");
            }
            User user = (User)request.getAttribute("user_info");
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
                    <div class="col-md-3 column"></div>
                    <div class="col-md-6 column" style="text-align: center">
                        <h1 style="text-align: center;color: darkcyan;font-family: '宋体'">
                            <strong>个人信息</strong>
                        </h1>
                        <dl class="dl-horizontal" style="color: deepskyblue;font-size: x-large">
                            <dt>用户名</dt>
                            <dd><%=user.getUsername()%></dd>
                            <dt>邮箱</dt>
                            <dd><%=user.getEmail()%></dd>
                            <dt>联系方式</dt>
                            <dd><%=user.getMobile()%></dd>
                            <dt>性别</dt>
                            <dd><%=user.getGender()%></dd>
                            <dt>身份</dt>
                            <dd><%=user.getIdentify()%></dd>
                        </dl>
                    </div>
                    <div class="col-md-3 column"></div>
                </div>
            </div>
        </div>
    </body>
    <footer>
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
