package com.example.demo.svc;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.R_bbsDAO;
import com.example.demo.vo.R_ImgInfoVO;
import com.example.demo.vo.R_InterestVO;
import com.example.demo.vo.R_bbsIntVO;
import com.example.demo.vo.R_bbsVO;
import com.github.pagehelper.PageInfo;

@Service
public class R_bbsSVC {
	@Autowired
	private HttpSession session;
	
	@Autowired
	private HttpServletRequest req;
	
	@Autowired
	private R_bbsDAO dao;
	
	public boolean uploadFile(MultipartFile[] mfiles, R_bbsVO bbs) {
		ServletContext context = req.getServletContext();
	    //String savePath = context.getRealPath("/WEB-INF/upload");
		
		//String savePath = "C:\\Users\\Jieun\\Desktop\\직업훈련\\workspace\\Project1\\src\\main\\resources\\static\\upload";
		String savePath = "/opt/tomcat9/webapps/ROOT/WEB-INF/classes/static/upload";
	    String uid = (String)session.getAttribute("uid");
	    bbs.setAuthor(uid);
	    try {
	    	int rows = dao.insertAndGetKey(bbs);
	    	boolean exist = false;
	    	for(int i=0; i<mfiles.length; i++) {	// mfiles.length : 파일 갯수
	    		if(mfiles[i].getSize()!=0) {	// 사이즈가 0이 아니라면, 즉 존재한다면. 참고>파일의 사이즈(데이터의 크기)가 없으면 0
	    			exist = true;
	    			break;		// 여기서 메소드를 끝내라는 말이 아니라 파일이 하나라도 인식이 된다면 루프를 그만 돌려라는 뜻
	    		}
	    	}
	    	if(!exist) {
	    		if(rows!=0) {
	    			return true;
	    		} else {
	    			return false;
	    		}
	    	}
	    	
	    	int getKey = bbs.getNum();
	    	for(int i=0;i<mfiles.length;i++) {
	    		R_ImgInfoVO vo = new R_ImgInfoVO();
	    		vo.setBnum(getKey);
	    		
	    		String filename = mfiles[i].getOriginalFilename();
	    		long fileSize = mfiles[i].getSize();
	    		//String filePath = savePath+"\\"+filename;
	    		String filePath = savePath+"/"+filename;
	    		mfiles[i].transferTo(new File(filePath));
	    		
	    		vo.setFilename(filename);
	    		vo.setFilesize(fileSize);
	    		dao.insertImgInfo(vo);
	    	}
	        return true;
	        
	    } catch (Exception e) {
	    	e.printStackTrace();
	        return false;
	    }
	}
	
	public boolean addhitCnt(int num) {
		String uid = (String)session.getAttribute("uid");
		R_bbsVO bbs = dao.getBbsDetail(num);
		if(!bbs.getAuthor().equals(uid)) {
			dao.addHitCnt(num);
			return true;
		} else {
			return false;
		}	
	}
	
	public boolean addToInt(R_bbsIntVO bi) {
		String uid = (String)session.getAttribute("uid");
		bi.setUid(uid);
		return dao.addToInterest(bi)>0;		
	}
	
	public List<R_InterestVO> getIntList(){
		String uid = (String)session.getAttribute("uid");
		return dao.getIntList(uid);
	}
	
	public boolean delAllFromId() {
		String uid = (String)session.getAttribute("uid");
		return dao.delIntAll(uid)>0;
	}
	
	public PageInfo<R_bbsVO> search(int pageNum, int pageSize, String search){
		String srched = (String)session.getAttribute("search");
		session.setAttribute("search", search);
		
		if(!search.equals(srched)) {		
			PageInfo<R_bbsVO> npgInfo = dao.findWithoutNum(1, pageSize, search);
			return npgInfo;
		} else {	
			PageInfo<R_bbsVO> pgInfo = dao.findWithoutNum(pageNum, pageSize, search);
			return pgInfo;
		}
	}
	
}
