package com.bee.www.action.board;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;
import com.bee.www.common.LoginManager;
import com.bee.www.service.BoardService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardRecCountAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        LoginManager lm = LoginManager.getInstance();
        String id = lm.getMemberId(request.getSession());

        int no = Integer.parseInt(request.getParameter("no"));

        BoardService service = new BoardService();

        int m_sq = service.getMemberSequence(id);
        int count = service.recCount(no);  // 게시글 총 추천수를 구함

        request.setAttribute("count", count);
        if(service.recCheck(no, m_sq)){
            request.setAttribute("onOff", 0);//아직 추천하지 않았을때 0전달
        }else{
            request.setAttribute("onOff", 1);//추천되있을때는 1전달
        }

        ActionForward forward = new ActionForward();
        forward.setPath("/views/Ajax/AjaxCheckRec.jsp");
        return forward;
    }
}
