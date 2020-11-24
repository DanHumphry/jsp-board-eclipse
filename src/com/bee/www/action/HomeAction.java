package com.bee.www.action;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HomeAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ActionForward forward = new ActionForward();
        forward.setPath("/views/index.jsp");
        return forward;
    }
}
