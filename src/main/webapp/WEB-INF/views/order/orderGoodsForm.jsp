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

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


<div class="container">
	<div class="row ms-5 ps-5">
		<div class="mt-5 p-0 ps-5 align-items-center">
			<form name="form_order">
				<div class="ps-4">
					<p class="fs-5 fw-bold mb-3">주문하기</p>
					<div class="border-top border-main border-2 mt-2">
						<div class="shadow-sm p-4 pt-2 mt-3 rounded border border-light">

							<!-- myOrderList를 돌려 각 주문상품 정보를 표시한다. -->
							<c:forEach var="item" items="${myOrderList}">

								<a
									href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }"
									class="shadow-sm p-0 mt-3 rounded border border-light d-flex justify-content-between text-decoration-none">
									<div class="d-flex">
										<div class="d-flex align-items-center p-4">
											<div class="d-flex justify-content-between">
												<div class="d-flex">

													<!-- 상품이미지 -->
													<img
														src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
														width="64px">
													<!-- 상품이미지 -->

													<!-- 상품id와 filename등 사용자에게 보여주지않아도 되는 정보들은 hidden type으로 넘긴다. -->
													<input type="hidden" id="h_goods_id" name="h_goods_id"
														value="${item.goods_id}" /> <input type="hidden"
														id="h_goods_fileName" name="h_goods_fileName"
														value="${item.goods_fileName}" />

													<div class="ms-3">

														<!-- 상품이름 -->
														<p class="mb-1 mt-1 small">${item.goods_title }</p>
														<input type="hidden" id="h_goods_title"
															name="h_goods_title" value="${item.goods_title }" />
														<!-- 상품이름 -->

														<!-- 상품가격 표시-->
														<p class="mb-0 text-secondary">
															<!-- 상품 낱개가격 -->
															<span>${item.goods_sales_price}</span> 원 <span> ·
															</span> <input type="hidden" id="h_each_goods_price"
																name="h_each_goods_price"
																value="${item.goods_sales_price * item.order_goods_qty}" />
															<!-- 상품 낱개가격 -->

															<!-- 상품수량 -->
															<span>${item.order_goods_qty }</span>개 <input
																type="hidden" id="h_order_goods_qty"
																name="h_order_goods_qty" value="${item.order_goods_qty}" />
															<!-- 상품수량 -->

															<!-- 상품별 총 가격: 낱개가격*수량, 필요없는 정보라고 생각하여 주석처리, 추후 필요할 경우 사용한다. -->
															<%-- = ${item.goods_sales_price * item.order_goods_qty} 원 --%>
															<!-- 상품별 총 가격: 낱개가격*수량, 필요없는 정보라고 생각하여 주석처리, 추후 필요할 경우 사용한다. -->

														</p>
														<!-- 상품가격 표시 -->

													</div>
												</div>
											</div>
										</div>
									</div>
								</a>

								<!-- 상품 가격정보 -->
								<c:set var="final_total_order_price"
									value="${final_total_order_price+ item.goods_sales_price* item.order_goods_qty}" />
								<c:set var="total_order_price"
									value="${total_order_price+ item.goods_sales_price* item.order_goods_qty}" />
								<c:set var="total_order_goods_qty"
									value="${total_order_goods_qty+item.order_goods_qty }" />
								<!-- 상품 가격정보 -->

							</c:forEach>
							<!-- myOrderList를 돌려 각 주문상품 정보를 표시한다. -->


							<!-- 주문상품 총 금액 계산 -->
							<p
								class="bg-light border text-end p-3 text-secondary d-flex justify-content-end align-items-center mt-4">
								<span> 
								
								<!-- 총 상품가격 --> 
								<span>총 상품가격 <span id="p_totalPrice">${total_order_price}</span>원</span> 
								<input id="h_totalPrice" type="hidden" value="${total_order_price}" /> 
								<!-- 총 상품가격 --> 
								
								<!-- 총 배송비 -->
									<span>+</span> <span>총 배송비 0원</span> 
								<!-- 총 배송비 --> 
								
								<!-- 총 주문금액 -->
									<span>=</span> 총 주문금액</span> <span class="text-black fw-bold fs-5 ms-3">
									<span id="p_final_totalPrice">${final_total_order_price }</span>원</span> 
									<input id="h_final_total_Price" type="hidden" value="${final_total_order_price}" />
								<!-- 총 주문금액 -->

							</p>
							<!-- 주문상품 총 금액 계산 -->
							
							
						</div>
					</div>

					<p class="mt-5 mb-3 fw-bold">배송지</p>

					<div class="table-responsive">
					
					<!-- 기본 회원정보를 valuㄷ로 지정한다. -->
						<table class="table border-top mb-0 small fw-light">
							<tbody>

							<!-- 이름 -->
								<tr>
									<td class="table-light ps-4 align-middle" style="width: 200px;">이름</td>
									<td class="px-4"><input class="form-control rounded-0" required
										id="receiver_name" name="receiver_name" type="text" size="40"
										value="${orderer.member_name }" style="width: 300px;">
										<input type="hidden" id="h_orderer_name" name="h_orderer_name"
										value="${orderer.member_name }" /> <input type="hidden"
										id="h_receiver_name" name="h_receiver_name"
										value="${orderer.member_name }" /></td>
								</tr>
								<!-- 이름 -->


								<!-- 휴대폰 -->
								<tr>
									<td class="table-light ps-4 align-middle" style="width: 200px;">휴대폰
										번호</td>
									<td class="px-4"><input class="form-control rounded-0" required
										type="text" id="hp1" name="hp1" value="${orderer.hp1 }"
										style="width: 300px;"> <input type="hidden" id="h_hp1"
										name="h_hp1" value="${orderer.hp1 }" /> <c:set
											var="orderer_hp" value="${orderer.hp1}" /></td>
								</tr>
								<!-- 휴대폰 -->

								<!-- 배송지 -->
								<tr>
									<td class="table-light ps-4 align-middle" style="width: 200px;">배송지</td>
									<td class="px-4">
										<div class="input-group mb-2" style="width: 395px;">
											<input class="form-control rounded-0" type="text"
												id="zipcode" name="zipcode" size="5"
												value="${orderer.zipcode}" aria-describedby="button-addon2" required>
											<a class="btn border-main small rounded-0 samll"
												type="button" id="button-addon2"
												href="javascript:execDaumPostcode()">우편번호 검색</a>
										</div> <input class="form-control rounded-0 mb-2" type="text"
										id="member_address" name="member_address" size="50"
										value="${orderer.member_address }" required> <input
										class="form-control rounded-0" type="text" id="subaddress"
										name="subaddress" size="50" value="${orderer.subaddress }" required>

										<input type="hidden" id="h_zipcode" name="h_zipcode"
										value="${orderer.zipcode }"  /> <input type="hidden"
										id="h_member_address" name="h_zipcode"
										value="${orderer.member_address }" /> <input type="hidden"
										id="h_subaddress" name="h_zipcode"
										value="${orderer.subaddress }" />
									</td>
								</tr>
								<!-- 배송지 -->
								
							</tbody>
						</table>
						<!-- 기본 회원정보를 valuㄷ로 지정한다. -->

					</div>

					<!-- 결제방법 선택 -->
					<p class="mt-5 mb-3 fw-bold">결제정보</p>
					<table class="table border-top mb-0 small fw-light">
						<tbody>
							<tr>
								<td class="table-light ps-4 align-middle" style="width: 200px;">
									결제방법</td>
								<td class="">
								
								<div class="row px-4">
								
								<div class="form-check col-3">
								  <input class="form-check-input" type="radio" name="pay_method" id="pay1" value="신용카드" checked>
								  <label class="form-check-label" for="pay1">
								    신용카드
								  </label>
								</div>
								
								<div class="form-check col-3">
								  <input class="form-check-input" type="radio" name="pay_method" id="pay2" value="제휴 신용카드">
								  <label class="form-check-label" for="pay2">
								    제휴 신용카드
								  </label>
								</div>
								
								<div class="form-check col-3">
								  <input class="form-check-input" type="radio" name="pay_method" id="pay3" value="실시간 계좌이체">
								  <label class="form-check-label" for="pay3">
								    실시간 계좌이체
								  </label>
								</div>
								
								<div class="form-check col-3">
								  <input class="form-check-input" type="radio" name="pay_method" id="pay4" value="무통장 입금">
								  <label class="form-check-label" for="pay4">
								    무통장 입금
								  </label>
								</div>
								
								<div class="form-check col-3">
								  <input class="form-check-input" type="radio" name="pay_method" id="pay5" value="휴대폰결제">
								  <label class="form-check-label" for="pay5">
								    휴대폰결제
								  </label>
								</div>

								<div class="form-check col-3">
									<input class="form-check-input" type="radio" name="pay_method" id="pay6" value="카카오페이(간편결제)">
									<label class="form-check-label" for="pay6">
									  카카오페이(간편결제)
									</label>
								  </div>

								  <div class="form-check col-3">
									<input class="form-check-input" type="radio" name="pay_method" id="pay7" value="페이나우(간편결제)">
									<label class="form-check-label" for="pay7">
									  페이나우(간편결제)
									</label>
								  </div>

								  <div class="form-check col-3">
									<input class="form-check-input" type="radio" name="pay_method" id="pay8" value="페이코(간편결제)">
									<label class="form-check-label" for="pay8">
									  페이코(간편결제)
									</label>
								  </div>

								  <div class="form-check col-3">
									<input class="form-check-input" type="radio" name="pay_method" id="pay9" value="직접입금">
									<label class="form-check-label" for="pay9">
									  직접입금
									</label>
								  </div>
								
								</div>
								</td>
							</tr>
							
							
							<tr class="whenSelected_Card">
								<td class="table-light ps-4 align-middle" style="width: 200px;">카드결제정보</td>
								<td class="px-4">
									<div class="d-flex align-items-center mb-2">
										<div style="width:100px"><p class="mb-0">카드사 선택</p></div>
										<div>
											<select id="" name="" class="form-select rounded-0" style="width: 300px;" onchange="selectValue(this, this.value)">
												<option value="삼성" selected>삼성</option>
												<option value="하나SK">하나SK</option>
												<option value="현대">현대</option>
												<option value="KB">KB</option>
												<option value="신한">신한</option>
												<option value="롯데">롯데</option>
												<option value="BC">BC</option>
												<option value="시티">시티</option>
												<option value="NH농협">NH농협</option>
										</select>
										<input type="hidden" id="card_com_name" name="card_com_name" value="삼성">
										</div>
									</div>

									<div class="d-flex align-items-center">
										<div style="width:100px"><p class="mb-0">할부기간</p>
										</div>
										<div>
											<select id="" name="" class="form-select rounded-0" style="width: 300px;" onchange="selectValue(this, this.value)">
												<option value="일시불" selected>일시불</option>
												<option value="2개월">2개월</option>
												<option value="3개월">3개월</option>
												<option value="4개월">4개월</option>
												<option value="5개월">5개월</option>
												<option value="6개월">6개월</option>
										</select>
										<input type="hidden" id="card_pay_month" name="card_pay_month" value="일시불">
										</div>
									</div>

								</td>
							</tr>
							
							
							<tr class="whenSelected_Phone d-none">
								<td class="table-light ps-4 align-middle" style="width: 200px;">휴대폰 번호</td>
								<td class="px-4">
								<input class="form-control rounded-0" type="text" id="pay_orderer_hp_num" name="pay_order_tel" value="" placeholder="-없이 작성해주세요: 01000000000" style="width: 300px;">
								</td>
							</tr>
							
						</tbody>
					</table>
					
					<!-- 결제방법 선택 -->
					
					
					<!-- 결제하기-->
					<a name="btn_process_pay_order" onClick="fn_process_pay_order()"
						class="btn btn-lg btn-main rounded-0 w-100 d-block fw-bold p-2 lh-lg mt-5 mb-2">결제하기</a>
						
					<!-- 결제하기-->

					<!-- 취소하기, 메인페이지로 돌아간다.-->
					<a href="${contextPath}/main/main.do"
						class="btn btn-lg border-main rounded-0 w-100 d-block fw-bold p-2 lh-lg mt-0 mb-3 fs-6">취소하기</a>
					<!-- 취소하기, 메인페이지로 돌아간다.-->
					
				</div>

			</form>
		</div>
	</div>
