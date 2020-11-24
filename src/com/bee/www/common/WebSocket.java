package com.bee.www.common;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

import com.bee.www.config.HttpSessionConfigurator;
import com.bee.www.service.BoardService;
import com.bee.www.vo.MemberVo;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

// WebSocket의 호스트 주소 설정
@ServerEndpoint(value = "/chat.do/websocket", configurator = HttpSessionConfigurator.class)
public class WebSocket extends HttpServlet {
    private static Map<Session,MemberVo> users = Collections.synchronizedMap(new HashMap<>());
    LoginManager lm = LoginManager.getInstance();

    // WebSocket으로 브라우저가 접속하면 요청되는 함수
    @OnOpen
    public void onOpen(Session session, EndpointConfig config){
        String id = lm.getMemberId((HttpSession) config.getUserProperties().get(HttpSession.class.getName()));

        MemberVo client = new MemberVo();
        BoardService service = new BoardService();
        if (id != null){
            MemberVo vo = service.getMember(id);
            client.setNickname(vo.getNickname());
            client.setNewFileName(vo.getNewFileName());

            if (vo.getNewFileName() == null){
                client.setNewFileName("basic.jpg");
            }
        }
        client.setId(id);

        users.put(session, client);
        if(id!=null) {
            sendNotice(client.getNickname() + "님이 입장하셨습니다.");
        }//입장시 id값이 null이 아닐시 무조건적으로 sendNotice가 실행되서 입장이 sendText되게 설계
    }

    //입장과 퇴장시에 실행되는 sendNotice함수
    public void sendNotice(String message){
        String userName = "server";

        synchronized (users) {
            Iterator<Session> it = users.keySet().iterator();
            while(it.hasNext()){
                Session currentSession = it.next();
                try {
                    currentSession.getBasicRemote().sendText(userName + " : " + message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // WebSocket으로 메시지가 오면 요청되는 함수
    @OnMessage
    public void onMsg(String message, Session session) throws IOException{
        String userName = users.get(session).getNickname();
        String userImg = users.get(session).getNewFileName();

        synchronized (users) {
            Iterator<Session> it = users.keySet().iterator();
            while(it.hasNext()){
                Session currentSession = it.next();
                if(!currentSession.equals(session)){
                    currentSession.getBasicRemote().sendText(userImg + "/" +  userName + "/" + message);
                    //currentSession은 현재 접속해있는 유저의 session에 해당
                    //onMsg가 가지고 있는 session과 비교후 같지 않아야만 sendText실행
                    //즉 내가 보낸 메세지는 내가 받지않는다(front에서 내가 보낸 메세지는 내가 따로 확인되게 설계)
                }
            }
        }
    }

    // WebSocket과 브라우저가 접속이 끊기면 요청되는 함수
    @OnClose
    public void onClose(Session session) {
        String userName = users.get(session).getNickname();
        users.remove(session);
        if(userName!=null){
            sendNotice(userName + "님이 퇴장하셨습니다");
        }
    }

    // WebSocket과 브라우저 간에 통신 에러가 발생하면 요청되는 함수.
    @OnError
    public void handleError(Throwable t) {
// 콘솔에 에러를 표시한다.
        t.printStackTrace();
    }
}
