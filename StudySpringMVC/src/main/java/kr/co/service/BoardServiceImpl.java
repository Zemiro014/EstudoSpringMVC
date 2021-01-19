package kr.co.service;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

//import com.sun.javafx.collections.MappingChange.Map;

import kr.co.dao.BoardDAO;
import kr.co.util.FileUtils;
import kr.co.vo.Board;
import kr.co.vo.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService
{
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	@Inject
	private BoardDAO dao;
	
	@Override
	public void write(Board board, MultipartHttpServletRequest mpRequest) throws Exception
	{
		dao.write(board);
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(board, mpRequest);
		int size = list.size();
		for(int i=0; i<size; i++)
		{ 
			dao.insertFile(list.get(i)); 
		}
	}

	@Override
	public List<Board> list(SearchCriteria scri) throws Exception
	{
		return dao.list(scri);
	}
	
	@Override
	public int listCount(SearchCriteria scri) throws Exception
	{
		return dao.listCount(scri);
	}

	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public Board read(int idx) throws Exception 
	{
		dao.boardHit(idx);
		return dao.read(idx);
	}

	@Override
	public void delete(int idx) throws Exception
	{
		dao.delete(idx);
	}

	@Override
	public List<Map<String, Object>> selectFileList(int idx) throws Exception
	{		
		return dao.selectFile(idx);
	}

	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception 
	{		
		return dao.selectFileInfo(map);
	}

	@Override
	public void update(Board board, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception 
	{
		dao.update(board);
		
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(board, files, fileNames, mpRequest);
		
		Map<String, Object> tempMap = null;
		int size = list.size();
		for(int i = 0; i<size; i++) 
		{
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) 
			{
				dao.insertFile(tempMap);
			}
			else 
			{
				dao.updateFile(tempMap);
			}
		}
	}
}
