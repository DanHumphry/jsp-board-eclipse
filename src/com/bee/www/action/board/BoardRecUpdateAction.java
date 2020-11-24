package com.bee.www.action.board;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;
import com.bee.www.common.LoginManager;
import com.bee.www.service.BoardService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardRecUpdateAction implements Action {

    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        // no와 id값을 map에 저장
        int no = Integer.parseInt(request.getParameter("no"));

        LoginManager lm = LoginManager.getInstance();
        String id = lm.getMemberId(request.getSession());

        BoardService service = new BoardService();
        int m_sq = service.getMemberSequence(id);
        int count = service.recCount(no);  // 게시글 총 추천수를 구함

        if(service.recCheck(no, m_sq)){
            service.recUpdate(no, m_sq); //추천 아직안했음 >> 해당 게시글의 sq와 유저 sq저장
            service.updateBoardRec(count + 1, no); // 해당게시글의 count를 증가
        }else{
            service.recDelete(no, m_sq); //추천 했음 삭제 ㄱㄱ
            service.updateBoardRec(count - 1, no);
        }
        return null;
    }
}
