package com.standout.sopang.goods.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.standout.sopang.goods.vo.GoodsVO;

public interface GoodsDAO {
	public List<GoodsVO> selectGoodsList(String goodsStatus ) throws DataAccessException;
	public List<GoodsVO> selectMenusList(String goodsStatus ) throws DataAccessException;
}
