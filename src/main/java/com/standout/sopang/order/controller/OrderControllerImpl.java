package com.standout.sopang.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.standout.sopang.common.base.BaseController;
import com.standout.sopang.goods.vo.GoodsVO;
import com.standout.sopang.member.vo.MemberVO;
import com.standout.sopang.order.service.ApiService01;
import com.standout.sopang.order.service.OrderService;
import com.standout.sopang.order.vo.OrderVO;

@Controller("orderController")
@RequestMapping(value = "/order")
public class OrderControllerImpl extends BaseController implements OrderController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderVO orderVO;

	@Autowired
	private ApiService01 apiService01;
	
	// 개별주문
	@RequestMapping(value = "/orderEachGoods.do", method = RequestMethod.POST)
	public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO _orderVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		session = request.getSession();

		// 로그인 여부 체크
		Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
		String action = (String) session.getAttribute("action");

		// 이전에 로그인 상태인 경우는 주문과정 진행
		if (isLogOn == null || isLogOn == false) {
			session.setAttribute("orderInfo", _orderVO);
			session.setAttribute("action", "/order/orderEachGoods.do");
			return new ModelAndView("redirect:/member/login.do");
		}
		// 로그아웃 상태인 경우 로그인 화면으로 이동
		else {
			if (action != null && action.equals("/order/orderEachGoods.do")) {
				orderVO = (OrderVO) session.getAttribute("orderInfo");
				session.removeAttribute("action");
			} else {
				orderVO = _orderVO;
			}
		}

		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);

		// myOrderList에 선택한 상품정보 orderVO를 리다이렉트.
		List myOrderList = new ArrayList<OrderVO>();
		myOrderList.add(orderVO);
		session.setAttribute("myOrderList", myOrderList);

		// + 회원정보와 함께 리다이렉트.
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
		session.setAttribute("orderer", memberInfo);

		return mav;
	}
	
	
	// 다중주문
	@RequestMapping(value = "/orderAllCartGoods.do", method = RequestMethod.POST)
	public ModelAndView orderAllCartGoods(@RequestParam("cart_goods_qty") String[] cart_goods_qty,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session = request.getSession();
		List myOrderList = new ArrayList<OrderVO>();

		//장바구니 리스트를 받아 저장 
		Map cartMap = (Map) session.getAttribute("cartMap");
		List<GoodsVO> myGoodsList = (List<GoodsVO>) cartMap.get("myGoodsList");
		
		//회원정보를 받아 저장
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");

		//상품:수량으로 input에 저장해 넘겻던 정보를 이용할 것임.
		//cart_goods_qty, 받은 input의 수만큼 for문.
		for (int i = 0; i < cart_goods_qty.length; i++) {
			//상품:수량을 나눠 확인.
			String[] cart_goods = cart_goods_qty[i].split(":");
			for (int j = 0; j < myGoodsList.size(); j++) {
				//상품 객체 get
				GoodsVO goodsVO = myGoodsList.get(j);
				//상품 id get
				int goods_id = goodsVO.getGoods_id();
				//goodsid와 전달받은 상품 id값이 같을때
				if (goods_id == Integer.parseInt(cart_goods[0])) {
					//주문객체를 생성한다.
					OrderVO _orderVO = new OrderVO();
					//해당상품 title저장
					String goods_title = goodsVO.getGoods_title();
					//해당상품 수량 저장
					int goods_sales_price = goodsVO.getGoods_sales_price();
					//해당상품 fileName도 저장해
					String goods_fileName = goodsVO.getGoods_fileName();
					//주문객체에 set
					_orderVO.setGoods_id(goods_id);
					_orderVO.setGoods_title(goods_title);
					_orderVO.setGoods_sales_price(goods_sales_price);
					_orderVO.setGoods_fileName(goods_fileName);
					_orderVO.setOrder_goods_qty(Integer.parseInt(cart_goods[1]));
					//완성된 주문객체는 myOrderList에 쌓아간다.
					myOrderList.add(_orderVO);
					break;
				}
			}
		}
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberVO);
		return mav;
	}

	
	//결제하기
	@RequestMapping(value = "/payToOrderGoods.do", method = RequestMethod.POST)
	public ModelAndView payToOrderGoods(@RequestParam Map<String, String> receiverMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = "listMyOrderHistory";
		ModelAndView mav = new ModelAndView(viewName);

		//주문자 정보를 가져온다.
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("orderer");
		String member_id = memberVO.getMember_id();
		String orderer_name = memberVO.getMember_name();
		String orderer_hp = memberVO.getHp1();

		//주문정보를 가져온다.
		List<OrderVO> myOrderList = (List<OrderVO>) session.getAttribute("myOrderList");
		
		//결제성공여부
		String responseCode = "";
		String responseMsg = "";
		String itemName = "";
		String orderNumber = "";
		int amount = 0;
		//주문정보를 for로 돌리며 myOrderList에 수령자정보를 담는다.
		for (int i = 0; i < myOrderList.size(); i++) {
			OrderVO orderVO = (OrderVO) myOrderList.get(i);
			orderVO.setMember_id(member_id);
			orderVO.setReceiver_name(receiverMap.get("receiver_name"));
			orderVO.setReceiver_hp1(receiverMap.get("receiver_hp1"));
			orderVO.setDelivery_address(receiverMap.get("delivery_address"));

			//추후 결제시 필요할 수 있으니 주석으로 남겨둔다.
			orderVO.setPay_method(receiverMap.get("pay_method"));
			orderVO.setCard_com_name(receiverMap.get("card_com_name"));
			orderVO.setCard_pay_month(receiverMap.get("card_pay_month"));
			orderVO.setPay_orderer_hp_num(receiverMap.get("pay_orderer_hp_num"));	
			orderVO.setOrderer_hp(orderer_hp);
			
			
			
			//payup form 추가
			if(myOrderList.size() == 1) {
				itemName = orderVO.getGoods_title();
			}else if(myOrderList.size() > 1){
				itemName = orderVO.getGoods_title() +" 외 " + i + "건";
			}
			orderNumber += String.valueOf(orderVO.getOrder_seq_num());
			amount += orderVO.getGoods_sales_price();

//			amount = String.valueOf(orderVO.getGoods_sales_price());
			myOrderList.set(i, orderVO);
		}
		
		String merchantId = "himedia";
		String expireMonth = receiverMap.get("expireMonth");
		String expireYear = receiverMap.get("expireYear");
		String birthday = receiverMap.get("birthday");
		String cardPw = receiverMap.get("cardPw");
		String userName = memberVO.getMember_name();

		String cardNo = receiverMap.get("cardNo");
		String quota = receiverMap.get("card_pay_month");
		String apiCertKey = "ac805b30517f4fd08e3e80490e559f8e";
		String timestamp = "2023020400000000";
		String signature = apiService01.encrypt(merchantId + "|" + orderNumber + "|" + amount + "|" + apiCertKey + "|" + timestamp) ;
		
		
		String url = "https://api.testpayup.co.kr/v2/api/payment/"+merchantId+"/keyin2";
		Map<String, String> map = new HashMap<String, String>();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		map.put("merchantId", merchantId);
		map.put("orderNumber", orderNumber);
		map.put("expireMonth", expireMonth);
		map.put("expireYear", expireYear);
		map.put("birthday", birthday);
		map.put("cardPw", cardPw);
		map.put("amount", Integer.toString(amount));
		map.put("itemName", itemName);
		map.put("userName", userName);
		map.put("cardNo", cardNo);
		map.put("quota", quota);
		map.put("signature", signature);
		map.put("timestamp", timestamp);
		
		System.out.println("보내는값 = " + map.toString());
		returnMap = apiService01.restApi(map, url);
		System.out.println("db확인"+ returnMap.toString());
		
		//페이업 거래번호
		String transactionId = (String) returnMap.get("transactionId");
		
		responseCode = (String) returnMap.get("responseCode");
		responseMsg = (String) returnMap.get("responseMsg");
		
		
		if("0000".equals(responseCode)) {
			System.out.println("성공했습니다.");
			
			//수령자정보, 주문정보를 주문테이블에 반영한다.
			orderService.addNewOrder(myOrderList);
			session.setAttribute("returnMap", returnMap);
			
			//완료 후 listMyOrderHistory로 리턴.
			return new ModelAndView("redirect:/mypage/listMyOrderHistory.do");
		}else {
			System.out.println("실패했습니다.");
			
			ModelAndView mav_fail = new ModelAndView(); 
			mav_fail.addObject("responseMsg", responseMsg);
			mav_fail.setViewName("/order/payFail");
			//실패시 다시 주문페이지로 이동
			return mav_fail;
		}
		
	}
	
	
	//결제실패
		@Override
		@RequestMapping(value="/payFail.do",method = RequestMethod.POST)
		public ModelAndView payFail(HttpServletRequest request, HttpServletResponse response) throws Exception {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("/order/payFail");
			return mav;
		}


}
