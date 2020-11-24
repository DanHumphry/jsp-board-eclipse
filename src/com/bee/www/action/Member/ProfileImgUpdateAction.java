package com.bee.www.action.Member;

import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;
import com.bee.www.common.LoginManager;
import com.bee.www.service.BoardService;
import com.bee.www.vo.MemberVo;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.PrintWriter;

public class ProfileImgUpdateAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        LoginManager lm = LoginManager.getInstance();
        String id = lm.getMemberId(request.getSession());

        BoardService service = new BoardService();
        MemberVo vo = new MemberVo();

        String saveDirectory = request.getServletContext().getRealPath("/resources/img");

        File saveDir = new File(saveDirectory);
        if (!saveDir.exists())
            saveDir.mkdirs();
        int maxPostSize = 1024 * 1024 * 10;
        String encoding = "UTF-8";

        FileRenamePolicy policy = new DefaultFileRenamePolicy();
        MultipartRequest mrequest
                = new MultipartRequest(request //MultipartRequest를 만들기 위한 request
                , saveDirectory //저장 위치
                , maxPostSize //최대크기
                , encoding //인코딩 타입
                , policy); //파일 정책

        String originalFileName = mrequest.getOriginalFileName("imgFile"); //기존 이름
        String filesystemName = mrequest.getFilesystemName("imgFile"); //기존

        vo.setId(id);
        vo.setAddress(saveDirectory);
        vo.setFilename(originalFileName);
        vo.setNewFileName(filesystemName);

        if(!service.profileImgUpdate(vo)){
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
        forward.setPath("/profile.do?id=" + id);
        return forward;
    }
}
