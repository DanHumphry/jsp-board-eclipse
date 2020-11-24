package com.bee.www.action.Member;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;
import com.bee.www.service.BoardService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MemberCheckIdAction implements Action {
    @Override
    public ActionForward execute
            (HttpServletRequest request, HttpServletResponse response) throws IOException {

        String id = request.getParameter("id"); //join.jsp에서 id받아옴

        BoardService service = new BoardService();
        //0이면 미중복 1이면 중복
        request.setAttribute("count", service.idCheck(id));

        ActionForward forward = new ActionForward();
        forward.setPath("/views/Ajax/AjaxCheckId.jsp");
        return forward;
    }
}
