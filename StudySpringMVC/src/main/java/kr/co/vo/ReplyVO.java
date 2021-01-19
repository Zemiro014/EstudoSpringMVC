package kr.co.vo;

import java.sql.Date;

public class ReplyVO
{
	private int idx;
	private int id_r;
	private String content;
	private String writer;
	private Date regdate;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getId_r() {
		return id_r;
	}
	public void setId_r(int id_r) {
		this.id_r = id_r;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "ReplyVo [idx=" + idx + ", id_r=" + id_r + ", content=" + content + ", writer=" + writer + ", regdate="
				+ regdate + "]";
	}
	
}
