package com.bee.www.action.attendance;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;
import com.bee.www.service.BoardService;
import com.bee.www.vo.AttendanceVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public class AttendanceAction implements Action {
    @Override
    public ActionForward execute
            (HttpServletRequest request, HttpServletResponse response) {
        BoardService service = new BoardService();

        ArrayList<AttendanceVo> ReviewsList = service.getReviewsList();
        request.setAttribute("list",ReviewsList);

        ActionForward forward = new ActionForward();
        forward.setPath("/views/attendance.jsp");
        return forward;
    }
}
