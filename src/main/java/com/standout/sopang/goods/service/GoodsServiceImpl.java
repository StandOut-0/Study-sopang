package com.standout.sopang.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.standout.sopang.goods.dao.GoodsDAO;
import com.standout.sopang.goods.vo.GoodsVO;

@Service("goodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService{
	@Autowired
	private GoodsDAO goodsDAO;
	
	public Map<String,List<GoodsVO>> listGoods() throws Exception {
		
		Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
		List<GoodsVO> goodsList=goodsDAO.selectGoodsList("bestseller");
		goodsMap.put("bestseller",goodsList);
		
		goodsList=goodsDAO.selectMenusList("디지털");
		goodsMap.put("cate_digital",goodsList);
		
		goodsList=goodsDAO.selectMenusList("도서");
		goodsMap.put("cate_book",goodsList);

		goodsList=goodsDAO.selectMenusList("건강기능식품");
		goodsMap.put("cate_health" ,goodsList);
		
		goodsList=goodsDAO.selectMenusList("생활용품");
		goodsMap.put("cate_daily",goodsList);
		
		return goodsMap;
	}
	
}
