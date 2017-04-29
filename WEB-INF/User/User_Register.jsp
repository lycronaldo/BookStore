<%-- 
    Document   : User_Register
    Created on : 2017-4-18, 14:31:13
    Author     : lycronaldo
--%>

<%@page import="org.apache.struts2.ServletActionContext"%>
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
        <title>注册</title>
        <%
            String userid = (String)request.getSession().getAttribute("User");
            String cond = (String)request.getAttribute("ERROR");
            if(cond != null)
                out.println("<script>alert('"+cond+"')</script>");
        %>
    </head>
    <body>
        <div class="container">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <nav class="navbar navbar-default navbar-inverse" role="navigation">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span><span class="icon-bar"></span>
                                <span class="icon-bar"></span></button>
                            <a class="navbar-brand" href="#"><strong>Storm BookStore</strong></a>
                        </div>
                        <div class="collapse navbar-collapse">
                            <%
                                if(userid != null)
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
                    <div class="col-md-12 column">
                        <h1 style="text-align: center;font-family: 'Arial Black';color: darkmagenta">
                            <strong>注册</strong>
                        </h1>
                        <div class="col-md-3 column"></div>
                        <div class="col-md-6 column form-group" style="text-align: center">
                            <form action="User_Register" method="post" class="form-horizontal">
                                <div class="col-md-12 column">
                                    <div class="form-group">
                                        <label for="username" class="col-sm-3 control-label">用户名</label>
                                        <div class="col-sm-9 column">
                                            <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="password" class="col-sm-3 control-label">密码</label>
                                        <div class="col-sm-9 column">
                                            <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="c_password" class="col-sm-3 control-label">确认密码</label>
                                        <div class="col-sm-9 column">
                                            <input type="password" class="form-control" id="c_password" name="c_password" placeholder="请确认您的密码"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="email" class="col-sm-3 control-label">邮箱</label>
                                        <div class="col-sm-9 column">
                                            <input type="email" class="form-control" id="email" name="email" placeholder="请输入您的邮箱"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="mobile" class="col-sm-3 control-label">联系方式</label>
                                        <div class="col-sm-9 column">
                                            <input type="text" class="form-control" id="mobile" name="mobile" placeholder="请输入联系方式"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="identify" class="col-sm-3 control-label">身份</label>
                                        <div class="col-sm-3 column"></div>
                                        <div class="col-sm-4 column">
                                            <select name="identify" id="identify" class="form-control">
                                                <option value="student">学生</option>
                                                <option value="teacher">教师</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2 column"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="gender" class="col-sm-3 control-label">性别</label>
                                        <div class="col-sm-3 column"></div>
                                        <div class="col-sm-4 column">
                                            <select name="gender" id="gender" class="form-control">
                                                <option value="male">男</option>
                                                <option value="female">女</option>
                                            </select>
                                        </div>
                                        
                                    </div>
                                </div>
                                <div class="col-sm-12 column">
                                    <div class="col-sm-4 column"></div>
                                    <div class="col-sm-4 column">
                                        <input type="submit" class="btn btn-primary btn-block" value="注册"/>
                                    </div>
                                    <div class="col-sm-4 column"></div>
                                </div>
                            </form>
                        </div>
                        <div class="col-md-3 column"></div>
                    </div>
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
