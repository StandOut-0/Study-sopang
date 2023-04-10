package com.standout.sopang.admin.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.standout.sopang.member.vo.MemberVO;

public interface AdminMemberController {
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,HttpServletRequest request, HttpServletResponse response)  throws Exception;

	public ResponseEntity modifyMyInfo(
			@RequestParam("member_name")  String member_name,
			@RequestParam("member_id")  String member_id,
			@RequestParam("member_pw")  String member_pw,
			@RequestParam("hp1")  String hp1,
			@RequestParam("zipcode")  String zipcode,
			@RequestParam("member_address")  String member_address,
			@RequestParam("subaddress")  String subaddress,
					            HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
}
