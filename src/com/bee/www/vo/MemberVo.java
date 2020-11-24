package com.bee.www.vo;

public class MemberVo {
    private int mem_sq;
    private String id;
    private String pwd;
    private String nickname;
    private String email;
    private boolean lgn_fl;

    private String filename;
    private String address;
    private String newFileName;

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNewFileName() {
        return newFileName;
    }

    public void setNewFileName(String newFileName) {
        this.newFileName = newFileName;
    }

    public int getMem_sq() {
        return mem_sq;
    }

    public void setMem_sq(int mem_sq) {
        this.mem_sq = mem_sq;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isLgn_fl() {
        return lgn_fl;
    }

    public void setLgn_fl(boolean lgn_fl) {
        this.lgn_fl = lgn_fl;
    }
}
