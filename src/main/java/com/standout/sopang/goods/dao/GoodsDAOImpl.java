package com.standout.sopang.goods.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.standout.sopang.goods.vo.GoodsVO;

@Repository("goodsDAO")
public class GoodsDAOImpl  implements GoodsDAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<GoodsVO> selectGoodsList(String goodsStatus ) throws DataAccessException {
		List<GoodsVO> goodsList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsList",goodsStatus);
		System.out.println(goodsList);
		return goodsList;	
     
	}

	@Override
	public List<GoodsVO> selectMenusList(String goodsSort) throws DataAccessException {
		List<GoodsVO> goodsList=(ArrayList)sqlSession.selectList("mapper.goods.selectMenusList",goodsSort);
		System.out.println(goodsList);
		return goodsList;	
	}

	
	@Override
	public List<GoodsVO> selectGoodsByMenuGoods(String menuGoods) throws DataAccessException {
		ArrayList goodsList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsByMenuGoods",menuGoods);
		System.out.println(goodsList);
		 return goodsList;
	}
	
}
