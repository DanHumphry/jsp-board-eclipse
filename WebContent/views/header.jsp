<%@ page import="com.bee.www.common.LoginManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    LoginManager lm = LoginManager.getInstance();
    String id = lm.getMemberId(session);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Good Bee</title>
    <link rel="stylesheet" type="text/css" href="/css/index.css">
    <link rel="stylesheet" type="text/css" href="/css/index_header.css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js" charset="utf-8"></script>
</head>
<body>
<header>
    <div class="header-area">
        <div class="header-main">
            <div class="header-filter">
                <svg width="17" height="17" viewBox="0 0 17 17">
                    <path fill-rule="evenodd" d="M13.66 7.36a6.3 6.3 0 1 1-12.598 0 6.3 6.3 0 0 1 12.598 0zm-1.73 5.772a7.36 7.36 0 1 1 1.201-1.201l3.636 3.635c.31.31.31.815 0 1.126l-.075.075a.796.796 0 0 1-1.126 0l-3.636-3.635z" clip-rule="evenodd"></path>
                </svg>
                <input type="text" placeholder="검색할 내용.."/>
            </div>
            <div class="header-login">
                <%
                    if(id==null){//로그인 상태
                %>
                <a href="/join.do">
                    <h3 class="join">회원가입</h3>
                </a>
                <a href="/login.do">
                    <h3>로그인</h3></a>
                <% } //로그아웃 상태
                else { %>
                <a href="/profile.do?id=<%=id%>">
                    <h3 class="join">회원정보</h3>
                </a>
                <a href="/logout.do">
                    <h3>로그아웃</h3>
                </a>
                <% } %>
            </div>
        </div>
    </div>
</header>

<section class="title-section">
    <div class="title-logo">
        <a href="/">
            <img src="../images/GoodBee.png">
        </a>
    </div>
</section>

<div class="main-margin">
    <section class="nav-section">
        <nav>
            <ul>
                <li><a href="/attendance.do" id="test1">출석체크</a></li>
                <li><a href="/board.do?pn=1&val=newest&filter=&keyword=" id="test2">게시판</a></li>
            </ul>
        </nav>
    </section>
</div>
<script type="text/javascript" charset="utf-8">
    $(function (){
        let attURL = 'http://localhost:8080/attendance.do';
        let bodURL = 'http://localhost:8080/board.do';
        let bodDetailURL = 'http://localhost:8080/board-detail.do';

        let para = document.location.href.split("?");

        if (para[0] == bodURL || para[0] == bodDetailURL){
            $('#test2').css('color', 'rgb(12, 167, 179)');
        }else if (para[0] == attURL){
            $('#test1').css('color', 'rgb(12, 167, 179)');
        }
    })
</script>
</body>
</html>