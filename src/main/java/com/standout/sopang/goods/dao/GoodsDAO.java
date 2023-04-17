package com.standout.sopang.goods.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.standout.sopang.goods.vo.GoodsVO;
import com.standout.sopang.goods.vo.ImageFileVO;

public interface GoodsDAO {
	//메인페이지 - 지정 status별
	public List<GoodsVO> selectGoodsList(String goodsStatus ) throws DataAccessException;
	
	//header 카테고리별
	public List<GoodsVO> selectMenusList(String goodsStatus ) throws DataAccessException;
	
	//리스트페이지
	public List<GoodsVO> selectGoodsByMenuGoods(String menuGoods) throws DataAccessException;
	
	//추천키워드
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException;
	
	//검색
	public List<GoodsVO> selectGoodsBySearchWord(String searchWord) throws DataAccessException;
	
	//상품상세
	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;
}
