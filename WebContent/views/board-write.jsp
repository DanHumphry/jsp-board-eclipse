<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/write.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <script charset="utf-8">
        function checkData() {
            let title=$('#title').val();
            let content=$('#content').val();

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
</head>
<body>
<header>
    <div class="write-header">
        <h3>글 작성</h3>
    </div>
</header>

<section class="container-section">
    <article class="write-container">
        <form action="/boardRegister.do" method="post" onsubmit="return checkData()">
            <div class="post-title">
                <input type="text" name="title" id="title" placeholder="제목을 입력하세요"/>
            </div>
            <div class="post-contents">
                <textarea name="content" id="content" class="post-textarea2"
                          placeholder="내용을 입력하세요"></textarea>
            </div>
            <footer class="post-comment">
                <a class="exit-btn transparent-btn" href="/board.do">✔ 나가기</a>
                <button class="transparent-btn">등록</button>
            </footer>
        </form>
    </article>
</section>
</body>
</html>
