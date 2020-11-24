<%@ page import="com.bee.www.common.LoginManager" %>
<%@ page import="com.bee.www.vo.MemberVo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    LoginManager lm = LoginManager.getInstance();
    String id = lm.getMemberId(session);
    MemberVo vo = (MemberVo) request.getAttribute("vo");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/index_header.css">
    <link rel="stylesheet" href="css/profile.css">
    <link rel="shortcut icon" href="../images/basic.jpg" type="image/x-icon">
    <link rel="icon" href="../images/basic.jpg" type="image/x-icon">
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
                    //로그인 상태
                    if(id==null){
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
                <% }  %>
            </div>
        </div>
    </div>
</header>

<section class="Chat-container">
    <div class="all-margin">
        <form action="profileImgUpdate.do" method="post" enctype="multipart/form-data">
            <div class="img-section">
                <div class="img-area">
                    <img id="image_section" src="../resources/img/<%=vo.getNewFileName()%>" alt=""/>
                        <label for="imgFile" class="del-button img-up">
                            <input type="file" id="imgFile" name="imgFile" accept=".jpg, .png, .jpeg, .gif" value=""/>업로드
                        </label>
                    <button class="up-button" type="submit">저장</button>
                    <button class="del-button" onclick="delImg()" type="button">제거</button>
                </div>
            </div>
        </form>
        <form action="profileUpdate.do" method="post">
            <div class="profile-section">
                <div class="nickname">
                    <div class="wrapper">
                        <div class="title-wrapper">
                            <h3>닉네임</h3>
                        </div>
                        <div class="content-wrapper">
                            <div class="contents cont"><%=vo.getNickname()%></div>
                            <div class="contents-input cont" style="display: none;">
                                <input id="nick" name="nick" class="fixName-input" type="text" value="<%=vo.getNickname()%>"/>
                            </div>
                        </div>
                        <div class="edit-wrapper">
                            <button class="tab fix-button active" type="button">수정</button>
                            <button class="tab update-button" type="submit">저장</button>
                        </div>
                    </div>
                </div>
                <div class="leave">
                    <div class="wrapper">
                        <div class="title-wrapper">
                            <h3>회원탈퇴</h3>
                        </div>
                        <div class="content-wrapper">
                            <div class="contents">
                                <button type="button" class="leave-button" onclick="deleteMember()">회원탈퇴</button>
                            </div>
                        </div>
                        <div class="content-wrapper2">
                            <a href="/" class="up-button">나가기</a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>

<script src="http://code.jquery.com/jquery-1.11.3.min.js" type="text/javascript" charset="utf-8"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script charset="utf-8">
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#image_section').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }
    $("#imgFile").change(function () {
        readURL(this);
    });
    function delImg(){
        $('#image_section').removeAttr('src');
        $('#image_section').attr('src', '../images/basic.jpg');
    }


    $('.edit-wrapper .tab').click(function () {
        if ($(this).hasClass('fix-button')) {
            $('.edit-wrapper .tab').removeClass('active');
            $('.update-button').addClass('active');
            $('.cont').hide();
            $('.contents-input').show();
        }
        if ($(this).hasClass('update-button')) {
            $('.edit-wrapper .tab').removeClass('active');
            $('.fix-button').addClass('active');
            $('.cont').hide();
            $('.contents').show();
            console.log(this);
        }
    });

    function deleteMember() {
        if(confirm('탈퇴하시겠습니까?')==true) {
            location.href='/memberDelete.do';
        }else{
            return;
        }
    }
</script>
</body>
</html>
