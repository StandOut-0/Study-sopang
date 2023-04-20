package com.standout.sopang.admin.member.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.standout.sopang.member.vo.MemberVO;

public interface AdminMemberDAO {
	// 회원관리
	public ArrayList<MemberVO> listMember(HashMap condMap) throws DataAccessException;
}
