package com.bee.www.action.board;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;
import com.bee.www.common.LoginManager;
import com.bee.www.common.RegExp;
import com.bee.www.dao.BoardDAO;
import com.bee.www.service.BoardService;
import com.bee.www.vo.AttendanceVo;
import com.bee.www.vo.MemberVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import static com.bee.www.common.RegExp.ARTICLE_NUM;

public class BoardDetailAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String num = request.getParameter("num");
        LoginManager lm = LoginManager.getInstance();
        String id = lm.getMemberId(request.getSession());

        //글 번호 유효성검사,RegExp = 글 번호 유효성 검사
        if (num == null || num.equals("") || !RegExp.checkString(ARTICLE_NUM, num)) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.');history.back();</script>");
            out.close();
            return null;
        }

        int numInt = Integer.parseInt(num);  //유효성 검사 후 글 번호 숫자로 변환
        //글 번호 0보다 작으면 오류alert
        if (numInt <= 0) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.');history.back();</script>");
            out.close();
            return null;
        }
        BoardService service = new BoardService();
        AttendanceVo vo = service.getArticleDetail(numInt);    //detail service 호출

        ArrayList<AttendanceVo> list = service.getComment(numInt);
        ArrayList<AttendanceVo> ReList = service.getReComment();

        if (vo == null) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.');history.back();</script>");
            out.close();
            return null;
        }
        if (list == null) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.');history.back();</script>");
            out.close();
            return null;
        }

        ActionForward forward = new ActionForward();
        request.setAttribute("vo", vo);
        request.setAttribute("list", list);
        request.setAttribute("ReList", ReList);
        forward.setPath("/views/board-detail.jsp");
        return forward;
    }
}
