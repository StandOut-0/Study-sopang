<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- 주문자 휴대폰 번호 -->
<c:set var="orderer_hp" value="" />
<!-- 최종 결제 금액 -->
<c:set var="final_total_order_price" value="0" />

<!-- 총주문 금액 -->
<c:set var="total_order_price" value="0" />
<!-- 총 상품수 -->
<c:set var="total_order_goods_qty" value="0" />
<!-- 총할인금액 -->
<c:set var="total_discount_price" value="0" />
<!-- 총 배송비 -->
<c:set var="total_delivery_price" value="0" />

<style>
#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
	/* background-color:rgba(0,0,0,0.8); */
}

#popup_order_detail {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 10%;
	top: 0%;
	width: 60%;
	height: 100%;
	background-color: #ccff99;
	border: 2px solid #0000ff;
}

#close {
	z-index: 4;
	float: right;
}
</style>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


<div class="container">
	<div class="row ms-5 ps-5">
		<div class="mt-5 p-0 ps-5 align-items-center">
		<form  name="form_order">
		
			<div class="ps-4">
				<p class="fs-5 fw-bold mb-3">주문하기</p>

				<div class="border-top border-main border-2 mt-2">

					<div class="shadow-sm p-4 pt-2 mt-3 rounded border border-light">

						<c:forEach var="item" items="${myOrderList}">
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }"
								class="shadow-sm p-0 mt-3 rounded border border-light d-flex justify-content-between text-decoration-none">
								
								<div class="d-flex">
									<div class="d-flex align-items-center p-4">
										<div class="d-flex justify-content-between">
											<div class="d-flex">
												<img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" width="64px">
												<input   type="hidden" id="h_goods_id" name="h_goods_id" value="${item.goods_id}" />
					    						<input   type="hidden" id="h_goods_fileName" name="h_goods_fileName" value="${item.goods_fileName}" />
												<div class="ms-3">
													<p class="mb-1 mt-1 small">${item.goods_title }</p>
													<input   type="hidden" id="h_goods_title" name="h_goods_title" value="${item.goods_title }" />
													
													<p class="mb-0 text-secondary">
														<span>${item.goods_sales_price * item.order_goods_qty}</span> 원 <span> · </span>
														 <input  type="hidden" id="h_each_goods_price"  name="h_each_goods_price" value="${item.goods_sales_price * item.order_goods_qty}" />
														<span>${item.order_goods_qty }</span>개
														<input   type="hidden" id="h_order_goods_qty" name="h_order_goods_qty" value="${item.order_goods_qty}" />
													</p>
												</div>
											</div>
										</div>
									</div>
								</div>

							</a>
							<c:set var="final_total_order_price"
								value="${final_total_order_price+ item.goods_sales_price* item.order_goods_qty}" />
							<c:set var="total_order_price"
								value="${total_order_price+ item.goods_sales_price* item.order_goods_qty}" />
							<c:set var="total_order_goods_qty"
								value="${total_order_goods_qty+item.order_goods_qty }" />
						</c:forEach>

						<p
							class="bg-light border text-end p-3 text-secondary d-flex justify-content-end align-items-center mt-4">
							<span> <span>총 상품가격 <span id="p_totalPrice">${total_order_price}</span>원</span>
							<input id="h_totalPrice" type="hidden" value="${total_order_price}" />
					 <span>+</span> <span>총
									배송비 0원</span> <span>=</span> 총 주문금액
							</span> <span class="text-black fw-bold fs-5 ms-3"><span id="p_final_totalPrice">${final_total_order_price }</span>원</span>
							<input id="h_final_total_Price" type="hidden" value="${final_total_order_price}" />
						</p>

					</div>

				</div>

				<p class="mt-5 mb-3 fw-bold">배송지</p>

				<div class="table-responsive">
					<table class="table border-top mb-0 small fw-light">
						<tbody>
							<tr>
								<td class="table-light ps-4 align-middle" style="width: 200px;">이름</td>
								<td class="px-4"><input class="form-control rounded-0"
									id="receiver_name" name="receiver_name" type="text" size="40" value="${orderer.member_name }" style="width: 300px;">
									 <input type="hidden" id="h_orderer_name" name="h_orderer_name"  value="${orderer.member_name }" /> 
					   				 <input type="hidden" id="h_receiver_name" name="h_receiver_name"  value="${orderer.member_name }" />	
								</td>
							</tr>
							<tr>
								<td class="table-light ps-4 align-middle" style="width: 200px;">휴대폰
									번호</td>
								<td class="px-4"><input class="form-control rounded-0"
									type="text" id="hp1" name="hp1" value="${orderer.hp1 }" style="width: 300px;">
									<input type="hidden" id="h_hp1" name="h_hp1" value="${orderer.hp1 }" />
					 				<c:set  var="orderer_hp" value="${orderer.hp1}"/> 
								</td>
							</tr>
							<tr>
								<td class="table-light ps-4 align-middle" style="width: 200px;">배송지</td>
								<td class="px-4">
									<div class="input-group mb-2" style="width: 395px;">
										<input class="form-control rounded-0" type="text" id="zipcode" name="zipcode" size="5" value="${orderer.zipcode}" aria-describedby="button-addon2">
										<a class="btn border-main small rounded-0 samll" type="button" id="button-addon2" href="javascript:execDaumPostcode()">우편번호 검색</a>
									</div> 
									<input class="form-control rounded-0 mb-2" type="text" id="member_address" name="member_address" size="50" value="${orderer.member_address }" > 
									<input class="form-control rounded-0" type="text" id="subaddress" name="subaddress" size="50" value="${orderer.subaddress }">
									
									<input type="hidden" id="h_zipcode" name="h_zipcode" value="${orderer.zipcode }" />
									<input type="hidden" id="h_member_address" name="h_zipcode" value="${orderer.member_address }" /> 
									<input type="hidden" id="h_subaddress" name="h_zipcode" value="${orderer.subaddress }" />  
								</td>
							</tr>
						</tbody>
					</table>

				</div>

				<p class="mt-5 mb-3 fw-bold">결제정보</p>
				<select name="" id=""
					class="form-select rounded-0 flex-inherit text-start small border border-end">
					<option value="">소팡머니</option>
				</select>

				<a  name="btn_process_pay_order" href="javascript:fn_process_pay_order();"
					class="btn btn-lg btn-main rounded-0 w-100 d-block fw-bold p-2 lh-lg mt-5 mb-2">결제하기</a>
				<a href="${contextPath}/main/main.do"
					class="btn btn-lg border-main rounded-0 w-100 d-block fw-bold p-2 lh-lg mt-0 mb-3 fs-6">취소하기</a>
			</div>
			
			</form>
		</div>
	</div>
