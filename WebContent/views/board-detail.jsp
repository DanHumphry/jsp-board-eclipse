<%@ page import="com.bee.www.common.LoginManager" %>
<%@ page import="com.bee.www.vo.AttendanceVo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    AttendanceVo vo = (AttendanceVo) request.getAttribute("vo");
    LoginManager lm=LoginManager.getInstance();
    String id=lm.getMemberId(session);
    ArrayList<AttendanceVo> list = (ArrayList<AttendanceVo>) request.getAttribute("list");
    ArrayList<AttendanceVo> ReList = (ArrayList<AttendanceVo>) request.getAttribute("ReList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/index_header.css">
    <link rel="stylesheet" href="css/detail.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="detail-auto">
    <div class="detail-container">
        <aside>
            <div class="aside-container">
                <div class="svg-circle btnLike" id="btnLike">
                    <svg class="like-svg" viewBox="0 0 24 24"><path fill="currentColor" d="M18 1l-6 4-6-4-6 5v7l12 10 12-10v-7z"></path></svg>
                </div>
                <div class="like-count">
                    <span class="likeCt"><%=vo.getLikeCount()%></span>
                </div>
            </div>
        </aside>

        <hr>
        <div class="detail-title">
            <h2 class="title-h2"><%=vo.getTitle()%></h2>
        </div>
        <hr>
        <div class="detail-userInfo">
            <div class="pull-left">
                <div class="board-profileImg-section">
                    <img class="board-profileImg" src="../resources/img/<%=vo.getNewFileName()%>" alt=""/>
                </div>
                <div class="pull-left-right">
                    <p class="userName"><%=vo.getNickname()%></p>
                    <P><%=vo.getWriteDate().substring(0, 11)%></P>
                </div>
            </div>

            <div class="pull-right">
                <div class="detail-content">
                    <div class="mobile-like-count">
                        <button id="like-btn" class="mobile-like-button btnLike">
                            <svg width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M18 1l-6 4-6-4-6 5v7l12 10 12-10v-7z"></path></svg>
                            <span class="likeCt"><%=vo.getLikeCount()%></span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <div class="detail-dec">
            <p><%=vo.getContent()%></p>
        </div>
    </div>
</div>
<div class="detail-button">
    <%
        if (id != null) {
            if (id.equals(vo.getId())) {
    %>
    <div class="left-button">
        <button onclick="location.href='/board-update.do?num=<%=vo.getB_sq()%>'">수정</button>
        <button id="b_sq-delete">삭제</button>
    </div>
    <div class="right-button">
        <button onclick="location.href='/board.do'">목록</button>
    </div>
    <%}else {%>
    <div class="right-button">
        <button onclick="location.href='/board.do'">목록</button>
    </div>
    <%}
    }
    else{
    %>
    <div class="right-button">
        <button onclick="location.href='/board.do'">목록</button>
    </div>
    <% } %>
</div>
<div class="commnet-container">
    <div class="comment-count">
        <h4>Comments <%=list.size()%></h4>
    </div>
    <%
        for(int i=0;i<list.size();i++) {
    %>
    <table >
        <tbody class="cmt-content<%=i%>">
            <tr class="left-section" >
                <td class="left-info-img">
                    <img class="board-profileImg" src="../resources/img/<%=list.get(i).getNewFileName()%>" alt=""/>
                </td>
                <td class="left-info-nick"><%=list.get(i).getNickname()%></td>
                <td class="left-info-date"><%=list.get(i).getWriteDate().substring(0, 11)%></td>
            </tr >

            <tr class="right-section" >
                <%
                    if (id != null){
                %>
                <td id="reCmt<%=i%>" class="right-info">답변</td >
                <%
                    if(id.equals(list.get(i).getId())){
                %>
                <td id="fixCmt<%=i%>" class="right-info tabActive<%=i%>">수정</td >
                <td id="delCmt<%=i%>" class="right-info">삭제</td >
                <% } } %>
            </tr >
        </tbody >
        <tbody>
            <tr class="cmt-content<%=i%>">
                <td class="comment-content"><%=list.get(i).getContent()%></td>
            </tr>
        </tbody>

        <tfoot >
        <div class="fix-comment-hidden<%=i%>" style="display: none">
            <div class="fix-comment-txt">
                <textarea id="fixCmtCnt<%=i%>" name="fixcmtCnt" placeholder="여러분의 소중한 댓글을 입력해주세요."><%=list.get(i).getContent()%></textarea>
            </div>
            <div class="fix-comment-button">
                <button class="fix-CmtBtn-cancel">취소</button>
                <button id="fixCmtCnt-btn<%=i%>" class="fix-CmtBtn tabActive<%=i%>">수정하기</button>
            </div>
        </div>
        <%
            for(int a = 0; a < ReList.size(); a++) {
                if (list.get(i).getC_sq() == ReList.get(a).getC_sq()) {
        %>
        <tr class="reCmtCnt reFixCmt-hiddenInfo<%=a%>">
            <td class="reCmtCnt-img">
                <img class="board-profileImg" src="../resources/img/<%=ReList.get(a).getNewFileName()%>" alt=""/>
            </td>
            <td class="reCmtCnt-nick"><%=ReList.get(a).getNickname()%></td>
            <td class="reCmtCnt-date"><%=ReList.get(a).getWriteDate().substring(0, 11)%></td>
            <%
                if (id != null){
                    if(id.equals(ReList.get(a).getId())){
            %>
            <td class="reCmtCnt-right-info fixTabActive<%=a%>" id="reCmtCnt-fix<%=a%>" style="right: 55px">수정</td >
            <td class="reCmtCnt-right-info" id="reCmtCnt-del<%=a%>" style="right: 10px">삭제</td >
            <% } } %>
            <td class="reCmtCnt-content"><%=ReList.get(a).getContent()%></td>
        </tr>
        <tr class="reFixCmt-hidden<%=a%> hiddenReCmtFix" style="display: none">
            <td class="reComment-fixTxt">
                <textarea id="reFixCmtCnt<%=a%>" name="reFixCmtCnt<%=a%>" placeholder="여러분의 소중한 댓글을 입력해주세요.">
                    <%=ReList.get(a).getContent()%></textarea>
            </td>
            <td class="reComment-fixButton">
                <button>취소</button>
                <button id="reFixCmtCnt-btn<%=a%>" class="reCmtBtn fixTabActive<%=a%>">완료</button>
            </td>
        </tr>
        <% } } %>
        <tr class="reCmt-hidden<%=i%> hiddenReCmt">
            <td class="reComment-txt">
                <textarea id="reCmtCnt<%=i%>" name="reCmtCnt<%=i%>" placeholder="여러분의 소중한 댓글을 입력해주세요."></textarea>
            </td>
            <td class="reComment-button">
                <button id="reCmtCnt-btn<%=i%>" class="reCmtBtn">댓글달기</button>
            </td>
        </tr>
        </tfoot >
    </table >
    <% } %>
    <div>
        <div class="comment-txt">
            <textarea id="cmtCnt" name="cmtCnt" placeholder="여러분의 소중한 댓글을 입력해주세요."></textarea>
        </div>
        <div class="comment-button">
            <button id="cmtCnt-btn">댓글달기</button>
        </div>
    </div>
</div>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript" charset="utf-8">
    $(function(){
        $(".btnLike").click(function(){
            <%
                if (id==null){
            %>
                alert("로그인이 필요합니다.");
                location.href='/login.do';
            <%
                }else {
            %>
                $.ajax({
                    url: "/recUpdate.do",
                    type: "POST",
                    data: {
                        no: '<%=vo.getB_sq()%>'
                    },
                    success: function () {
                        recCount();
                    },
                })
            <% }  %>
        })
        // 게시글 추천수
        function recCount() {
            $.ajax({
                url: "/recCount.do",
                type: "POST",
                data: {
                    no: '<%=vo.getB_sq()%>'
                },
                error: function () {
                    console.log("서버 통신 실패");
                },
                success: function (data) {
                    let JsonData = JSON.parse(data);
                    $(".likeCt").html(JsonData.count);
                    if(JsonData.onOff == 0){ //전달받은 0은 아직 추천하지 않았을경우
                        $(".btnLike svg").css("color" , "rgb(134, 142, 150)")
                    }else {//내가 추천해 놓은 경우
                        $(".btnLike svg").css("color" , "#8bd6f1")
                    }
                },
            })
        };
        recCount();

        $("#cmtCnt-btn").click(function(){
            <%
                if (id==null){
            %>
            alert("로그인이 필요합니다.");
            location.href='/login.do';
            <%
                }else {
            %>
            $.ajax({
                url: "/commentIn.do",
                type: "POST",
                data: {
                    num : '<%=vo.getB_sq()%>',
                    content : $("#cmtCnt").val()
                },
                success: function () {
                    console.log("보내기 성공");
                    location.reload()
                },
            })
            <% }  %>
        })

        <%
            for(int i=0;i<list.size();i++) {
        %>
        $("#reCmt<%=i%>").click(function (){
            $(".hiddenReCmt").css("display", "none");
            $(".reCmt-hidden<%=i%>").css("display", "block");
        })
        <% } %>


        <%
            for(int i=0;i<list.size();i++) {
        %>
        $("#reCmtCnt-btn<%=i%>").click(function(){
            <%
                if (id==null){
            %>
            alert("로그인이 필요합니다.");
            location.href='/login.do';
            <%
                }else {
            %>
            $.ajax({
                url: "/reCommentIn.do",
                type: "POST",
                data: {
                    num : '<%=list.get(i).getC_sq()%>',
                    content : $("#reCmtCnt<%=i%>").val()
                },
                success: function () {
                    console.log("보내기 성공");
                    location.reload()
                },
            })
            <% }  %>
        })
        <% } %>

        <%
            for(int i=0;i<list.size();i++) {
        %>
        $('.tabActive<%=i%>').click(function () {
            if ($(this).hasClass('right-info')) {
                $('.cmt-content<%=i%>').hide();
                $('.fix-comment-hidden<%=i%>').show();
            }
            if ($(this).hasClass('fix-CmtBtn')) {
                $('.fix-comment-hidden<%=i%>').hide();
                $('.cmt-content<%=i%>').show();
            }
        });
        <% } %>

        <%
            for(int i=0;i<list.size();i++) {
        %>
        $("#fixCmtCnt-btn<%=i%>").click(function(){
            <%
                if (id==null){
            %>
            alert("로그인이 필요합니다.");
            location.href='/login.do';
            <%
                }else {
            %>
            $.ajax({
                url: "/fixCommentIn.do",
                type: "POST",
                data: {
                    num : '<%=list.get(i).getC_sq()%>',
                    content : $("#fixCmtCnt<%=i%>").val()
                },
                success: function () {
                    location.reload()
                },
            })
        })
        <% } } %>

        <%
            for(int i=0;i<list.size();i++) {
        %>
        $("#delCmt<%=i%>").click(function(){
            <%
                if (id==null){
            %>
            alert("로그인이 필요합니다.");
            location.href='/login.do';
            <%
                }else {
            %>
            if (confirm('정말 삭제하시겠습니까 ?') == true) {
                $.ajax({
                    url: "/delComment.do",
                    type: "POST",
                    data: {
                        num : '<%=list.get(i).getC_sq()%>'
                    },
                    success: function (data) {
                        if (data == "false"){
                            confirmDelete();
                        }
                        location.reload();
                    },

                })
            }

        })
        <% } } %>

        <%
            for(int i=0;i<list.size();i++) {
        %>
        function confirmDelete(){
            if (<%=list.get(i).getC_sq()%>){
                alert("댓글이 있는 게시글은 삭제할 수 없습니다.");
                return false;
            }
        }
        <% } %>

        <%
            for(int a = 0; a < ReList.size(); a++) {
        %>
        $('.fixTabActive<%=a%>').click(function () {
            if ($(this).hasClass('reCmtCnt-right-info')) {
                $('.reFixCmt-hiddenInfo<%=a%>').hide();
                $('.reFixCmt-hidden<%=a%>').show();
            }
            if ($(this).hasClass('reCmtBtn')) {
                $('.reFixCmt-hidden<%=a%>').hide();
                $('.reFixCmt-hiddenInfo<%=a%>').show();
            }
        });
        <% } %>


        <%
            for(int a = 0; a < ReList.size(); a++) {
        %>
        $("#reFixCmtCnt-btn<%=a%>").click(function(){
            <%
                if (id==null){
            %>
            alert("로그인이 필요합니다.");
            location.href='/login.do';
            <%
                }else {
            %>
            $.ajax({
                url: "/fixReCommentIn.do",
                type: "POST",
                data: {
                    num : '<%=ReList.get(a).getReC_sq()%>',
                    content : $("#reFixCmtCnt<%=a%>").val()
                },
                success: function () {
                    console.log("보내기 성공");
                    location.reload()
                },
            })
        })
        <% } } %>

        <%
            for(int a = 0; a < ReList.size(); a++) {
        %>
        $("#reCmtCnt-del<%=a%>").click(function(){
            <%
                if (id==null){
            %>
            alert("로그인이 필요합니다.");
            location.href='/login.do';
            <%
                }else {
            %>
            if (confirm('정말 삭제하시겠습니까 ?') == true) {
                $.ajax({
                    url: "/delReComment.do",
                    type: "POST",
                    data: {
                        num : '<%=ReList.get(a).getReC_sq()%>'
                    },
                    success: function () {
                        console.log("보내기 성공");
                        location.reload()
                    },
                })
            }
        })
        <% } } %>

        $("#b_sq-delete").click( ()=>{
            if(confirm('정말 삭제하시겠습니까 ?')==true) {
                location.href = '/board-delete.do?num=<%=vo.getB_sq()%>';
                return confirmDelete();
            }else {
                return ;
            }
        })
    })
</script>
</body>
</html>