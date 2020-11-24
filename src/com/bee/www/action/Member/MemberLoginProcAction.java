package com.bee.www.action.Member;

import com.bee.www.common.*;
import com.bee.www.service.BoardService;
import com.bee.www.vo.MemberVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

import static com.bee.www.common.RegExp.*;

public class MemberLoginProcAction implements Action {
    @Override
    public ActionForward execute
            (HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        //view에서 값 받아오기
        String id = request.getParameter("id");
        String pwd = request.getParameter("pwd");

        //값 비어있는지,형식(정규식) 검사
        if (id == null || id.equals("") || !RegExp.checkString(MEMBER_ID, id)
                || pwd == null || pwd.equals("") || !RegExp.checkString(MEMBER_PWD, pwd)) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('잘못된 접근입니다');location.href='/';</script>");
            out.close();
            return null;
        }
        
        BoardService service = new BoardService();
        
        //memberVo에 값 set
        MemberVo memberVo = service.getMember(id); //service에서 sq,id,pwd가져오기

        //비번 비교 후 불일치할 때
        if(memberVo==null||!BCrypt.checkpw(pwd,memberVo.getPwd())){
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 정보를 확인해 주세요.');history.back();</script>");
            out.close();
            return null;
        }

        memberVo.setLgn_fl(true);   //로그인 상태로 변경

        if(!service.loginMember(memberVo)){ //service에서 로그인처리 호출(isSucess받아옴)
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 처리에 실패하였습니다.');location.href='/';</script>");
            out.close();
            return null;
        }

        LoginManager lm = LoginManager.getInstance();
        lm.setSession(request.getSession(),memberVo.getId()); //유저 id이름으로 세션등록,valueBound()호출

        //메인페이지로 이동
        ActionForward forward = new ActionForward();
        forward.setPath("/");
        forward.setRedirect(true);
        return forward;
    }
}
