package kr.co.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.service.BoardService;
import kr.co.service.ReplyService;
import kr.co.vo.Board;
import kr.co.vo.PageMaker;
import kr.co.vo.ReplyVO;
import kr.co.vo.SearchCriteria;

/**
 * Handles requests for the application pages.
 */
@Controller
@RequestMapping("/board/*")
public class ControllerBoard
{
	private static final Logger logger = LoggerFactory.getLogger(ControllerBoard.class);
	
	@Inject
	BoardService service;
	
	@Inject
	ReplyService replyService;
	
	@RequestMapping(value = "/writeView", method = RequestMethod.GET)
	public void writeView() throws Exception
	{
		logger.info("WriteView or showing the registration form to the user");
	}
	
	@RequestMapping(value = "/board/write", method = RequestMethod.POST)
	public String write(Board board, MultipartHttpServletRequest mpRequest) throws Exception 
	{
		logger.info("Write or Passing form records to the database");
		
		service.write(board, mpRequest);
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public String list(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception
	{
		logger.info("Listing the data or Listing the database data from the BOARD table");
		
		model.addAttribute("list",service.list(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		
		model.addAttribute("pageMaker",pageMaker);
		return "/board/list";
	}
	
	@RequestMapping(value="/readView", method = RequestMethod.GET)
	public String read(Board board, @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception
	{
		logger.info("Reading the data");
		
		model.addAttribute("read", service.read(board.getIdx()));
		model.addAttribute("scri", scri);
		
		List<ReplyVO> replyList = replyService.readReply(board.getIdx());
		model.addAttribute("replyList",replyList);
		
		List<Map<String, Object>> fileList = service.selectFileList(board.getIdx());
		model.addAttribute("file",fileList);
		
		return "board/readView";
	}
	
	@RequestMapping(value="/updateView", method = RequestMethod.GET)
	public String updateView(Board board,@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception
	{
		logger.info("Displaying the date to Updating");
		
		model.addAttribute("update",service.read(board.getIdx()));
		model.addAttribute("scri", scri);
		
		List<Map<String, Object>> fileList = service.selectFileList(board.getIdx());
		model.addAttribute("file", fileList);
		
		return"board/updateView";
	}
	
	@RequestMapping(value="/update", method = RequestMethod.POST)
	public String update(Board board,@ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr, @RequestParam(value="fileNoDel[]") String[] files,
			 				@RequestParam(value="fileNameDel[]") String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception
	{
		logger.info("Udatind Date or Passing the updated data to the database in the BOARD table");
		
		service.update(board, files, fileNames, mpRequest);
		
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/delete", method = RequestMethod.POST)
	public String delete(Board board, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception
	{
		logger.info("Deleting Date in the BOARD table");
		
		service.delete(board.getIdx());
		
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = "/replyWrite", method = RequestMethod.POST)
	public String replyWrite(ReplyVO rVO, SearchCriteria scri, RedirectAttributes rttr) throws Exception
	{
		logger.info("Replying Write");
		
		replyService.writeReply(rVO);
		
		rttr.addAttribute("idx", rVO.getIdx());
		rttr.addAttribute("page",scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword",scri.getKeyword());
		
		return "redirect:/board/readView";
	}
	
	@RequestMapping(value = "/replyUpdateView", method=RequestMethod.GET)
	public String replyUpdateView(ReplyVO rVO, SearchCriteria scri, Model model) throws Exception
	{
		logger.info("Display Replying Write");
		
		model.addAttribute("replyUpdate", replyService.selectReply(rVO.getId_r()));
		model.addAttribute("scri", scri);		
		
		return "board/replyUpdateView";
	}
	
	@RequestMapping(value="/replyUpdate", method=RequestMethod.POST)
	public String replyUpdate(ReplyVO rVO, SearchCriteria scri, RedirectAttributes rttr) throws Exception
	{
		logger.info("Replying Write");
		
		replyService.updateReplay(rVO);
		rttr.addAttribute("idx", rVO.getIdx());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType",scri.getSearchType());
		rttr.addAttribute("keyword",scri.getKeyword());
		
		return "redirect:/board/readView";
	}
	
		//GET Delete Comment
		@RequestMapping(value="/replyDeleteView", method = RequestMethod.GET)
		public String replyDeleteView(ReplyVO rVO, SearchCriteria scri, Model model) throws Exception 
		{
			logger.info("reply Write");
			
			model.addAttribute("replyDelete", replyService.selectReply(rVO.getId_r()));
			model.addAttribute("scri", scri);
			

			return "board/replyDeleteView";
		}
		
		//Delete comment
		@RequestMapping(value="/replyDelete", method = RequestMethod.POST)
		public String replyDelete(ReplyVO rVO, SearchCriteria scri, RedirectAttributes rttr) throws Exception 
		{
			logger.info("reply Write");
			
			replyService.deleteReply(rVO);
			
			rttr.addAttribute("idx", rVO.getIdx());
			rttr.addAttribute("page", scri.getPage());
			rttr.addAttribute("perPageNum", scri.getPerPageNum());
			rttr.addAttribute("searchType", scri.getSearchType());
			rttr.addAttribute("keyword", scri.getKeyword());
			
			return "redirect:/board/readView";
		}
		
		@RequestMapping(value="/fileDown")
		public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception
		{
			Map<String, Object> resultMap = service.selectFileInfo(map);
			String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
			String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
			
			// // Leia o arquivo anexado do local onde o arquivo foi salvo e converta-o no formato byte [].
			byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\mp\\file\\"+storedFileName));
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
}
