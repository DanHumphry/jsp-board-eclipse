package com.bee.www.action.board;

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
import static com.bee.www.common.RegExp.ARTICLE_NUM;

public class FixCommentInAction implements Action {

    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");

        String content = request.getParameter("content");
        String num = request.getParameter("num");

        BoardService service = new BoardService();

        if(content == null || !RegExp.checkString(ARTICLE_CONTENT, content) || content.equals("")){
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.(0)');history.back();</script>");
            out.close();
            return null;
        }
        if (num == null || num.equals("")
                || !RegExp.checkString(ARTICLE_NUM, num)) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.(1)');location.href='/';</script>");
            out.close();
            return null;
        }
        int numInt = Integer.parseInt(num);
        if(numInt<=0){
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다.(2)');history.back();</script>");
            out.close();
            return null;
        }

        AttendanceVo vo = new AttendanceVo();
        vo.setC_sq(numInt);
        vo.setContent(content);

        if (!service.fixInsertComment(vo)) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('댓글수정 실패.');history.back();</script>");
            out.close();
            return null;
        }

        return null;
    }
}
