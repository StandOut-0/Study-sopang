package com.standout.sopang.common.interceptor;

import java.sql.Wrapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.standout.sopang.member.vo.MemberVO;

public class ViewNameInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private MemberVO memberVO;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		
		HttpSession session = request.getSession();
		
		try {
			memberVO=(MemberVO)session.getAttribute("memberInfo");
			String  member_id=memberVO.getMember_id();
			
			int cartCount = 0;
			cartCount=sqlSession.selectOne("mapper.sopang.counts.cartLen",member_id);
			session.setAttribute("cartCount", cartCount);
			
			int deliveringCount = 0;
			deliveringCount=sqlSession.selectOne("mapper.sopang.counts.deliveringLen",member_id);
			session.setAttribute("deliveringCount", deliveringCount);
			
			Long sopang_money = 0L;
			sopang_money=(Long)sqlSession.selectOne("mapper.sopang.counts.sopang_money",member_id);
			session.setAttribute("sopang_money", sopang_money);
			
			
		}catch(NullPointerException n) {
			System.out.println("null이기에 예외처리가 납니다.");
		} catch(NumberFormatException f) {
			System.out.println("Long으로 변환 할 수 없어 예외처리가 납니다.");
		} 
		catch (Exception e) {
			System.out.println("로그인하지않았거나 예상하기 어려운 예외가 발생했습니다.");
		}
		
		try {
			String viewName = getViewName(request);
			request.setAttribute("viewName", viewName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	private String getViewName(HttpServletRequest request) throws Exception {
		String contextPath = request.getContextPath();
		String uri = (String) request.getAttribute("javax.servlet.include.request_uri");
		if (uri == null || uri.trim().equals("")) {
			uri = request.getRequestURI();
		}

		int begin = 0;
		if (!((contextPath == null) || ("".equals(contextPath)))) {
			begin = contextPath.length();
		}

		int end;
		if (uri.indexOf(";") != -1) {
			end = uri.indexOf(";");
		} else if (uri.indexOf("?") != -1) {
			end = uri.indexOf("?");
		} else {
			end = uri.length();
		}

		String fileName = uri.substring(begin, end);
		if (fileName.indexOf(".") != -1) {
			fileName = fileName.substring(0, fileName.lastIndexOf("."));
		}
		if (fileName.lastIndexOf("/") != -1) {
			fileName = fileName.substring(fileName.lastIndexOf("/", 1), fileName.length());
		}
		return fileName;
	}

}
