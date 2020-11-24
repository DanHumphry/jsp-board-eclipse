package com.bee.www.action.Member;

import com.bee.www.common.*;
import com.bee.www.service.BoardService;
import com.bee.www.vo.MemberVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

import static com.bee.www.common.RegExp.*;

public class MemberJoinProcAction implements Action {
    @Override
    public ActionForward execute
            (HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        //view에서 값 받아오기
        String id = request.getParameter("id");
        String pwd = request.getParameter("pwd");
        String pwd_confirm = request.getParameter("pwd_confirm");
        String email = request.getParameter("email");
        String nick = request.getParameter("nick");

        //값 비어있는지,형식(정규식) 검사
        if (id == null || id.equals("") || !RegExp.checkString(MEMBER_ID, id)
                || pwd == null || pwd.equals("") || !RegExp.checkString(MEMBER_PWD, pwd)
                || nick == null || nick.equals("")
//                || !RegExp.checkString(MEMBER_NICK, nick)
                || email == null || email.equals("") || !RegExp.checkString(MEMBER_EMAIL, email)) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다');location.href='/';</script>");
            out.close();
            return null;
        }

        //pwd,pwd확인 일치하는지 검사
        if (!pwd.equals(pwd_confirm)) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('두 비밀번호가 일치하지 않습니다.');location.href='/';</script>");
            out.close();
            return null;
        }

        //memberVo에 값 set
        MemberVo memberVo = new MemberVo();
        memberVo.setId(id);
        memberVo.setPwd(BCrypt.hashpw(pwd, BCrypt.gensalt(12)));
        memberVo.setEmail(email);
        memberVo.setNickname(nick);

        //service 호출
        BoardService service = new BoardService();
        if (!service.joinMember(memberVo)) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('회원 가입에 실패하였습니다.');location.href='/';</script>");
            out.close();
            return null;
        }else{
            memberVo.setLgn_fl(true);
            LoginManager lm = LoginManager.getInstance();
            lm.setSession(request.getSession(),memberVo.getId());
        }

        //메인페이지로 이동
        ActionForward forward = new ActionForward();
        forward.setPath("/");
        forward.setRedirect(true);
        return forward;
    }
}
