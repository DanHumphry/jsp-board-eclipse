package com.bee.www.action.board;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;
import com.bee.www.common.Pagenation;
import com.bee.www.common.RegExp;
import com.bee.www.service.BoardService;
import com.bee.www.vo.AttendanceVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import static com.bee.www.common.RegExp.IS_NUMBER;

public class BoardAction implements Action  {
    @Override
    public ActionForward execute
            (HttpServletRequest request, HttpServletResponse response) throws IOException {
        String query = null;

        String pageNum = request.getParameter("pn");  //페이지번호 받아오기
        String val = request.getParameter("val");

        ////검색,필터 받아와서 쿼리 생성
        String filter = request.getParameter("filter");
        String keyword = request.getParameter("keyword");

        if (filter == null || filter.equals("")) {      //필터 값 없을 시 전체로 대입
            filter = "all";
        }
        if (keyword != null && !keyword.equals("")) {   //검색값에 뭔가가 들어와있으면 쿼리 생성
            query = makeSearchQuery(filter, keyword);
        }

        if (pageNum == null     //페이지 번호 숫자 아닐때
                || !RegExp.checkString(IS_NUMBER, pageNum)) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.');location.href='/';</script>");
            out.close();
            return null;
        }
        int page = Integer.parseInt(pageNum); //페이지 번호 정수형 변환
        if (page < 1) {     //페이지 번호 1보다 작을때 오류
            page = 1;
        }

        BoardService service = new BoardService();
        Pagenation pagenation = new Pagenation(page, service.getArticleCount());
        Pagenation filterPagenation = new Pagenation(page, service.getFilterArticleCount(query));

        if (page > pagenation.getTotalPageCount()) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>location.href='/board.do?pn=" + pagenation.getTotalPageCount() +
                    "&filter=" + filter + "&keyword=" + keyword + "';</script>");
            out.close();
            return null;
        }

        if (query == null){
            //쿼리값이 널인경우 : 사용자가 아무 검색을 하지 않았기때문에 val 값에따라 article get
            if (val.equals("newest")){
                ArrayList<AttendanceVo> articleList = service.getArticleList(pagenation);
                request.setAttribute("list",articleList);
            }else if (val.equals("best")){
                ArrayList<AttendanceVo> bestArticleList = service.getBestArticleList(pagenation);
                request.setAttribute("list",bestArticleList);
            }
            request.setAttribute("pagenation", pagenation);

        }else {
            //쿼리값이 널이 아닌경우 : 사용자가 검색기능을 이용했기때문에 검색결과에 맞춘 val 값에따른 article get
            if (val.equals("newest")){
                ArrayList<AttendanceVo> articleList = service.getFilterArticleList(filterPagenation, query);
                request.setAttribute("list",articleList);
            }else if (val.equals("best")){
                ArrayList<AttendanceVo> bestArticleList = service.getBestFilterArticleList(filterPagenation, query);
                request.setAttribute("list",bestArticleList);
            }
            request.setAttribute("pagenation", filterPagenation);
        }


        request.setAttribute("val", val);
        request.setAttribute("filter", filter);
        request.setAttribute("keyword", keyword);

        ActionForward forward = new ActionForward();
        forward.setPath("/views/board.jsp");
        return forward;
    }

    private String makeSearchQuery(String filter, String keyword) {
        String querySearch = null;

        if (filter.equals("all")) {              //전체 검색
            querySearch = " title like '%" + keyword
                    + "%' or content like '%" + keyword + "%'";
        } else if (filter.equals("title")) {     //제목 검색
            querySearch = " title like '%" + keyword + "%'";
        } else {                                //내용 검색
            querySearch = " content like '%" + keyword + "%'";
        }
        return querySearch;
    }
}
