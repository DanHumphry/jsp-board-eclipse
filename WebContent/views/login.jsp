<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="/css/index.css">
    <link rel="stylesheet" type="text/css" href="/css/index_header.css">
    <link rel="stylesheet" type="text/css" href="/css/login.css">

    <!--jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <script charset="utf-8">
        function validateCheck() {
            var id = $('#id').val();
            var pwd = $('#pwd').val();

            if (!id) {
                alert("아이디를 입력해 주세요.");
                $('#id').focus();
                return false;
            }

            if (!pwd) {
                alert("비밀번호를 입력해 주세요.");
                $('#pwd').focus();
                return false;
            }
        }
    </script>
</head>
<body>
<header>
    <div class="header-area">
        <div class="header-main">
            <div class="header-login">
                <a href="/">
                    <h3>Good Bee</h3>
                </a>
            </div>
        </div>
    </div>
</header>

<main>
    <div class="back-container2">
        <div class="back-img2">
            <div class="main-container">
                <div class="main-padding">
                    <div class="main-section">
                        <section class="container">
                            <article class="modal">
                                <a href="/"><div class="exit-wrapper">
                                    <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" tabindex="1" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"></path>
                                    </svg>
                                </div></a>
                                <div class="tabs">
                                    <span class="tab signin active"><a href="#">로그인</a></span>
                                    <span class="tab signup"><a href="/join.do">회원가입</a></span>
                                </div>
                                <div class="content">
                                    <section class="signin-cont cont">
                                        <form action="/loginProc.do" method="post" onsubmit="validateCheck()">
                                            <div class="otherinput">
                                                <input id="id" name="id" type="text" class="inpt2" placeholder="아이디 입력" style="margin-bottom: 25px;"/>
                                                <input id="pwd" name="pwd" type="password" class="inpt2" placeholder="패스워드 입력" style="margin-bottom: 25px;"/>
                                            </div>
                                            <h4>forgat your Id ?
                                                <br/><a href="#">클릭</a>
                                            </h4>
                                            <div class="submit-wrap">
                                                <input type="submit" value="로그인" class="submit"/>
                                            </div>
                                        </form>
                                    </section>
                                </div>
                            </article>
                        </section>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>