package kr.co.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.service.BoardService;
import kr.co.vo.Board;
import kr.co.vo.Criteria;
import kr.co.vo.PageMaker;

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
	public String list(Model model, Criteria cri) throws Exception
	{
		logger.info("Listing the data");
		
		model.addAttribute("list",service.list(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());
		
		model.addAttribute("pageMaker",pageMaker);
		return "/board/list";
	}
	
	@RequestMapping(value="/readView", method = RequestMethod.GET)
	public String read(Board board, Model model) throws Exception
	{
		logger.info("Reading the data");
		
		model.addAttribute("read", service.read(board.getIdx()));
		return "board/readView";
	}
	
	@RequestMapping(value="/updateView", method = RequestMethod.GET)
	public String updateView(Board board, Model model) throws Exception
	{
		logger.info("updateView");
		
		model.addAttribute("update",service.read(board.getIdx()));
		
		return"board/updateView";
	}
	
	@RequestMapping(value="/update", method = RequestMethod.POST)
	public String update(Board board) throws Exception
	{
		logger.info("update");
		
		service.update(board);
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/delete", method = RequestMethod.POST)
	public String delete(Board board) throws Exception
	{
		logger.info("delete");
		
		service.delete(board.getIdx());
		
		return "redirect:/board/list";
	}
}
