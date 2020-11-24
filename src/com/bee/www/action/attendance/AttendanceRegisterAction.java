package com.bee.www.action.attendance;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;
import com.bee.www.common.LoginManager;
import com.bee.www.common.RegExp;
import com.bee.www.service.BoardService;
import com.bee.www.vo.AttendanceVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

import static com.bee.www.common.RegExp.ARTICLE_CONTENT;

public class AttendanceRegisterAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        LoginManager lm = LoginManager.getInstance();
        String id = lm.getMemberId(request.getSession());
        //로그인 안돼있을때
        if (id == null) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인이 필요한 서비스 입니다.');location.href='/login.do';</script>");
            out.close();
            return null;
        }
        //write에서 데이터받아오기
        String content = request.getParameter("content");
        //글 번호 유효성검사,RegExp = 글 번호 유효성 검사
        if (content == null || content.equals("") || !RegExp.checkString(ARTICLE_CONTENT, content)) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.');history.back();</script>");
            out.close();
            return null;
        }

        BoardService service = new BoardService();
        //vo에 담음
        AttendanceVo vo = new AttendanceVo();
        vo.setContent(content);
        vo.setM_sq(service.getMemberSequence(id));

        if(!service.insertReviews(vo)){ //글 저장 service 호출
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('글 저장에 실패했습니다.');history.back();</script>");
            out.close();
            return null;
        }

        ActionForward forward = new ActionForward();
        forward.setPath("/attendance.do");
        forward.setRedirect(true);
        return forward;
    }
}