</div>

<script>
	window.onload = function() {init();}
	function init() {var form_order = document.form_order;}

	
	//select박스가 체크되었을때 input에 반영함.
	function selectValue(selectBox, value){
		var input = selectBox.nextElementSibling
		input.setAttribute("value", value);
	} 
	
	
	
	//휴대폰결제 radio가 checked 되었을때 혹은 else일때 카드결제정보 레이아웃의 변화.
	var radioBtns = document.querySelectorAll('input[name="pay_method"]');
	radioBtns.forEach(function(radioBtn) {
	  radioBtn.addEventListener('change', function() {
	    var whenSelected_Phone = document.getElementsByClassName("whenSelected_Phone");
	    var whenSelected_Card = document.getElementsByClassName("whenSelected_Card");
	    
	    if (this.value === "휴대폰결제") {
	      whenSelected_Phone[0].classList.remove("d-none");
	      whenSelected_Card[0].classList.add("d-none");
	    } else{
	      whenSelected_Phone[0].classList.add("d-none");
	      whenSelected_Card[0].classList.remove("d-none");
	    }
	  });
	});

	
		
	
	
	//다음 주소찾기
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('member_address').value = data.address;
			}
		}).open();
	}
	//다음 주소찾기

	
	
	//분리되어잇는 배송지 정보들 get
	var delivery_address;
	var i_zipcode = document.getElementById("zipcode");
	var i_member_address = document.getElementById("member_address");
	var i_subaddress = document.getElementById("subaddress");
	const inputs = document.querySelectorAll("input[required]");
	
	
	//pay_method
	// 라디오 버튼 요소 선택
	function pay_method(){
		var radios = document.getElementsByName('pay_method');
		// 선택된 라디오 버튼의 값을 가져오기
		for (var i = 0; i < radios.length; i++) {
		  if (radios[i].checked) {
		    var selectedValue = radios[i].value;
		    return selectedValue;
		    break;
		  }
		}	
	}
	

	
	//결제하기
	function fn_process_pay_order() {
		
		//required값인 input이 입력되지않았을 경우 submit을 하지 않도록 한다.
		let isValid = true;
		inputs.forEach(input => {if (!input.value) {isValid = false;}});
		
		 if (isValid) {
			 
			 if (!confirm("결제하시겠습니까?")) { alert("결제가 취소되었습니다.");} 
			 else {
				//배송지 통합하여 저장
					delivery_address = "우편번호:" + i_zipcode.value + "<br>" + "주소:"
							+ i_member_address.value + "<br>" + "상세주소:"
							+ i_subaddress.value;

				//form 생성
					var formObj = document.createElement("form");

				//수령자이름
					var i_receiver_name = document.createElement("input");
					i_receiver_name.name = "receiver_name";
					i_receiver_name.value = document.getElementById("receiver_name").value;
					formObj.appendChild(i_receiver_name);
				//수령자 핸드폰
					var i_receiver_hp1 = document.createElement("input");
					i_receiver_hp1.name = "receiver_hp1";
					i_receiver_hp1.value = document.getElementById("h_hp1").value;
					formObj.appendChild(i_receiver_hp1);
				
				//배송정보
					var i_delivery_address = document.createElement("input");
					i_delivery_address.name = "delivery_address";
					i_delivery_address.value = delivery_address;
					formObj.appendChild(i_delivery_address);

					//결제방법
					var i_pay_method = document.createElement("input");
					i_pay_method.name = "pay_method";
					i_pay_method.value= pay_method();
					formObj.appendChild(i_pay_method);
					
					//카드사선택
					var i_card_com_name = document.createElement("input");
					i_card_com_name.name="card_com_name";
					i_card_com_name.value=document.getElementById("card_com_name").value;
					formObj.appendChild(i_card_com_name);
					
					//할부기간
					var i_card_pay_month = document.createElement("input");
					i_card_pay_month.name="card_pay_month";
					i_card_pay_month.value=document.getElementById("card_pay_month").value;
					formObj.appendChild(i_card_pay_month);
					
					//핸드폰결제
				 	var i_pay_orderer_hp_num = document.createElement("input");
					i_pay_orderer_hp_num.name="pay_orderer_hp_num"; 
				    i_pay_orderer_hp_num.value=document.getElementById("pay_orderer_hp_num").value;
				    formObj.appendChild(i_pay_orderer_hp_num); 
					
					//form body에 append
					document.body.appendChild(formObj);
					
					//form에 생성한 정보들로 payToOrderGoods submit
				 	formObj.method = "post";
					formObj.action = "${contextPath}/order/payToOrderGoods.do";
					formObj.submit(); 
					}
				} 
         else {alert("배송지 정보를 입력해주세요!");}
	}
	
</script>
