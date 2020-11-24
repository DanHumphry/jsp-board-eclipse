<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 가입</title>
    <meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="805115670990-b1g6ke28qjgt0q458r4oj049p6s3t8qu.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <link rel="stylesheet" type="text/css" href="/css/index.css">
    <link rel="stylesheet" type="text/css" href="/css/index_header.css">
    <link rel="stylesheet" type="text/css" href="/css/login.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <script charset="utf-8">
        let result = 1;
        let result2 = 1;

        function checkId() {
            let id = $('#id').val();
            if(id==''){     //아이디 미입력
                $('#id_check').html('아이디를 입력해 주세요!').css('color', 'red');
                $('#id').focus();
                return;
            }

            if(id.length>20){       //아이디 길이 초과
                $('#id_check').html('20자 이내로 작성해 주세요.').css('color', 'red');
                $('#id').val("");
                $('#id').focus();
                return false;
            }

            var regExpId = new RegExp("^[a-z0-9]{4,20}$", "g");
            if (regExpId.exec(id) == null) {
                $('#id_check').html('아이디는 4자 이상 영소문자와 숫자를 혼합해 주세요.').css('color', 'red');
                $('#id').val("");
                $('#id').focus();
                return false;
            }

            //아이디 중복확인
            $.ajax({
                url: "/checkId.do",
                type: "post",
                data: {id: id},
                dataType: "json",
                error: function () {
                    console.log("서버 통신 실패");
                },
                success: function (data) {
                    console.log("서버 통신 성공");

                    if (data.count == 0) {      //0 id미중복
                        result = 0;
                        console.log("success if result = "+result);
                        $('#id_check').html('사용 가능한 아이디').css('color', 'blue');
                    } else {                    //1 중복
                        result = 1;
                        console.log("success else result = "+result);
                        $('#id_check').html('사용 불가능한 아이디').css('color', 'red');
                        $('#id').val('');
                        $('#id').focus();
                    }
                }
            });
        }

        function checkEmail() {
            var email = $('#email').val();
            if(email==''){     //이메일 미입력
                $('#email_check').html('이메일을 입력해 주세요!').css('color', 'red');
                $('#email').focus();
                return;
            }
            var regExpEmail = new RegExp("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$", "g");
            if (regExpEmail.exec(email) == null) {
                alert("잘못된 이메일 형식입니다.");
                $('#email').val("");
                $('#email').focus();
                return false;
            }

            //이메일 중복확인
            $.ajax({
                url: "/checkEmail.do",
                type: "post",
                data: {email: email},
                dataType: "json",
                error: function () {
                    console.log("서버 통신 실패");
                },
                success: function (data) {
                    console.log("서버 통신 성공");

                    if (data.count == 0) {      //0 email미중복
                        result2 = 0;
                        console.log("success if result = "+result2);
                        $('#email_check').html('사용 가능한 이메일').css('color', 'blue');
                    } else {                    //1 중복
                        result2 = 1;
                        console.log("success else result = "+result2);
                        $('#email_check').html('사용 불가능한 이메일').css('color', 'red');
                        $('#email').val('');
                        $('#email').focus();
                    }
                }
            });
        }

        function initCheckId() {
            result = 1;  //id 칸에 다시 입력할 때 count 1로 초기화
            $('#id_check').html('20자 이내의 아이디 입력').css('color', '#9aa8d0');

        }

        function initCheckEmail() {
            result2 = 1;  //id 칸에 다시 입력할 때 count 1로 초기화
            $('#email_check').html('이메일 입력').css('color', '#9aa8d0');
        }

        //form submit시
        function joinSubmit() {
            var id = $('#id').val();
            var pwd = $('#pwd').val();
            var pwd_confirm = $('#pwd_confirm').val();
            var email = $('#email').val();
            var nick = $('#nick').val();

            if(result==1 && result2==1){
                alert('아이디와 이메일을 중복체크 하세요');
                if($('#id').val()==''){
                    $('#id').focus();
                }
                return false;
            }
            if(result==1){
                alert('아이디 중복체크 하세요');
                if($('#id').val()==''){
                    $('#id').focus();
                }
                return false;
            }
            if(result2==1){
                alert('이메일 중복체크 하세요');
                if($('#email').val()==''){
                    $('#email').focus();
                }
                return false;
            }

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
            if (!pwd_confirm) {
                alert("비밀번호확인을 입력해 주세요.");
                $('#pwd_confirm').focus();
                return false;
            }
            if (pwd != pwd_confirm) {
                alert("비밀번호가 일치하지 않습니다.");
                $('#pwd').val("");
                $('#pwd_confirm').val("");
                $('#pwd').focus();
                return false;
            }
            if (!email) {
                alert("이메일을 입력해 주세요");
                $('#email').focus();
                return false;
            }
            if (!nick) {
                alert("닉네임을 입력해 주세요");
                $('#nick').focus();
                return false;
            }

            var regExpId = new RegExp("^[a-z0-9]{4,20}$", "g");
            if (regExpId.exec(id) == null) {
                alert("잘못된 아이디 형식입니다.");
                $('#id').val("");
                $('#id').focus();
                return false;
            }

            var regExpPwd = new RegExp("^.{4,30}$", "g");
            if (regExpPwd.exec(pwd) == null) {
                alert("잘못된 비밀번호 형식입니다.");
                $('#pwd').val("");
                $('#pwd_confirm').val("");
                $('#pwd').focus();
                return false;

            }
            // var regExpNick = new RegExp("^[a-z가-힣]{4,20}$", "g");
            // if (regExpNick.exec(nick) == null) {
            //     alert("잘못된 닉네임 형식입니다.");
            //     $('#nick').val("");
            //     $('#nick').focus();
            //     return false;
            // }
            var regExpEmail = new RegExp("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$", "g");
            if (regExpEmail.exec(email) == null) {
                alert("잘못된 이메일 형식입니다.");
                $('#email').val("");
                $('#email').focus();
                return false;
            }
        }

        function onSignIn(googleUser) {
            var profile = googleUser.getBasicProfile();
            console.log("ID: " + profile.getId()); // Don't send this directly to your server!
            console.log('Full Name: ' + profile.getName());
            console.log("Image URL: " + profile.getImageUrl());
            console.log("Email: " + profile.getEmail());
            var id_token = googleUser.getAuthResponse().id_token;
            console.log("ID Token: " + id_token);
            console.log("id : " +  profile.getEmail().split("@")[0])

            $.ajax({
                url: "/google.do",
                type: "post",
                data: {
                    id : profile.getEmail().split("@")[0],
                    email : profile.getEmail(),
                    nick : profile.getName(),
                    pwd : id_token,
                    pwd_confirm : id_token
                },
                error: function () {
                    console.log("서버 통신 실패");
                },
                success: function () {
                    console.log("서버 통신 성공");
                    location.href = '/';
                }
            });
        };

        function signOut() {
            var auth2 = gapi.auth2.getAuthInstance();
            auth2.signOut().then(function () {
                console.log('User signed out.');
            });
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
                                    <span class="tab signin"><a href="/login.do">로그인</a></span>
                                    <span class="tab signup active"><a href="#">회원가입</a></span>
                                </div>
                                <div class="content">
                                    <section class="signin-cont cont">
                                        <form name="joinForm" id="joinForm" onsubmit="return joinSubmit();"
                                              action="/joinProc.do" method="post">
                                            <p id="id_check">중복확인 해주세요.</p>
                                            <!-- <p>가능한 아이디입니다.</p> -->
                                            <div class="checkBlock">
                                                <input id="id" name="id" type="text" class="inpt" minlength="4"
                                                       maxlength="20" placeholder="아이디 입력" oninput="initCheckId()"/>
                                                <button class="checkButton" type="button" value="ID중복확인"
                                                        name="confirmId" id="confirmId" onclick="checkId()">중복확인</button>
                                            </div>
                                            <p id="email_check">중복확인 해주세요.</p>
                                            <!-- <p>가능한 이메일입니다.</p> -->
                                            <div class="checkBlock">
                                                <input id="email" name="email" type="email" class="inpt" placeholder="이메일 입력" oninput="initCheckEmail()"/>
                                                <button class="checkButton" type="button" value="Email중복확인"
                                                        name="confirmEmail" id="confirmEmail" onClick="checkEmail()">중복확인</button>
                                            </div>
                                            <div class="otherinput">
                                                <input name="pwd" id="pwd" minlength="4" maxlength="30" type="password" class="inpt2"
                                                       placeholder="비밀번호 입력"/>
                                                <input name="pwd_confirm" id="pwd_confirm" minlength="4" maxlength="30"
                                                       type="password" class="inpt2" placeholder="비밀번호 확인"/>
                                                <input name="nick" id="nick" type="text" class="inpt2"
                                                       placeholder="닉네임 입력"/>
                                            </div>
                                            <div class="submit-wrap">
                                                <input type="submit" value="회원가입" class="submit"/>
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