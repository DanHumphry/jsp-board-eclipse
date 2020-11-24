package com.bee.www.common;

import com.bee.www.action.Member.MemberLogoutAction;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import java.util.Enumeration;
import java.util.Hashtable;

public class LoginManager implements HttpSessionBindingListener {
    private static Hashtable loginUsers = new Hashtable();

    //생성자 꼭 있어야 함.
    public LoginManager() {
        super();
    }
    public static LoginManager getInstance(){
        return LoginManager.LazyHolder.INSTANCE;
    }

    //싱글톤으로 인스턴스 생성
    private static class LazyHolder{
        private static final LoginManager INSTANCE = new LoginManager();
    }

    //구현 객체가 세션에 바인딩 될때 호출됨
    @Override
    public void valueBound(HttpSessionBindingEvent event) {
        loginUsers.put(event.getSession(),event.getName());
    }

    //구현 객체가 세션에서 언바인딩(제거)될때 호출
    //직접 로그아웃 안눌러도 컴퓨터종료,세션만료 등등 로그아웃되기 때문에 따로 만듬
    @Override
    public void valueUnbound(HttpSessionBindingEvent event) {
        Action action = new MemberLogoutAction();
        ((MemberLogoutAction)action).logoutProc(getMemberId(event.getSession()));
        loginUsers.remove(event.getSession()); //오류고침
    }

    //로그아웃 버튼 눌렀을 때, 해쉬테이블 순차적으로 배치시킴,while 키 값이 존재하는동안,ession에 키 값 받아옴
    public void removeSession(String id){
        Enumeration e = loginUsers.keys();
        HttpSession session = null;
        while(e.hasMoreElements()){
            session=(HttpSession)e.nextElement();

            if(loginUsers.get(session).equals(id)){
                session.invalidate();
            }
        }
    }

    public void setSession(HttpSession session,String id){
        session.setAttribute(id,this);
    }
    public String getMemberId(HttpSession session){
        return (String)loginUsers.get(session);
    }
}
