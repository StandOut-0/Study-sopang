package com.standout.sopang.order.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Propagation;
import com.standout.sopang.order.dao.OrderDAO;
import com.standout.sopang.order.vo.OrderVO;


@Service("orderService")
@Transactional(propagation=Propagation.REQUIRED)
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderDAO orderDAO;
	
	public List<OrderVO> listMyOrderGoods(OrderVO orderVO) throws Exception{
		List<OrderVO> orderGoodsList;
		orderGoodsList=orderDAO.listMyOrderGoods(orderVO);
		return orderGoodsList;
	}
	
	public void addNewOrder(List<OrderVO> myOrderList) throws Exception{
		orderDAO.insertNewOrder(myOrderList);
		
		//īƮ���� �ֹ� ��ǰ �����Ѵ�.
		orderDAO.removeGoodsFromCart(myOrderList);
		System.out.println("��ٱ��Ͽ��� �ش� ��ǰ�� �����߽��ϴ�.");
	}	
	
	public OrderVO findMyOrder(String order_id) throws Exception{
		return orderDAO.findMyOrder(order_id);
	}

}