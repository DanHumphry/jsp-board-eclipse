package com.bee.www.action.Member;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;
import com.bee.www.common.LoginManager;
import com.bee.www.service.BoardService;
import com.bee.www.vo.AttendanceVo;
import com.bee.www.vo.MemberVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.ArrayList;

public class ProfileUpdateAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        LoginManager lm = LoginManager.getInstance();
        String id = lm.getMemberId(request.getSession());

        String nick = request.getParameter("nick");

        BoardService service = new BoardService();
        //vo에 담음
        MemberVo vo = new MemberVo();
        vo.setNickname(nick);
        vo.setId(id);

        if(!service.profileUpdate(vo)){
            out.println("<script>alert('회원정보 수정에 실패했습니다.');history.back();</script>");
            out.close();
            return null;
        }

        out.println("<script>" +
                "alert('회원정보 수정 성공');" +
                "location.href='/profile.do?id="+id+"';" +
                "</script>");
        out.close();
        ActionForward forward = new ActionForward();
        forward.setPath("/profile.do?id="+id);
        return forward;
    }
}