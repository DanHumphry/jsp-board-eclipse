package com.bee.www.action.Member;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;
import com.bee.www.common.LoginManager;
import com.bee.www.service.BoardService;
import com.bee.www.vo.MemberVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class ChatAction implements Action {
    @Override
    public ActionForward execute
            (HttpServletRequest request, HttpServletResponse response) throws IOException {

        LoginManager lm = LoginManager.getInstance();
        String id = lm.getMemberId(request.getSession());

        if (id == null) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인이 필요한 서비스 입니다.');location.href='/login.do';</script>");
            out.close();
            return null;
        }

        BoardService service = new BoardService();
        MemberVo memberVo = service.getMember(id);

        if(memberVo.getNewFileName()==null){
            memberVo.setNewFileName("basic.jpg");
        }

        ActionForward forward = new ActionForward();
        request.setAttribute("vo",memberVo);
        forward.setPath("/views/chat.jsp");
        return forward;
    }
}
