package com.bee.www.controller;

import com.bee.www.action.Member.*;
import com.bee.www.action.attendance.AttendanceAction;
import com.bee.www.action.attendance.AttendanceRegisterAction;
import com.bee.www.action.board.*;
import com.bee.www.common.Action;
import com.bee.www.common.ActionForward;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("*.do")
public class BoardController extends HttpServlet {
    public BoardController() {
        super();
    }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String RequestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String command = RequestURI.substring(contextPath.length());

        ActionForward forward = null;
        Action action = null;

        if (command.equals("/join.do")) {
            action = new MemberJoinAction();
            try {
                forward = action.execute(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (command.equals("/joinProc.do")) {
            action = new MemberJoinProcAction();
            try {
                forward = action.execute(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (command.equals("/login.do")) {
            action = new MemberLoginAction();
            try {
                forward = action.execute(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (command.equals("/loginProc.do")) {
            action = new MemberLoginProcAction();
            try {
                forward = action.execute(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }else if (command.equals("/logout.do")) {
            action = new MemberLogoutAction();
            try {
                forward = action.execute(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }else if(command.equals("/checkId.do")){
            action = new MemberCheckIdAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/checkEmail.do")){
            action = new MemberCheckEmailAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/attendance.do")){
            action = new AttendanceAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/attendanceRegister.do")){
            action = new AttendanceRegisterAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/board.do")){
            action = new BoardAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/boardWrite.do")){
            action = new BoardWriteAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/boardRegister.do")){
            action = new BoardRegisterAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/board-detail.do")){
            action = new BoardDetailAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/board-update.do")){
            action = new BoardUpdateAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/board-updateProc.do")){
            action = new BoardDetailProcAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/board-delete.do")){
            action = new BoardDeleteAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/profile.do")){
            action = new ProfileAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/profileUpdate.do")){
            action = new ProfileUpdateAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/profileImgUpdate.do")){
            action = new ProfileImgUpdateAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/recUpdate.do")){
            action = new BoardRecUpdateAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/recCount.do")){
            action = new BoardRecCountAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/commentIn.do")){
            action = new CommentInAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/reCommentIn.do")){
            action = new ReCommentInAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/fixCommentIn.do")){
            action = new FixCommentInAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/delComment.do")){
            action = new DelCommentAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/fixReCommentIn.do")){
            action = new FixReCommentInAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/delReComment.do")){
            action = new DelReCommentAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/chat.do")){
            action = new ChatAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(command.equals("/memberDelete.do")){
            action = new MemberDeleteAction();
            try{
                forward = action.execute(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }

        if (forward != null) {
            if (forward.isRedirect()) {
                response.sendRedirect(forward.getPath());
            } else {
                RequestDispatcher dispatcher
                        = request.getRequestDispatcher(forward.getPath());
                dispatcher.forward(request, response);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
}
