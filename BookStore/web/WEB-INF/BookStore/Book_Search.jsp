<%-- 
    Document   : Book_Search
    Created on : 2017-4-19, 10:40:27
    Author     : lycronaldo
--%>

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
        <title>书籍搜索</title>
        <%
            String userid = (String)request.getSession().getAttribute("User");
            List<Book> book_list = (List<Book>)request.getAttribute("book_list");
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
                            <ul class="nav navbar-nav">
                                <li>
                                    <a href="javascript:document.Jump_To_BookStore.submit();">书店</a>
                                </li>
                            </ul>
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
                    <div class="col-md-3 column"></div>
                    <div class="col-md-6 column" style="text-align: center">
                        <h1 style="text-align: center;color: darkmagenta;font-family: 'Arial Black'">
                            <strong>书本搜索</strong>
                        </h1>
                        <form accept-charset="UTF-8" action="Search_Book" method="post" class="form-horizontal">
                            <div class="col-sm-3">
                                <select name="type" class="form-control">
                                    <option value="bookname">书籍名称</option>
                                    <option value="author">作者姓名</option>
                                    <option value="category">类别</option>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" name="search"/>
                                <input type="hidden" name="role" value="<%=userid%>"/>
                            </div>
                            <div class="col-sm-3">
                                <input type="submit" class="btn btn-primary" value="搜索"/>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-3 column"></div>
                </div>
                <div class="col-md-12 column" style="text-align: center">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <td>书籍名称</td>
                                <td>作者姓名</td>
                                <td>书籍价格</td>
                                <td>书籍类别</td>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if(book_list != null)
                                {
                                    for(int i=0;i<book_list.size();++i)
                                    {
                                        String price = ""+book_list.get(i).getPrice();
                            %>
                        
                            <tr class="info">
                                <td><%=book_list.get(i).getBookname()%></td>
                                <td><%=book_list.get(i).getAuthor()%></td>
                                <td><%=price%></td>
                                <td><%=book_list.get(i).getCategory()%></td>
                                <td>
                                    <button class="btn btn-info btn-block" onclick="Show_Detail(<%=i%>)">详情</button>
                                </td>
                                <td>
                                    <div class="form-group">
                                        <div class="col-sm-2"><input type="hidden" id="bookid<%=i%>" value="<%=book_list.get(i).getId().toString()%>"/></div>
                                        <div class="col-sm-4"><button class="btn btn-primary btn-block" onclick="Add_Book_To_ShoppingCart(<%=i%>, <%=userid%>)">加入购物车</button></div>
                                        <div class="col-sm-2"></div>
                                        <div class="col-sm-4">
                                            <form action="setOrder" method="post">
                                                <input type="hidden" name="userid" value="<%=userid%>"/>
                                                <input type="hidden" name="bookid" value="<%=book_list.get(i).getId().toString()%>"/>
                                                <input type="submit" class="btn btn-success btn-block" value="购买"/>
                                            </form>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tbody id="scripts<%=i%>"></tbody>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-12 column">
                    <div class="col-sm-8 column"></div>
                    <div class="col-sm-4 column">
                        <button class="btn btn-primary" onclick="document.Jump_To_ShoppingCart.submit();">我的购物车</button>
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
        <form name="Jump_To_ShoppingCart" action="Jump_To_ShoppingCart" method="post">
            <input type="hidden" name="userid" value="<%=userid%>"/>
        </form>
        <script>
            function Add_Book_To_ShoppingCart(bookid, userid)
            {
                var book = parseInt(document.getElementById("bookid"+bookid).value);
                $.ajax({
                    url: "/BookStore/Add_Book_To_ShoppingCart",
                    type: "POST",
                    data: {userid: userid,bookid: book},
                    success: function(){
                        console.info("已加入购物车!");
                    }
                });
            }
            function Show_Detail(id)
            {
                var bookid = parseInt(document.getElementById("bookid"+id).value);
                $.ajax({
                   url: "/BookStore/Show_Detail",
                   type: "POST",
                   data: {bookid: bookid},
                   success: function(data)
                   {
                       document.getElementById("scripts"+id).innerHTML = data;
                   }
                });
            }
        </script>
    </footer>
</html>
