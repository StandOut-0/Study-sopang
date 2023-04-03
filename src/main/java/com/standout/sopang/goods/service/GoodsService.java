package com.standout.sopang.goods.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.standout.sopang.goods.vo.GoodsVO;

public interface GoodsService {
	public Map<String,List<GoodsVO>> listGoods() throws Exception;
}
