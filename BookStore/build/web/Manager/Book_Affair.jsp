<%-- 
    Document   : Book_Affair
    Created on : 2017-4-19, 10:37:24
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
        <title>书本管理</title>
        <%
            String cond = (String)request.getAttribute("cond");
            if(cond != null)
                out.println("<script>alert('"+cond+"');</script>");
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
                <div class="col-md-12 column" style="text-align: center">
                    <h1 style="color: darkmagenta;"><strong>添加书籍</strong></h1>
                    <form name="Add_Book_Form" action="Add_Book" method="post">
                        <table class="table table-striped form-group">
                            <thead>
                                <tr>
                                    <td>书籍名称</td>
                                    <td>作者</td>
                                    <td>价格</td>
                                    <td>类别</td>
                                    <td>父类别</td>
                                    <td>身份限制</td>
                                </tr>
                            </thead>
                            <tbody id="add_list">
                                <tr><input type="hidden" name="size" id="book_size" class="form-control" value=""/></tr>
                            </tbody>
                        </table>
                    </form>
                    <div class="col-md-12 column">
                        <div class="col-md-9 column"></div>
                        <div class="col-md-2 column">
                            <button class="btn btn-success btn-block" onclick="Add_Book_Column();">增加书籍</button>
                        </div>
                        <div class="col-md-1 column"></div>
                    </div>
                    <div class="col-md-12 column" style="height: 20px"></div>
                    <div class="col-md-12 column">
                        <div class="col-md-6 column"></div>
                        <div class="col-md-6 column">
                            <button class="btn btn-primary btn-block" onclick="document.Add_Book_Form.submit();">添加以上书籍</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 column" style="text-align: center">
                    <h1 style="text-align: center;color: darkmagenta;font-family:'Courier'">
                        <strong>搜索书籍</strong>
                    </h1>
                    <form action="Search_Book_WebService" method="post" class="form-horizontal">
                        <div class="col-sm-3">
                            <select name="type" class="form-control">
                                <option value="bookname">书籍名称</option>
                                <option value="author">作者姓名</option>
                                <option value="category">类别</option>
                            </select>
                        </div>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" name="search"/>
                            <input type="hidden" name="role" value="manager"/>
                        </div>
                        <div class="col-sm-3">
                            <input type="submit" class="btn btn-primary" value="搜索"/>
                        </div>
                    </form>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <td>书籍ID</td>
                                <td>书籍名称</td>
                                <td>书籍作者</td>
                                <td>价格</td>
                                <td>类别</td>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if(book_list != null)
                                {
                                    for(int i=0;i<book_list.size();++i)
                                    {
                            %>
                            <tr class="info">
                                <td><%=book_list.get(i).getId().toString()%></td>
                                <td><%=book_list.get(i).getBookname()%></td>
                                <td><%=book_list.get(i).getAuthor()%></td>
                                <td><%=book_list.get(i).getPrice()%></td>
                                <td><%=book_list.get(i).getCategory()%></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
    <footer>
        <script>
            var size = 0;
            function Add_Book_Column()
            {
                var body = document.getElementById("add_list");
                body.innerHTML += "<tr>"+
                            "<td><input type='text' id='bookname"+size+"' name='bookname"+size+"' class='form-control'/></td>"+
                            "<td><input type=\"text\" id=\"author"+size+"\" name=\"author"+size+"\" class=\"form-control\"/></td>"+
                            "<td><input type=\"text\" id=\"price"+size+"\" name=\"price"+size+"\" class=\"form-control\"/></td>"+
                            "<td><input type=\"text\" id=\"category"+size+"\" name=\"category"+size+"\" class=\"form-control\"/></td>"+
                            "<td><input type=\"text\" id=\"parent"+size+"\" name=\"parent"+size+"\" class=\"form-control\"/></td>"+
                            "<td><input type=\"text\" id=\"role"+size+"\" name=\"role"+size+"\" class=\"form-control\"/></td>"+
                        "</tr>";
                size += 1;
                document.getElementById("book_size").value = ""+size;
            }
        </script>
        <form name="Jump_To_User_Update" action="Jump_To_User_Update" method="post"></form>
    </footer>
</html>
