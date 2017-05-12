<%-- 
    Document   : User_Affair
    Created on : 2017-4-20, 8:16:07
    Author     : lycronaldo
--%>

<%@page import="java.util.List"%>
<%@page import="WebApp.Entity.User.User"%>
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
        <title>用户管理</title>
        <%
            List<User> user_list = (List<User>)request.getAttribute("user_list");
            String error = (String)request.getAttribute("ERROR");
            if(error != null)
                out.println("<script>alert('"+error+"');</script>");
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
                                <span class="icon-bar"></span>
                            </button>
                        </div>
                        <div class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li><a href="javascript:document.Jump_To_User_Update.submit();">用户管理</a></li>
                                <li><a href="/BookStore/Manager/Book_Affair.jsp">书籍管理</a></li>
                            </ul>
                        </div>
                    </nav>
                </div>
                <div class="col-md-12 column">
                    <div class="col-md-12 column" style="text-align: center">
                        <h1 style="color: darkturquoise;"><strong>用户列表</strong></h1>
                        <div class="col-md-10 column">
                            <form class="form-horizontal" action="User_Update" method="post">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <td>用户名</td>
                                            <td>邮箱</td>
                                            <td>联系方式</td>
                                            <td>身份</td>
                                            <td>更改</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for(int i=0;i<user_list.size();++i)
                                            {
                                        %>
                                        <tr class="success">
                                            <td><input type="text" name="username" value="<%=user_list.get(i).getUsername()%>" class="form-control"/></td>
                                            <td><input type="text" name="email" value="<%=user_list.get(i).getEmail()%>" class="form-control"/></td>
                                            <td><input type="text" name="mobile" value="<%=user_list.get(i).getMobile()%>" class="form-control"/></td>
                                            <td><input type="text" name="identify" value="<%=user_list.get(i).getIdentify()%>" class="form-control"/></td>
                                            <td>
                                                <input type="hidden" name="action" value="update"/>
                                                <input type="submit" class="btn btn-primary" value="更改用户"/>
                                                <input type="hidden" name="userid" value="<%=user_list.get(i).getId().toString()%>"/>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </form>
                        </div>
                        <div class="col-md-2 column">
                            <form action="User_Delete" method="post">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <td>删除</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for(int i=0;i<user_list.size();++i)
                                            {
                                        %>
                                        <tr class="danger">
                                            <td>
                                                <input type="hidden" name="userid" value="<%=user_list.get(i).getId().toString()%>"/>
                                                <input type="submit" class="btn btn-danger" value="删除用户"/>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </form>
                        </div>
                        <div class="col-md-12 column" style="height: 30px"></div>
                        <h1 style="text-align: center;font-family: 'Arial Black';color: darkslateblue">
                            <strong>添加用户</strong>
                        </h1>
                        <form action="Add_User" method="post" name="Add_User">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <td>用户名</td>
                                        <td>密码</td>
                                        <td>邮箱</td>
                                        <td>联系方式</td>
                                        <td>身份</td>
                                        <td>性别</td>
                                    </tr>
                                </thead>
                                <tbody id="add_list">
                                </tbody>
                            </table>
                            <input type="hidden" id="user_size" name="size" value=""/>
                        </form>
                        <button class="btn btn-info" onclick="Add_User_Column()"><strong>+</strong></button>
                        <div class="col-md-12 column">
                            <div class="col-md-8 column"></div>
                            <div class="col-md-4 column"><button onclick="document.Add_User.submit();" class="btn btn-primary btn-block">添加用户</button></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <footer>
        <script>
            var size = 0;
            function Add_User_Column()
            {
                var body = document.getElementById("add_list");
                body.innerHTML += "<tr class='info'>"+
                            "<td><input type='text' id='username"+size+"' name='username"+size+"' class='form-control'/></td>"+
                            "<td><input type=\"text\" id=\"password"+size+"\" name=\"password"+size+"\" class=\"form-control\"/></td>"+
                            "<td><input type=\"text\" id=\"email"+size+"\" name=\"email"+size+"\" class=\"form-control\"/></td>"+
                            "<td><input type=\"text\" id=\"mobile"+size+"\" name=\"mobile"+size+"\" class=\"form-control\"/></td>"+
                            "<td><select id=\"identify"+size+"\" name=\"identify"+size+"\" class=\"form-control\">"+
                            "<option value=\"student\">学生</option>"+"<option value=\"teacher\">教师</option>"+
                            "</select></td>"+
                            "<td><select id=\"gender"+size+"\" name=\"gender"+size+"\" class=\"form-control\">"+
                            "<option value=\"male\">男</option>"+"<option value=\"female\">女</option>"+
                            "</select></td>"+
                        "</tr>";
                size += 1;
                document.getElementById("user_size").value = ""+size;
            }
        </script>
        <form name="Jump_To_User_Update" action="Jump_To_User_Update" method="post"></form>
    </footer>
</html>
