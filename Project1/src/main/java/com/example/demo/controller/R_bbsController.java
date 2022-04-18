package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.R_bbsDAO;
import com.example.demo.svc.R_UserSVC;
import com.example.demo.svc.R_bbsSVC;
import com.example.demo.vo.R_bbsDetailVO;
import com.example.demo.vo.R_bbsIntVO;
import com.example.demo.vo.R_bbsVO;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/bbs")
public class R_bbsController {
	
	@Autowired
	private R_bbsDAO dao;
	
	@Autowired
	private R_bbsSVC svc;
	
	@Autowired
	private R_UserSVC usvc;
	
	@GetMapping("/upload")
	public String insert(Model m) {
		if(usvc.isLogin()) {
			return "bbs_upload";
		} else {
			m.addAttribute("msg", "로그인 후에 사용 가능합니다. 로그인 페이지로 이동합니다.");
			return "loginform";
		}
	}
	
	@PostMapping("/upload")
	@ResponseBody
	public String insertBbs(@RequestParam("img_file")MultipartFile[] mfiles, R_bbsVO bbs) {
		return String.format("{\"uploaded\":%b}", svc.uploadFile(mfiles, bbs));
	}
	
	/*
	@GetMapping("/list/rep")
	public String getBbsListPage(@PageableDefault(page=0, size=5)Pageable pageable, Model m) {
		Page<R_bbsVO> pageInfo = rep.findAll(pageable);
		
		if(pageInfo.getNumber()-5 <1) {
			m.addAttribute("start", 1);
		}else {
			m.addAttribute("start", pageInfo.getNumber()-5);
		}
	       
		if(pageInfo.getTotalPages()< pageInfo.getNumber()+5) {
			m.addAttribute("end", pageInfo.getTotalPages());
		}else {
			m.addAttribute("end", pageInfo.getNumber()+5);
		}
	       
		m.addAttribute("page", pageInfo);
		
		return "bbs_list_page";
	}*/	
	
	@GetMapping("/list/page/{pgNum}")
	public String getListByPage(@PathVariable("pgNum")int pg, Model m) {
		PageInfo<R_bbsVO> pgInfo = dao.getBbsListPage(pg, 5);	// 한 페이지 당 5개씩으로 설정
		m.addAttribute("pageInfo", pgInfo);
		return "bbs_list_page";
		//return "bbs_list";
	}
		
	@GetMapping("/list/search")
	public String search(@RequestParam("pgNum")int pg, @RequestParam("search")String search, Model m) {
		PageInfo<R_bbsVO> pgInfo = svc.search(pg, 5, search);
		m.addAttribute("pageInfo", pgInfo);
		m.addAttribute("srch", true);
		return "bbs_list_page";
		//return "bbs_list";
	}
	
	@GetMapping("/detail/{num}")
	public String bbsDetail(@PathVariable("num")int num, Model m) {
		List<R_bbsDetailVO> list = dao.getBbsImg(num);
		m.addAttribute("bdlist", list);
		m.addAttribute("detail", dao.getBbsDetail(num));
		svc.addhitCnt(num);
		return "bbs_detail";
	}

	@GetMapping("/soldout/{num}")
	public String soldOut(@PathVariable("num")int num) {
		dao.updateTitle(num);
		return "redirect:/bbs/detail/{num}";
	}
	
	@GetMapping("/update/{num}")
	public String bbsUpdateForm(@PathVariable("num")int num, Model m) {
		if(usvc.isLogin()) {
			m.addAttribute("bbs", dao.getBbsDetail(num));
			return "bbs_update";
		} else {
			m.addAttribute("msg", "로그인 후에 사용 가능합니다. 로그인 페이지로 이동합니다.");
			return "loginform";
		}
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String bbsUpdate(R_bbsVO bbs) {
		boolean ok = dao.updateBbs(bbs)>0;
		return String.format("{\"updated\":%b}", ok);
	}
	
	@GetMapping("/delete/{num}")
	@ResponseBody
	public String deleteBbs(@PathVariable("num")int num) {
		return String.format("{\"deleted\":%b}", dao.deleteBbs(num));
	}
	
	@PostMapping("/interest/add")
	@ResponseBody
	public String addToInt(R_bbsIntVO bi) {
		return String.format("{\"saved\":%b}", svc.addToInt(bi));
	}
	
	@GetMapping("/interest/show")
	public String showInt(Model m) {
		if(usvc.isLogin()) {
			m.addAttribute("list", svc.getIntList());
			return "bbs_showinterest";
		} else {
			m.addAttribute("msg", "로그인 후에 사용 가능합니다. 로그인 페이지로 이동합니다.");
			return "loginform";
		}
	}
	
	@GetMapping("/interest/del/{lnum}")
	public String delete(@PathVariable("lnum")int lnum) {
		dao.deleteInt(lnum);
		return "redirect:/bbs/interest/show";
	}
	
	@GetMapping("/interest/delall")
	public String delAll() {
		svc.delAllFromId();
		return "redirect:/bbs/interest/show";
	}
	
}
