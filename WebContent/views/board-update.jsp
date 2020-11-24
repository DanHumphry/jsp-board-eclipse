<%@ page import="com.bee.www.vo.AttendanceVo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    AttendanceVo vo = (AttendanceVo) request.getAttribute("vo");
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/write.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
</head>
<body>
<header>
    <div class="write-header">
        <h3>글 수정</h3>
    </div>
</header>

<section class="container-section">
    <article class="write-container">
        <form action="/board-updateProc.do?num=<%=vo.getB_sq()%>" method="post" onsubmit="return checkData()">
            <div class="post-title">
                <input type="text" name="title" id="title" placeholder="제목을 입력하세요" value="<%=vo.getTitle()%>"/>
            </div>
            <div class="post-contents">
                <textarea name="content" id="content" class="post-textarea2"
                          placeholder="내용을 입력하세요"><%=vo.getContent()%></textarea>
            </div>
            <footer class="post-comment">
                <a id="go-back" name="go-back" class="exit-btn transparent-btn">✔ 나가기</a>
                <button class="transparent-btn">등록</button>
            </footer>
        </form>
    </article>
</section>
<script text="text/javascript" charset="utf-8">
    document.getElementById('go-back').addEventListener('click', () => {
        window.history.back();
    });
    function checkData() {
        var title=$('#title').val();
        var content=$('#content').val();

        if(!title){
            alert("제목을 입력하세요");
            $('#title').focus();
            return false;
        }
        if(!content){
            alert("내용을 입력하세요");
            $('#content').focus();
            return false;
        }
    }
</script>
</body>
</html>
