package kr.co.vo;


public class Board 
{
	private int idx;
	private String title;
	private String writer;
	private String regdate;
	private int count;
	private int hit;
	private String content;	
	private String regip;
	private String filename;	

	public int getHit()
	{
		return hit;
	}
	public void setHit(int hit)
	{
		this.hit = hit;
	}
	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}
	public String getTitle()
{
		return title;
	}
	public void setTitle(String title)
{
		this.title = title;
	}
	public String getWriter() 
	{
		return writer;
	}
	public void setWriter(String writer) 
	{
		this.writer = writer;
	}
	public String getRegdate()
	{
		return regdate;
	}
	public void setRegdate(String regdate) 
	{
		this.regdate = regdate;
	}
	public int getCount() 
	{
		return count;
	}
	public void setCount(int count)
	{
		this.count = count;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getRegip()
	{
		return regip;
	}
	public void setRegip(String regip)
	{
		this.regip = regip;
	}
	public String getFilename()
	{
		return filename;
	}
	public void setFilename(String filename)
	{
		this.filename = filename;
	}
}