</div>

<script>
window.onload=function()
{
  init();
}

function init(){
	var form_order=document.form_order;
}

var delivery_address;
var i_zipcode=document.getElementById("zipcode");
var i_member_address=document.getElementById("member_address");
var i_subaddress=document.getElementById("subaddress");



function fn_process_pay_order(){
	delivery_address="우편번호:"+i_zipcode.value+"<br>"+"주소:"+i_member_address.value+"<br>"+"상세주소:"+i_subaddress.value;
	
	alert("최종 결제하기");
	var formObj=document.createElement("form");
	
    var i_receiver_name=document.createElement("input");
    i_receiver_name.name="receiver_name";
    i_receiver_name.value=document.getElementById("receiver_name").value;
    formObj.appendChild(i_receiver_name);
    
    var i_receiver_hp1=document.createElement("input");
    i_receiver_hp1.name="receiver_hp1";
    i_receiver_hp1.value=document.getElementById("h_hp1").value;
    formObj.appendChild(i_receiver_hp1);
    
    var i_delivery_address=document.createElement("input");
    i_delivery_address.name="delivery_address";
    i_delivery_address.value=delivery_address;
    formObj.appendChild(i_delivery_address);
   
   /*  var i_pay_method=document.createElement("input");
    i_pay_method.name="pay_method";
    i_pay_method.value=pay_method;
    formObj.appendChild(i_pay_method);
    
    var i_card_com_name=document.createElement("input");
    i_card_com_name.name="card_com_name";
    i_card_com_name.value=card_com_name;
    formObj.appendChild(i_card_com_name);
    
    var i_card_pay_month=document.createElement("input");
    i_card_pay_month.name="card_pay_month";
    i_card_pay_month.value=card_pay_month;
    formObj.appendChild(i_card_pay_month);
    
    var i_pay_orderer_hp_num=document.createElement("input");
    i_pay_orderer_hp_num.name="pay_orderer_hp_num";
    i_pay_orderer_hp_num.value=pay_orderer_hp_num;
    formObj.appendChild(i_pay_orderer_hp_num); */

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/payToOrderGoods.do";
    formObj.submit();
}
</script>
