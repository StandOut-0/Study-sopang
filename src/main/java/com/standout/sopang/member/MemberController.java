package com.standout.sopang.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface MemberController {
	public String login(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String addMember(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
