<%-- 
    Document   : Manager_Login
    Created on : 2017-4-19, 20:54:24
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
        <title>管理员验证页</title>
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
                                <li><a href="/BookStore/Manager/User_Affair.jsp">用户管理</a></li>
                                <li><a href="/BookStore/Manager/Book_Affair.jsp">书籍管理</a></li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
            <h1 style="text-align: center;color: darkmagenta">管理员验证</h1>
            <div class="form-group col-md-12 column">
                <div class="col-md-3 column"></div>
                <div class="col-md-6 column">
                    <form class="form-horizontal" action="j_security_check" method="post">
                        <input type="text" name="j_username" placeholder="用户名" class="form-control"/>
                        <div class="col-md-12 column" style="height: 20px"></div>
                        <input type="password" name="j_password" placeholder="密码" class="form-control"/>
                        <div class="col-md-12 column" style="height: 20px"></div>
                        <div class="col-sm-8 column"></div>
                        <div class="col-sm-4 column">
                            <input type="submit" value="验证" class="btn btn-info btn-block"/>
                        </div>
                    </form>
                </div>
                <div class="col-md-3 column"></div>
            </div>
        </div>
    </body>
</html>
