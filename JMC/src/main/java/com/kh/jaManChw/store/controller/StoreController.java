package com.kh.jaManChw.store.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.jaManChw.admin.itemmanage.service.face.ItemQnAQService;
import com.kh.jaManChw.dto.ItemQnAQ;
import com.kh.jaManChw.dto.ShoppingBasket;
import com.kh.jaManChw.store.service.face.StoreService;
import com.kh.jaManChw.util.Paging;

@RequestMapping("/store")
@Controller
public class StoreController {
	
	//log4j.xml에서 <logger> 설정 필요
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired private StoreService storeService;
	
	@Autowired private ItemQnAQService itemQnAQService;
	
	@RequestMapping("/main")
	public void StoreMain() {
		logger.info("판매사이트 메인");
	}
	
	@RequestMapping("/shoppingbasket")
	public void PostStoreShoppingbasket(Model model, HttpSession session) {
		
		int userno = (Integer)session.getAttribute("userno");
		logger.info("세션 유저 넘버 {}", userno);
		List<Map<String, Object>> list = storeService.getShoppingbasketList(userno);
		logger.info("장바구니 조회결과{}", list);
		model.addAttribute("list", list);
		
	}
	
	@RequestMapping("/shoppingBasketDelete")
	public String StoreShoppingbasketDelete(@RequestParam Map<String, String> map, HttpSession session) {
		int userno = (Integer)session.getAttribute("userno");
		logger.info("세션 유저 넘버 {}", userno);
		logger.info("상품수량 갯수 {}", map);
      	map.put("userno", Integer.toString(userno));
      	logger.info("유저넘버 받아서 맵값 확인하기 {}", map);
      	
      	storeService.Shoppingbasketerase(map);
		 return "redirect:/store/shoppingbasket";
	}
	
	
	//칵테일 용품 카테고리로 이동 후 goods 리스트를 DESC순으로 불러오기 + Paging
	//+ goods관련 카테고리를 클릭하면 해당 카테고리 리스트만 불러온다.
	@RequestMapping("/goodsAll")
	public void goodsAll(String type, String searchData, String curPage,  Model model) {
		
		logger.info("검색 데이터: {}", searchData);
		
		Paging paging = storeService.getPage(curPage);
		
		logger.info("Paging {}", paging);
		
		logger.info("칵테일 용품 카테고리 메인");
		logger.info("type값 Goods로 가지고 오는지 : {}", type);
		logger.info("curPage : {}", curPage);
		
		//세션으로 가지고 가는 것도 방법이나 잘 모르겠음
		//logger.info("goods: {}", session.getAttribute("goodsAll"));

		List<Map<String, Object>> list = storeService.showAllGoods(type, searchData, paging);
		
		logger.info("용품의 리스트: {}", list);
		
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
	}
	
	@RequestMapping("/itemDetail")
	public void itemDetail(@Param("itemno") int itemno, String curPage, Model model) {
		logger.info("아이템 번호! : {}", itemno);
		
		Map<String, Object> allItemDetail = storeService.showDetailItem(itemno);
		
		logger.info("상품에 대한 자세한 정보: {}", allItemDetail);
		//---------------------------------------------------------
		Paging paging = itemQnAQService.getItemQnAQPaging(curPage);
		
		//★관리자에서 작성한 것!+selectAll이 아니라 해당 상품에 QNA만 가지고 오는 걸로 메서드 바꾸기!
		List<Map<String, Object>> itemQnAQList = itemQnAQService.showItemQnAQList2(itemQnAQService.getItemQnAQPaging(curPage), itemno);
		logger.info("itemQnAQList: {}", itemQnAQList);
		
		
		//--------------------------------------------------------
		model.addAttribute("curPage", curPage);
		model.addAttribute("allItemDetail", allItemDetail);
		


		model.addAttribute("itemQnAQList", itemQnAQList);
		model.addAttribute("paging", paging);
	}
	
	@RequestMapping("/storeBoard")
	public void storeBoard(String curPage, Model model) {
		

		
	}
	
	@GetMapping("/boardWrite2")
	public void getBoardWrite() {
		
	}
	
//	@PostMapping("/boardWrite2")
//	public void postBoardWrite(String modalTitle, String modalContent){
//		logger.info("★★★★★★★★여기 옴????");
//		logger.info(modalTitle);
//		logger.info(modalContent);
//	
//	}
	@RequestMapping(value = "/abcabc", method = RequestMethod.POST)
	@ResponseBody
	public void itemQnAWrite(String modalTitle, String modalContent, int itemno, HttpSession session,Model model) {
		logger.info("문의글 작성한 거 받아오기");
		logger.info(modalTitle);
		logger.info(modalContent);
		logger.info("item:{}",itemno);
		storeService.writeItemQnA(modalTitle, modalContent, itemno, session);
		
	}
	@RequestMapping("/buynow")
	public String Itembuynow(@RequestParam Map<String, String> map,
			String[] itemOptionno
			,String[] sbItemCount
			,HttpSession session
			,int itemno
			,Model model
			) {
		
		logger.info("가져왓나요?: {}",itemOptionno[0]);
		logger.info("가져왓나요?: {}",sbItemCount[0]);
		
		List<ShoppingBasket> sbList = storeService.getsbListParam(itemOptionno,sbItemCount, itemno, (Integer)session.getAttribute("userno"));
		logger.info("what:{}",sbList);
		storeService.writeShoppingBasket(sbList);
		int basketno = storeService.getbasketno();
		
		logger.info("맵출력 map{}", map);
//		return "redirect:../shoppingbasket"
		return "redirect:/payment/main?itemno="+map.get("itemno")+"&basketno="+basketno;
	}

	@PostMapping("/write/basket")
	public String shoppingBasketPage(
			String[] itemOptionno
			,String[] sbItemCount
			,HttpSession session
			,int itemno
			,Model model
			) {
		
		logger.info("가져왓나요?: {}",itemOptionno[0]);
		logger.info("가져왓나요?: {}",sbItemCount[0]);
		
		List<ShoppingBasket> sbList = storeService.getsbListParam(itemOptionno,sbItemCount, itemno, (Integer)session.getAttribute("userno"));
		logger.info("what:{}",sbList);
		storeService.writeShoppingBasket(sbList);

		return "redirect:../shoppingbasket";
	}
	
	@RequestMapping("/answer")
	@ResponseBody
	public Map<String,Object> itemQnAAnswer(ItemQnAQ itemQnAQ,Model model) {
		
		logger.info("ITEMQNQA의 값 : {}",itemQnAQ );
		
		
	Map<String,Object> map = storeService.getCommentDetail(itemQnAQ);
		
		logger.info("맵맵맵 : {}", map);
		model.addAttribute("map",map);
		
		return map;
	}
	
	@RequestMapping("/buylist")
	public void storeBuyList(HttpSession session, Model model) {
		
		String userno = String.valueOf(session.getAttribute("userno"));
		List<Map<String,String>> map = storeService.getBuyList(userno);
		logger.info("바이리스트 출력{}", map);
		model.addAttribute("buylist", map);
	}
	@RequestMapping("/detail")
	public void storeBuyDetail(HttpSession session, Model model, @RequestParam Map<String, String> map) {
		logger.info("바이리스트 출력{}", map);
		
		String userno = String.valueOf(session.getAttribute("userno"));
		map.put("userno", userno);
		List<Map<String,String>> list = storeService.getBuyDetail(map);
		logger.info("바이리스트 출력{}", list);
		model.addAttribute("buylist", list);
	}
}












