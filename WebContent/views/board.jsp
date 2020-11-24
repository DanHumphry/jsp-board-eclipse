<%@ page import="com.bee.www.vo.AttendanceVo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bee.www.common.Pagenation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ArrayList<AttendanceVo> list = (ArrayList<AttendanceVo>) request.getAttribute("list");
    Pagenation pagenation = (Pagenation) request.getAttribute("pagenation");
    String nowPage = request.getParameter("pn");
    String val = (String) request.getAttribute("val");
    String filter = (String) request.getAttribute("filter");
    String keyword = (String) request.getAttribute("keyword");
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>board</title>
    <link rel="stylesheet" type="text/css" href="/css/index.css">
    <link rel="stylesheet" type="text/css" href="/css/index_header.css">
    <link rel="stylesheet" type="text/css" href="/css/schoolInfo.css">
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="board-container">
    <div class="content-left">
        <div class="head">
            <main class="site-main">
                <article class="post-page">
                    <div class="entry-content">
                        <div class="content-list">
                            <div class="list-header2">
                                <div class="board-sort2">
                                        <form id="filter-form" name="filter-form" method="post">
                                            <select id="filter-select" name="filter-select" class="list-sort">
                                                <option id="newest" name="newest" value="newest">최신순</option>
                                                <option id="best" name="best" value="best">추천순</option>
                                            </select>
                                        </form>
                                    <div class="control">
                                        <a href="/boardWrite.do" class="searchADNcontrol">글쓰기</a>
                                    </div>
                                </div>
                            </div>
                            <div class="board-list">
                                <table id="board-listId">
                                    <thead>
                                    <tr>
                                        <th class="num">번호</th>
                                        <th class="title" style="min-width: 120px;">제목</th>
                                        <th class="user">작성자</th>
                                        <th class="date">작성일</th>
                                        <th class="view">추천수</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for(int i=0;i<list.size();i++) {
                                    %>
                                    <tr>
                                        <td class="num"><%=list.get(i).getB_sq()%></td>
                                        <td onclick="showDetail(<%=list.get(i).getB_sq()%>)" class="title"><%=list.get(i).getTitle()%></td>
                                        <td class="user"><%=list.get(i).getNickname()%></td>
                                        <td class="date"><%=list.get(i).getWriteDate().substring(0, 11)%></td>
                                        <td class="view likeCt<%=i%>"></td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <div class="pagination">
                                <ul>
                                    <li>
                                        <% if (pagenation.getNowPageNumber() != 1) { %>
                                        <a href="/board.do?pn=<%=pagenation.getStartPage()-1%>&val=<%=val%>&filter=<%=filter%>&keyword=<%=keyword%>">«</a>
                                        <% } %>
                                    </li>
                                    <% for (int i = pagenation.getStartPage(); i <= pagenation.getEndPage(); i++) { %>
                                    <li class="page<%=i%> testClass ">
                                        <a href="/board.do?pn=<%=i%>&val=<%=val%>&filter=<%=filter%>&keyword=<%=keyword%>">
                                            <%=i%>
                                        </a>
                                    </li>
                                    <% } %>
                                    <li>
                                        <% if (pagenation.getNowPageNumber() != pagenation.getTotalPageCount()) { %>
                                        <a href="/board.do?pn=<%=pagenation.getEndPage()+1%>&val=<%=val%>&filter=<%=filter%>&keyword=<%=keyword%>">»</a>
                                        <% } %>
                                    </li>
                                </ul>
                            </div>
                            <div class="search">
                                <select name="filter" id="filter">
                                    <option value="all" selected>전체</option>
                                    <option value="title">제목</option>
                                    <option value="content">내용</option>
                                </select>
                                <input type="text" name="keyword" id="keyword"/>
                                <button onclick="return searchArticle()" class="searchADNcontrol"
                                        id="btnSearch">검색
                                </button>
                            </div>
                        </div>
                    </div>
                </article>
            </main>
        </div>
    </div>
</div>
<div class="enterChat">
    <a href="chat.do">
        <svg enable-background="new 0 0 512 512" height="512" viewBox="0 0 512 512" width="512" xmlns="http://www.w3.org/2000/svg"><g><g>
            <path clip-rule="evenodd" d="m114.355 41.494h96.6c62.901 0 114.355 51.454 114.355 114.355v4.964c0 62.872-51.454 114.326-114.355 114.326h-96.6-22.836c-2.453 0-2.19-.088-4.351 1.022l-45.73 23.508c-2.453.905-3.65.234-3.504-2.278l2.628-48.826c.058-.409.146-.467-.117-.672-24.705-21.024-40.445-52.3-40.445-87.08v-4.964c0-62.901 51.454-114.355 114.355-114.355z" fill="#bcea73" fill-rule="evenodd"/></g><g><path clip-rule="evenodd" d="m397.645 211.946h-96.63c-62.901 0-114.355 51.454-114.355 114.355v4.964c0 62.872 51.454 114.355 114.355 114.355h96.63 22.836c2.424 0 2.161-.117 4.322 1.022l45.73 23.478c2.482.905 3.65.234 3.533-2.249l-2.657-48.855c-.058-.38-.146-.438.117-.672 24.705-21.023 40.474-52.298 40.474-87.078v-4.964c0-62.902-51.454-114.356-114.355-114.356z" fill="#8dcafc" fill-rule="evenodd"/></g><g><path d="m403.397 290.079h-105.653c-4.268 0-7.726-3.459-7.726-7.726s3.459-7.726 7.726-7.726h105.653c4.268 0 7.726 3.459 7.726 7.726.001 4.267-3.458 7.726-7.726 7.726z" fill="#f8f6f6"/></g><g><path d="m403.397 339.138h-105.653c-4.268 0-7.726-3.459-7.726-7.726s3.459-7.726 7.726-7.726h105.653c4.268 0 7.726 3.459 7.726 7.726.001 4.267-3.458 7.726-7.726 7.726z" fill="#f8f6f6"/></g><g>
            <path d="m403.397 388.198h-105.653c-4.268 0-7.726-3.459-7.726-7.726s3.459-7.726 7.726-7.726h105.653c4.268 0 7.726 3.459 7.726 7.726.001 4.266-3.458 7.726-7.726 7.726z" fill="#f8f6f6"/></g><g><path d="m213.409 115.45h-105.653c-4.267 0-7.726-3.459-7.726-7.726s3.459-7.726 7.726-7.726h105.653c4.267 0 7.726 3.459 7.726 7.726s-3.459 7.726-7.726 7.726z" fill="#f8f6f6"/></g><g><path d="m213.409 164.51h-105.653c-4.267 0-7.726-3.459-7.726-7.726s3.459-7.726 7.726-7.726h105.653c4.267 0 7.726 3.459 7.726 7.726s-3.459 7.726-7.726 7.726z" fill="#f8f6f6"/></g><g><path d="m160.582 213.599h-52.826c-4.267 0-7.726-3.459-7.726-7.726s3.459-7.726 7.726-7.726h52.826c4.267 0 7.726 3.459 7.726 7.726 0 4.266-3.459 7.726-7.726 7.726z" fill="#f8f6f6"/></g><g><path clip-rule="evenodd" d="m192.179 41.494c39.248 26.136 64.829 69.005 64.829 117.451 0 27.07-8.001 52.389-21.902 74.027 18.66-13.229 41.438-21.025 65.909-21.025h12.148c7.768-15.419 12.148-32.794 12.148-51.133v-4.964c0-62.901-51.454-114.355-114.355-114.355h-18.777z" fill="#99d53b" fill-rule="evenodd"/></g><g><path clip-rule="evenodd" d="m401.47 212.005c28.735 26.194 46.548 62.755 46.548 103.171 0 57.616-36.152 107.318-88.453 130.446h38.079 22.836c2.424 0 2.161-.117 4.322 1.022l45.73 23.478c2.482.905 3.65.234 3.533-2.249l-2.657-48.855c-.058-.38-.146-.438.117-.672 24.706-21.025 40.475-52.3 40.475-87.08v-4.964c0-61.617-49.381-112.253-110.53-114.297z" fill="#64b9fc" fill-rule="evenodd"/></g></g>
        </svg>
    </a>
</div>
<script src="http://code.jquery.com/jquery-1.11.3.min.js" type="text/javascript" charset="utf-8"></script>
<script charset="utf-8">
    function showDetail(num){
        location.href="/board-detail.do?num="+num;
    }

    $(function(){
        function recCount() {
            <%
                for(int i=0;i<list.size();i++) {
            %>
            $.ajax({
                url: "/recCount.do",
                type: "POST",
                data: {
                    no: '<%=list.get(i).getB_sq()%>'
                },
                error: function () {
                    console.log("서버 통신 실패");
                },
                success: function (data) {
                    let JsonData = JSON.parse(data);
                    $(".likeCt<%=i%>").html(JsonData.count);
                },
            })
            <% } %>
        };
        recCount();

        //pagination 부분
        let PagePara = document.location.href.split("&")[0].split("pn=")[1];
        <% for (int i = pagenation.getStartPage(); i <= pagenation.getEndPage(); i++) { %>
        if (PagePara == <%=i%>){
            $('.page<%=i%>').addClass('active');
        }
        <%}%>

        //고생많이한 부분 .. 최신순, 추천순 filter 부분
        //action URL값에 value값을 붙여서 보내고싶었는데 붙일 수 가 없었음. 돌아오기전에 이미 null값이 들어간 상태로 action이 보내지기때문
        // 때문에 script태그 안에서 this.val값을 먼저 action의 url에 집어 넣어준뒤에 submit을 해준 모습이다. 이래야
        //select된 option값에따라 url에 알맞게 value값이 들어가고
        //value값에 따른 selected가 이루어진다.
        $('#filter-select').change(function (){
            let form = $("form");
            let action = "/board.do?pn=<%=nowPage%>&val=" + $(this).val() + "&filter=<%=filter%>&keyword=<%=keyword%>";
            form.attr("action", action);
            this.form.submit();
        })

        let para = document.location.href.split("&")[1].split("val=");

        if (para[1] == "newest"){
            $('#filter-select #newest').attr('selected', 'selected');
        }else if (para[1] == "best"){
            $('#filter-select #best').attr('selected', 'selected');
        }
    })

    function searchArticle() {
        let filter = $('#filter option:selected').val();
        let keyword = $('#keyword').val();
        if (!keyword) {
            alert("검색할 내용을 입력하세요.");
            $('#keyword').focus();
            return false;
        }
        location.href =
            "/board.do?pn=1&val=<%=val%>&filter=" + filter + "&keyword=" + keyword;
    }
</script>
</body>
</html>
