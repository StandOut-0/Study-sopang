<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="myCartList" value="${cartMap.myCartList}" />
<c:set var="myGoodsList" value="${cartMap.myGoodsList}" />

<c:set var="totalGoodsNum" value="0" />
<!--주문 개수 -->
<c:set var="totalDeliveryPrice" value="0" />
<!-- 총 배송비 -->
<c:set var="totalDiscountedPrice" value="0" />
<!-- 총 할인금액 -->
<script>


function selectValue(selectBox, value, goods_id, index){
	var input = selectBox.nextElementSibling
	input.setAttribute("value", value);
	
	modify_cart_qty(index, goods_id, value);
}

function modify_cart_qty(index, goods_id, value){
	/* alert(index+" "+ goods_id +" "+ value); */
	var cart_goods_qty = Number(value);
	
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/cart/modifyCartQty.do",
		data : {
			goods_id:goods_id,
			cart_goods_qty:cart_goods_qty
		},
		success : function(data, textStatus) {
			//alert(data);
			if(data.trim()=='modify_success'){
				alert("수량을 변경했습니다!!");	
			}else{
				alert("다시 시도해 주세요!!");	
			}
			
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	}); //end ajax
}

function delete_cart_goods(cart_id){

	var cart_id=Number(cart_id);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_id";
	i_cart.value=cart_id;
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/removeCartGoods.do";
    formObj.submit();
}

function fn_order_all_cart_goods(){
//	alert("모두 주문하기");
	var order_goods_qty;
	var order_goods_id;
	var objForm=document.frm_order_all_cart;
	var cart_goods_qty=objForm.cart_goods_qty; 
	var h_order_each_goods_qty=objForm.h_order_each_goods_qty;
	var checked_goods=objForm.checked_goods;
	var length=checked_goods.length;
	
	if(length>1){
		for(var i=0; i<length;i++){
			if(checked_goods[i].checked==true){
				
				order_goods_id=checked_goods[i].value;
				order_goods_qty=cart_goods_qty[i].value;
				alert(i+"번째 input에 "+order_goods_id+"와"+order_goods_qty+"를 넣을게요");
				cart_goods_qty[i].value=order_goods_id+":"+order_goods_qty;
			
				
				/* alert(cart_goods_qty[i].value); */
			}
		}	
	}else{
		order_goods_id=checked_goods.value;
		order_goods_qty=cart_goods_qty.value;
		cart_goods_qty.value=order_goods_id+":"+order_goods_qty;
		//alert(select_goods_qty.value);
	}
		
 	objForm.method="post";
 	objForm.action="${contextPath}/order/orderAllCartGoods.do";
	objForm.submit();
}


function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
	var total_price,final_total_price,_goods_qty;
	var cart_goods_qty=document.getElementById("cart_goods_qty");
	
	_order_goods_qty=cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=_order_goods_qty;
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
}


var total = 0;
const checkboxes = document.getElementsByName('checked_goods');
function selectAll(selectAll){
	const goods_sales_price = document.querySelectorAll(".goods_sales_price");
	checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  }); 
	
	if (selectAll.checked == true) {
		for (const i of goods_sales_price) {
			total += i.innerHTML*1;
		};
		var totalPrice=document.getElementById("totalPrice");
		var goodsPrice=document.getElementById("goodsPrice");
		totalPrice.innerHTML=total;
		goodsPrice.innerHTML=total; 
	}
	else if(selectAll.checked == false){ 
		for (const i of goods_sales_price) {
			total -= i.innerHTML*1;
		};
		var totalPrice=document.getElementById("totalPrice");
		var goodsPrice=document.getElementById("goodsPrice");
		totalPrice.innerHTML=total;
		goodsPrice.innerHTML=total;
	}
	
}

checkboxes.forEach((i) => i.addEventListener("click", function () {
	if (this.checked == true) {
		total += i.getAttribute("price")*1;
		/* alert(total); */
	}
	else if(this.checked == false){
		total -= i.getAttribute("price")*1;
		/* alert(total); */
	}
	totalPrice.innerHTML=total;
	goodsPrice.innerHTML=total; 
}));


</script>

