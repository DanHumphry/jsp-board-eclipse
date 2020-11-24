package com.bee.www.common;

public class Pagenation {
    private final int SHOW_ARTICLE_COUNT = 10;    //한 페이지에 보여줄 글 개수
    private final int PAGE_GROUP = 5;            //페이지 그룹 개수
    private int nowPageNumber;                  //현재 페이지 번호
    private int totalArticleCount;              //글 총 개수
    private int startArticleNumber;             //시작 글 번호
    private int totalPageCount;                 //총 페이지 개수

    //시작 페이지,끝 페이지
    private int startPage;
    private int endPage;

    public Pagenation(int nowPageNumber, int totalArticleCount) {
        this.nowPageNumber = nowPageNumber;
        this.totalArticleCount = totalArticleCount;
        //시작 글 번호=(현재 페이지 번호-1)*10
        this.startArticleNumber=(nowPageNumber-1)*SHOW_ARTICLE_COUNT;   //
        //총 페이지 개수=double(총페이지개수/10)을 Math.ceil(올림)
        this.totalPageCount=(int)Math.ceil((double)totalArticleCount/SHOW_ARTICLE_COUNT);
        //총 페이지개수가 1보다 작으면 1로
        if(this.totalPageCount<1){
            this.totalPageCount=1;
        }
        //시작 페이지 수 = 37(현재 페이지 번호)/10(페이지 묶음)+1 = 3*10+1 = 31
        this.startPage
                =((int)(((double)nowPageNumber/PAGE_GROUP+0.9)-1))*PAGE_GROUP+1;
        //끝 페이지 수 = 시작페이지 수 + (페이지 그룹-1)
        this.endPage=this.startPage+(PAGE_GROUP-1);
        //만약 끝 페이지수가 총 페이지개수보다 크다면 끝페이지는 페이지개수
        if(this.endPage>this.totalPageCount){
            this.endPage=this.totalPageCount;
        }
    }

    public int getSHOW_ARTICLE_COUNT() {
        return SHOW_ARTICLE_COUNT;
    }

    public int getNowPageNumber() {
        return nowPageNumber;
    }

    public void setNowPageNumber(int nowPageNumber) {
        this.nowPageNumber = nowPageNumber;
    }

    public int getTotalArticleCount() {
        return totalArticleCount;
    }

    public void setTotalArticleCount(int totalArticleCount) {
        this.totalArticleCount = totalArticleCount;
    }

    public int getStartArticleNumber() {
        return startArticleNumber;
    }

    public void setStartArticleNumber(int startArticleNumber) {
        this.startArticleNumber = startArticleNumber;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public int getTotalPageCount() {
        return totalPageCount;
    }

    public void setTotalPageCount(int totalPageCount) {
        this.totalPageCount = totalPageCount;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
}
