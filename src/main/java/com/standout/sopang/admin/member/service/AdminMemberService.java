package com.standout.sopang.admin.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.standout.sopang.goods.vo.GoodsVO;
import com.standout.sopang.member.vo.MemberVO;
import com.standout.sopang.order.vo.OrderVO;

public interface AdminMemberService {
	public ArrayList<MemberVO> listMember(HashMap condMap) throws Exception;
}