<div class="container">

	<div class="row ms-5 ps-5">
		<div class="mt-5 p-0 ps-5 align-items-center">
			<div class="ps-4">
				<p class="fs-5 fw-bold mb-3">장바구니</p>

				<div class="border-top border-main border-2 mt-2">

					<div class="shadow-sm mt-3 rounded border border-light">

						<c:choose>

							<c:when test="${ empty myCartList }">
								<p class="my-5 text-center">장바구니에 상품이 없습니다 !</p>
							</c:when>

							<c:otherwise>

								<form name="frm_order_all_cart">

									<c:forEach var="item" items="${myGoodsList}" varStatus="cnt">

										<c:set var="cart_goods_qty"
											value="${myCartList[cnt.count-1].cart_goods_qty}" />
										<c:set var="cart_id"
											value="${myCartList[cnt.count-1].cart_id}" />

										<div
											class="shadow-sm p-0 mt-3 rounded border border-light d-flex justify-content-between">
											<div class="d-flex">
												<div class="d-flex align-items-center p-3 bg-light">
													<input type="checkbox" name="checked_goods"
														price="${item.goods_sales_price}" value="${item.goods_id}">
												</div>
												<div class="d-flex align-items-center ps-4">
													<a
														href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }"
														class="text-decoration-none d-block">

														<div class="d-flex justify-content-between">
															<div class="d-flex">
																<img
																	src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
																	style="width: 64px; height: 64px">
																<div class="ms-3">
																	<p class="mb-1 mt-1 small">${item.goods_title}</p>
																	<p class="mb-0 text-secondary">
																		<span class="goods_sales_price">${item.goods_sales_price}</span>
																		원 <span> · </span><span>${cart_goods_qty}</span>개  
																		<%-- 카트번호: ${cart_id} --%>
																	</p>
																</div>
															</div>

														</div>

													</a>
												</div>
											</div>

											<div class="p-4">
												<div class="border-start ps-4">

														<!-- 왠지여기가 문제인것같은데 다음주에 봅시다. -->
													<select id="" selectedValue="1"
														class="form-select rounded-0 text-center"
														onchange="selectValue(this, this.value,${item.goods_id },${cnt.count-1 })">
														<option value="1">1</option>
														<option value="2">2</option>
														<option value="3">3</option>
														<option value="4">4</option>
														<option value="5">5</option>
														<option value="6">6</option>
														<option value="7">7</option>
													</select> <input type="hidden" id="cart_goods_qty"
														name="cart_goods_qty" value="${cart_goods_qty}"> <a
														href="javascript:fn_order_each_goods('${item.goods_id }','${item.goods_title }','${item.goods_sales_price}','${item.goods_fileName}');"
														class="btn btn-sm border-main rounded-0 small d-block mt-2"
														style="width: 150px;">주문하기</a> <a
														href="javascript:delete_cart_goods('${cart_id}');"
														class="btn btn-sm border-main rounded-0 small d-block mt-2"
														style="width: 150px;">삭제</a>


												</div>
											</div>


										</div>

									</c:forEach>
								</form>
					</div>
				</div>


				</c:otherwise>
				</c:choose>

	
<div class="text-end mt-4 mb-2">
			<label> <input title="모든 상품을 결제상품으로 설정" type="checkbox"
				name="checked_goods" class="all-deal-select"
				onclick='selectAll(this)'> <span class="small selectAllSpan">전체선택</span>
			</label>
		</div>

		<p
			class="bg-light border text-end p-4 text-secondary d-flex justify-content-end align-items-center">
			<c:set var="totalGoodsPrice"
				value="${totalGoodsPrice+item.goods_sales_price*cart_goods_qty }" />
			<fmt:formatNumber value="${totalGoodsPrice}" type="number"
				var="total_goods_price" />
			<fmt:formatNumber
				value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}"
				type="number" var="total_price" />

			<input id="h_totalGoodsPrice" type="hidden"
				value="${totalGoodsPrice}" /> <input id="h_totalDeliveryPrice"
				type="hidden" value="${totalDeliveryPrice}" /> <input
				id="h_totalSalesPrice" type="hidden" value="${totalSalesPrice}" />
			<input id="h_final_totalPrice" type="hidden"
				value="${totalGoodsPrice+totalDeliveryPrice}" /> <span> <span>총
					상품가격 <span id="goodsPrice">${total_goods_price}</span>원
			</span> <span>+</span> <span>총 배송비 ${totalDeliveryPrice }원</span> <span>=</span>
				총 주문금액
			</span> <span class="text-black fw-bold fs-5 ms-3"><span
				id="totalPrice">${total_price}</span> 원</span>
		</p>

		<a href="javascript:fn_order_all_cart_goods()"
			class="btn btn-lg btn-main rounded-0 w-100 d-block fw-bold p-2 lh-lg mb-3">주문하기</a>

	</div>
			</div>

		</div>

		
</div>
</div>

</div>


<script>
/* 단순히 input의 value를 select에 select해서 사용자에게 보여주는 역할을 함. */
var cart_goods_qty_inputs = document.getElementsByName("cart_goods_qty");
cart_goods_qty_inputs.forEach((cart_goods_qty_inputs) => {
let inputValue = cart_goods_qty_inputs.value;
let selectBox = cart_goods_qty_inputs.previousElementSibling;
let selectBox_len = selectBox.options.length;
for (let i=0; i<selectBox_len; i++){  
	if(selectBox.options[i].value == inputValue){
		selectBox.options[i].selected = true;
	}
}
});
</script>





















