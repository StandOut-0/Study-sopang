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
import com.standout.sopang.goods.vo.ImageFileVO;

@Service("goodsService")
@Transactional(propagation = Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService {
	@Autowired
	private GoodsDAO goodsDAO;

	//메인페이지 - 지정 status별, 메뉴별
	public Map<String, List<GoodsVO>> listGoods() throws Exception {
		Map<String, List<GoodsVO>> goodsMap = new HashMap<String, List<GoodsVO>>();

		//bestseller 저장
		List<GoodsVO> goodsList = goodsDAO.selectGoodsList("bestseller");
		goodsMap.put("bestseller", goodsList);

		//디지털 상품 저장
		goodsList = goodsDAO.selectMenusList("디지털");
		goodsMap.put("cate_digital", goodsList);

		//도서 상품 저장
		goodsList = goodsDAO.selectMenusList("도서");
		goodsMap.put("cate_book", goodsList);

		//건강기능식품 상품 저장
		goodsList = goodsDAO.selectMenusList("건강기능식품");
		goodsMap.put("cate_health", goodsList);

		//생활용품 상품 저장
		goodsList = goodsDAO.selectMenusList("생활용품");
		goodsMap.put("cate_daily", goodsList);
		
		//위 정보를 담은 Map return
		return goodsMap;
	}

	
	
	//header 카테고리별
	@Override
	public List<GoodsVO> menuGoods(String menuGoods) throws Exception {
		List goodsList = goodsDAO.selectGoodsByMenuGoods(menuGoods);
		return goodsList;
	}
	
	

	//추천키워드
	@Override
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list = goodsDAO.selectKeywordSearch(keyword);
		return list;
	}

	
	//검색
	@Override
	public List<GoodsVO> searchGoods(String searchWord) throws Exception {
		List goodsList = goodsDAO.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}
	

	//상품상세
	public Map goodsDetail(String _goods_id) throws Exception {
		Map goodsMap = new HashMap();
		//상품상세정보 추출
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(_goods_id);
		goodsMap.put("goodsVO", goodsVO);
		
		//상품 상세이미지 추출
		List<ImageFileVO> imageList = goodsDAO.selectGoodsDetailImage(_goods_id);
		goodsMap.put("imageList", imageList);
		
		//위 정보를 담은 Map return
		return goodsMap;
	}

}
