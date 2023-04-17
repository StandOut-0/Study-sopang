package com.standout.sopang.goods.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.standout.sopang.goods.vo.GoodsVO;

public interface GoodsService {
	//메인페이지 - 지정 status별
	public Map<String,List<GoodsVO>> listGoods() throws Exception;
	
	//header 카테고리별
	public List<GoodsVO> menuGoods(String menuGoods) throws Exception;

	//추천키워드
	public List<String> keywordSearch(String keyword) throws Exception;

	//검색
	public List<GoodsVO> searchGoods(String searchWord) throws Exception;
	
	//상품상세
	public Map goodsDetail(String _goods_id) throws Exception;
}
