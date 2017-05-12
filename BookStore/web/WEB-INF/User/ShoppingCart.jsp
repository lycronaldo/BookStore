<%-- 
    Document   : ShoppingCart
    Created on : 2017-4-20, 9:55:35
    Author     : lycronaldo
--%>

<%@page import="java.util.HashMap"%>
<%@page import="WebApp.Entity.ShoppingCart.ShoppingCart"%>
<%@page import="WebApp.Entity.Book.Book"%>
<%@page import="java.util.List"%>
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
        <title>我的购物车</title>
        <%
            String userid = (String)request.getSession().getAttribute("User");
            HashMap<Book, Integer> book_list = (HashMap<Book, Integer>)request.getAttribute("ShoppingCart");
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
                    <h1 style="text-align: center;color: darkmagenta;font-family: 'Arial Black'"><strong>购物车</strong></h1>
                    <table class="table table-hover">
                        <thead>
                            <tr class="info">
                                <td>书籍名称</td>
                                <td>作者</td>
                                <td>类别</td>
                                <td>单价</td>
                                <td>数量</td>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if(book_list != null )
                                {
                                    for(HashMap.Entry entry : book_list.entrySet())
                                    {
                                        Book book = (Book)entry.getKey();
                                        Integer size = (Integer)entry.getValue();
                            %>
                            <tr>
                                <td><%=book.getBookname()%></td>
                                <td><%=book.getAuthor()%></td>
                                <td><%=book.getCategory()%></td>
                                <td><%=book.getPrice()%></td>
                                <td><%=size%></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-12 column">
                    <div class="col-sm-8"></div>
                    <div class="col-sm-4">
                        <button class="btn btn-primary btn-block" onclick="document.Jump_To_Pay.submit();">全部购买</button>
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
        <form name="Jump_To_Pay" action="Jump_To_Pay" method="post">
            <input type="hidden" name="userid" value="<%=userid%>"/>
        </form>
    </footer>
</html>
