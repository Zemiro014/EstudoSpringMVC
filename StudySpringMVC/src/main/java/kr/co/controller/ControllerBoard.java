package kr.co.controller;

import javax.inject.Inject;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	public void write() throws Exception
	{
		logger.info("writeView");
	}
	
	@RequestMapping(value = "/board/write", method = RequestMethod.POST)
	public String write(Board board) throws Exception 
	{
		logger.info("write");
		
		service.write(board);
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public String list(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception
	{
		logger.info("Listing the data");
		
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
		
		return "board/readView";
	}
	
	@RequestMapping(value="/updateView", method = RequestMethod.GET)
	public String updateView(Board board,@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception
	{
		logger.info("Displaying the date to Updating");
		
		model.addAttribute("update",service.read(board.getIdx()));
		model.addAttribute("scri", scri);
		
		return"board/updateView";
	}
	
	@RequestMapping(value="/update", method = RequestMethod.POST)
	public String update(Board board,@ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception
	{
		logger.info("updatind Date");
		
		service.update(board);
		
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/delete", method = RequestMethod.POST)
	public String delete(Board board, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception
	{
		logger.info("Deleting Date");
		
		service.delete(board.getIdx());
		
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/list";
	}
}
