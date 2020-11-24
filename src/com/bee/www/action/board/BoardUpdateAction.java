package com.bee.www.action.board;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;
import com.bee.www.common.LoginManager;
import com.bee.www.common.RegExp;
import com.bee.www.service.BoardService;
import com.bee.www.vo.AttendanceVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import static com.bee.www.common.RegExp.ARTICLE_NUM;

public class BoardUpdateAction implements Action {
    @Override
    public ActionForward execute
            (HttpServletRequest request, HttpServletResponse response) throws IOException {
        LoginManager lm = LoginManager.getInstance();
        String id = lm.getMemberId(request.getSession());

        //세션이없으면(로그인 안되어 있으면)
        if(id==null){
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인이 필요한 서비스 입니다.');location.href='/login.do';</script>");
            out.close();
            return null;
        }

        String num = request.getParameter("num");
        if (num == null || num.equals("")
                || !RegExp.checkString(ARTICLE_NUM, num)) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.');location.href='/';</script>");
            out.close();
            return null;
        }

        int numInt = Integer.parseInt(num);  //유효성 검사 후 글 번호 숫자로 변환
        //글 번호 유효성검사(2)-형변환 후,글 번호 0보다 작으면 오류alert
        if(numInt<=0){
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.(2)');history.back();</script>");
            out.close();
            return null;
        }

        BoardService service = new BoardService();
        AttendanceVo vo = service.getArticleDetail(numInt); //action-service
        if (vo == null) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.');location.href='/';</script>");
            out.close();
            return null;
        }

        ActionForward forward = new ActionForward();
        request.setAttribute("vo",vo); //view에게 vo넘김
        forward.setPath("/views/board-update.jsp");
        return forward;
    }
}
