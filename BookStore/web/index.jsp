<%-- 
    Document   : index
    Created on : 2017-4-18, 13:04:58
    Author     : lycronaldo
--%>

<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
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
        <title>首页</title>
        <%
            String userid = (String)request.getSession().getAttribute("User");
            ResourceBundle resource = ResourceBundle.getBundle("Component/Internationalize/Internationalize", request.getLocale());
            String book_store = resource.getString("Storm_Bookstore");
            String menu = resource.getString("menu");
            String login = resource.getString("login");
            String register = resource.getString("register");
            String bookstore = resource.getString("bookstore");
            String user_center = resource.getString("user_center");
            String chatting_room = resource.getString("chatting_room");
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
                            <a class="navbar-brand" href="#"><strong><%=book_store%></strong></a>
                        </div>
                        <div class="collapse navbar-collapse">
                            <%
//                                if(userid != null)
//                                {
                            %>
                            <ul class="nav navbar-nav">
                                <li>
                                    <a href="javascript:document.Jump_To_BookStore.submit();"><%=bookstore%></a>
                                </li>
                            </ul>
                            <%
//                                }
                            %>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="javascript:document.Jump_To_User_Register.submit();"><%=register%></a></li>
                                <li><a href="javascript:document.Jump_To_User_Login.submit();"><%=login%></a></li>
                                <%
                                    if(userid != null && !userid.equals("null"))
                                    {
                                %>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%=menu%><strong class="caret"></strong></a>
                                    
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="javascript:document.Jump_To_User_Center.submit();"><%=user_center%></a>
                                        </li>
                                        <li class="divider"></li>
                                        <li>
                                            <a href="javascript:document.Jump_To_Chatting_Room.submit();"><%=chatting_room%></a>
                                        </li>
                                    </ul>
                                </li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </nav>
                    <div class="jumbotron well">
                        <h1 style="text-align: center; color: darkmagenta;font-family: 'Arial Black'">
                            <strong><%=bookstore%></strong>
                        </h1>
                        <button id="rest_web" onclick="Rest_Test()" class="btn btn-info">Rest测试</button>
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
        <script>
            function Rest_Test()
            {
                var role = "student";
                var type = "bookname";
                var search = "c";
                $.ajax({
                    url: "http://localhost:8080/BookStore/WebService/Restful/Book/query",
                    dataType: "application/json",
                    type: "GET",
                    success: function(data){
                        console.info(data);
                    }
                });
            }
        </script>
    </footer>
</html>
