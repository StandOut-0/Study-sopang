package com.standout.sopang.mypage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.standout.sopang.member.vo.MemberVO;
import com.standout.sopang.mypage.dao.MyPageDAO;
import com.standout.sopang.mypage.vo.MyPageVO;
import com.standout.sopang.order.vo.OrderVO;

@Service("myPageService")
@Transactional(propagation=Propagation.REQUIRED)
public class MyPageServiceImpl  implements MyPageService{
	@Autowired
	private MyPageDAO myPageDAO;

	//주문목록
	public List<OrderVO> listMyOrderHistory(Map dateMap) throws Exception{
		return myPageDAO.selectMyOrderHistoryList(dateMap);
	}
	
	//주문취소
	public void cancelOrder(String order_id) throws Exception{
		myPageDAO.updateMyOrderCancel(order_id);
	}
	
	//반품
	public void returnOrder(String order_id) throws Exception{
		myPageDAO.updateMyOrderReturn(order_id);
	}
	
	//교환
	public void exchangeOrder(String order_id) throws Exception{
		myPageDAO.updateMyOrderExchange(order_id);
	}
	
	//내정보
	public MemberVO myDetailInfo(String member_id) throws Exception{
		return myPageDAO.selectMyDetailInfo(member_id);
	}
	
	//내 정보 수정
	public MemberVO  modifyMyInfo(Map memberMap) throws Exception{
		 String member_id=(String)memberMap.get("member_id");
		 myPageDAO.updateMyInfo(memberMap);
		 return myPageDAO.selectMyDetailInfo(member_id);
	}
	
	//회원탈퇴
	public void deleteMember(String member_id) throws Exception{
		myPageDAO.deleteMember(member_id);
	}
	
}
