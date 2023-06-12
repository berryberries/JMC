package com.kh.jaManChw.mypage.controller;


import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.jaManChw.dto.ProfileFile;
import com.kh.jaManChw.dto.Users;
import com.kh.jaManChw.mypage.service.face.MypageService;


@Controller
public class MypageController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired MypageService mypageService;
	
	//서블릿 컨텍스트 객체
	@Autowired ServletContext context;
	
	// 마이페이지 메인
	@GetMapping("/mypage/main")
	public void mypageMain(Users users,Model model,HttpSession session,ProfileFile profileFile) {
		
		//세션에 저장된 정보 가져오기
		ProfileFile profile = new ProfileFile();
		
		profile.setProfileStoredName((String)session.getAttribute("profileStoredName"));
		profile.setProfileno((int)session.getAttribute("userno"));
		
		
		int userno = (Integer)session.getAttribute("userno");
		users.setUserno(userno);
		
		logger.info("profileFile : {}", profileFile);
		model.addAttribute("profile", profileFile);
		
		//유저 정보 가져오기 - 메인에서 로그인한 유저 정보 조회
		Users loginInfo = mypageService.getloginInfo(users);
		model.addAttribute("loginInfo", loginInfo);
		
		logger.info("users :{}",users);
		logger.info("loginInfo : {}", loginInfo);	
		logger.info("profileFile : {}", profileFile);	
		
	}

	// 마이페이지 정보수정
	@GetMapping("/mypage/userInfo")
	public void userInfoPage(Model model,Users users,HttpSession session) {
		
		//세션에 저장된 userno 가져오기
		int userno = (Integer)session.getAttribute("userno");
		users.setUserno(userno);
		
		Users loginInfo = mypageService.getloginInfo(users);
		model.addAttribute("loginInfo", loginInfo);
		
	}
	
	// 유저 정보 수정
	@PostMapping("/mypage/userInfo")
	public String changeInfo(Users users,HttpSession session) {
		
		int res = mypageService.changeInfo(users);
		
		if(res>0) {
			logger.info("정보수정 성공");
			return "redirect:/mypage/main";
			
		}else {
			logger.info("정보수정 실패");
			session.invalidate();
			return "redirect:/mypage/userInfo";
		}
		
	}
	
//-----------------------------------------------------------
	// 회원탈퇴 페이지
	@GetMapping("/mypage/delete")
	public void deletePage() {}
	
	// 회원탈퇴
	@PostMapping("/mypage/delete")
	public String deleteUser(Users users,HttpSession session) {
		int res = mypageService.deleteUser(users);
		
		if(res>0) {
			logger.info("회원탈퇴 성공");
			return "redirect:/login/logout";
		}else {
			logger.info("회원탈퇴 실패");
			session.invalidate();
			return "redirect:/mypage/userInfo";
		}
	}
//-----------------------------------------------------------
	// 프로필사진수정 페이지
	@GetMapping("/mypage/profile")
	public void profilePage(HttpSession session,ProfileFile profileFile,Model model) {
		
		
		//mypageService.getSession(session,profileFile,model);
		
		// 세션에 담긴 정보 가져오기
		profileFile.setUserno((Integer)session.getAttribute("userno"));
		profileFile.setProfileStoredName((String)session.getAttribute("profileStoredName"));
	
		Users info = new Users();
		info.setUserno((int)session.getAttribute("userno"));
	
		//파일 정보 가져오기
		ProfileFile profile = mypageService.fileInfo(info);
	
		model.addAttribute("profile", profile);
		logger.info("profile:{}",profile);

				
	}
	
	// 프로필사진 수정
	@PostMapping("/mypage/profile")
	public String uploadProfile(MultipartFile file, HttpSession session,ProfileFile profileFile,Model model,Users users) {

		logger.info("file:{}",file);

		// userno 세션에서 가져오기
		profileFile.setUserno((Integer)session.getAttribute("userno"));
		session.setAttribute("profile", profileFile.getProfileStoredName());
		
		
		// 파일이 있으면 -> 업로드할 파일이 있으면
		if(!file.isEmpty()) {	
			
			// 프로필 저장
			mypageService.profileSave(file,session,profileFile);
			
			// 파일의 저장이름 세션에 저장
			String profileStoredName = (String)session.getAttribute("profileStroedName");
			profileFile.setProfileStoredName(profileStoredName);
		}
		
		return "redirect:/mypage/main";

	}
	

//-----------------------------------------------------------	
	//유저 검색 기능	
//	@GetMapping("/mypage/friendList")
//	@ResponseBody
//	public List<Users> getuserSearchList(@RequestParam("type") String type,
//								@RequestParam("keyword") String keyword,Model model) throws Exception {
//									
//		Users users = new Users();
//		users.setType(type);
//		users.setKeyword(keyword);
//
//		return mypageService.getSearchLists(users);
//	}



}
