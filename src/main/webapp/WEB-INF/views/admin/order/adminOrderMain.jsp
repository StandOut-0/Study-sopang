<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:choose>
<c:when test='${not empty order_goods_list}'>
<script  type="text/javascript">
window.onload=function()
{
	init();
}

//화면이 표시되면서  각각의 주문건에 대한 배송 상태를 표시한다.
function init(){
	var frm_delivery_list=document.frm_delivery_list;
	var h_delivery_state=frm_delivery_list.h_delivery_state;
	var s_delivery_state=frm_delivery_list.s_delivery_state;
	
	
	if(h_delivery_state.length==undefined){
		s_delivery_state.value=h_delivery_state.value; //조회된 주문 정보가 1건인 경우
	}else{
		for(var i=0; s_delivery_state.length;i++){
			s_delivery_state[i].value=h_delivery_state[i].value;//조회된 주문 정보가 여러건인 경우
		}
	}
}
</script>
</c:when>
</c:choose>
<script>

function search_order_history(fixedSearchPeriod) {
	var formObj = document.createElement("form");
	var i_fixedSearch_period = document.createElement("input");
	i_fixedSearch_period.name = "fixedSearchPeriod";
	i_fixedSearch_period.value = fixedSearchPeriod;
	formObj.appendChild(i_fixedSearch_period);
	document.body.appendChild(formObj);
	formObj.method = "get";
	formObj.action = "${contextPath}/admin/order/adminOrderMain.do";
	formObj.submit();
}


function fn_modify_order_state(order_id,select_id){
	var s_delivery_state=document.getElementById(select_id);
    var index = s_delivery_state.selectedIndex;
    var value = s_delivery_state[index].value;
    //console.log("value: "+value );
	 
	$.ajax({
		type : "post",
		async : false,
		url : "${contextPath}/admin/order/modifyDeliveryState.do",
		data : {
			order_id:order_id,
			"delivery_state":value
		},
		success : function(data, textStatus) {
			if(data.trim()=='mod_success'){
				alert("주문 정보를 수정했습니다.");
				location.href="${contextPath}//admin/order/adminOrderMain.do";
			}else if(data.trim()=='failed'){
				alert("다시 시도해 주세요.");	
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


</script>

<div class="container">
	<div class="row ms-5 ps-5">
		<div class="mt-5 p-0 ps-5 align-items-center">
			<div class="ps-4">

				<p class="fs-5 fw-bold mb-2">주문관리</p>

				<form name="frm_delivery_list" action="${contextPath }/admin/admin.do" method="post">	
					
					<input type="radio" name="simple" checked class="d-none" /> <select
						name="curYear" class="d-none">
						<c:forEach var="i" begin="0" end="5">
							<c:choose>
								<c:when test="${endYear==endYear-i }">
									<option value="${endYear}" selected>${endYear}</option>
								</c:when>
								<c:otherwise>
									<option value="${endYear-i }">${endYear-i }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select> <select name="curMonth" class="d-none">
						<c:forEach var="i" begin="1" end="12">
							<c:choose>
								<c:when test="${endMonth==i }">
									<option value="${i }" selected>${i }</option>
								</c:when>
								<c:otherwise>
									<option value="${i }">${i }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select> <select name="curDay" class="d-none">
						<c:forEach var="i" begin="1" end="31">
							<c:choose>
								<c:when test="${endDay==i }">
									<option value="${i }" selected>${i }</option>
								</c:when>
								<c:otherwise>
									<option value="${i }">${i }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>

					<div
						class="d-flex align-items-center gap-1 justify-content-between">
						<div>
						 <a href="javascript:search_order_history('today')"
						class="badge rounded-pill btn mb-2 rounded-0 border-main samll active">오늘</a>
					<a href="javascript:search_order_history('one_month')"
						name="one_month"
						class="badge rounded-pill btn mb-2 rounded-0 border-main samll">최근 1개월</a> 
					<a href="javascript:search_order_history('two_month')"
						class="badge rounded-pill btn mb-2 rounded-0 border-main samll two_month">최근 2개월</a>
					<a href="javascript:search_order_history('three_month')"
						class="badge rounded-pill btn mb-2 rounded-0 border-main samll three_month">최근 3개월 </a>
					<a href="javascript:search_order_history('six_month')"
						class="badge rounded-pill btn mb-2 rounded-0 border-main samll six_month">최근 6개월</a>
						
						
						</div>
					</div>

					<div class="d-none">
						<input type="text" size="4" value="${beginYear}" />년 <input
							type="text" size="4" value="${beginMonth}" />월 <input
							type="text" size="4" value="${beginDay}" />일 &nbsp; ~ <input
							type="text" size="4" value="${endYear}" />년 <input type="text"
							size="4" value="${endMonth}" />월 <input type="text" size="4"
							value="${endDay}" />일
					</div>

					<div class="border-top border-main border-2 mt-2"></div>
				
					<div class="table-responsive mt-4">
						<table class="table border-top table-striped mb-0 small fw-light border-bottom">
								<tbody>
									<tr>
										<td
											class="table-light p-2 align-middle fw-bold border-end text-center samll"
											style="width: 45px;">주문번호</td>
										<td
											class="table-light ps-4 align-middle fw-bold text-center border-end">상품정보</td>
										<td
											class="table-light ps-4 align-middle fw-bold text-center border-end">배송정보</td>
										<td
											class="table-light ps-4 align-middle fw-bold text-center border-end">주문날짜</td>
										<td class="table-light text-center px-4 align-middle"
											style="width: 114px;">-</td>
									</tr>

									<c:choose>

										<c:when test="${empty newOrderList}">
											<tr>
											<td colspan="5">
												<div class="p-4">
													<p class="my-5 text-center">조회된 상품이 없습니다.</p>
												</div>
											</td>
										</tr>
										</c:when>

										<c:otherwise>
										<c:forEach var="item" items="${newOrderList}" varStatus="i">
											<c:choose>
											<c:when test="${item.order_id != pre_order_id }">  
												<tr>
													<td class="table-light align-middle border-end text-center">${item.order_id}</td>
													<td class="border-end align-middle">
														<div class="d-flex mb-1 align-items-center">
															<span style="width: 110px;" class="">주문회원</span> <input
																class="form-control rounded-0" type="text"
																placeholder="회원이름" value="${item.member_id}">
														</div>
														<div class="d-flex mb-1 align-items-center">
															<span style="width: 110px;" class="">수령자</span> <input
																class="form-control rounded-0" type="text"
																placeholder="수령자" value="${item.receiver_name}">
														</div>
														<div class="d-flex mb-1 align-items-center">
															<span style="width: 110px;" class="">배송연락처</span> <input
																class="form-control rounded-0" type="text"
																placeholder="010-0000-0000" value="${item.receiver_hp1}">
														</div>
	
													</td>

													<td class="border-end align-middle">
														<div class="d-flex mb-1 align-items-center">
															<span style="width: 100px;" class="">주문상품</span> <input
																class="form-control rounded-0" type="text"
																placeholder="주문상품" value="${item.goods_title}">
														</div>
														<div class="d-flex mb-1 align-items-center">
															<span style="width: 100px;" class="">주문수량</span> <input
																class="form-control rounded-0" type="text"
																placeholder="주문상품" value="${item.order_goods_qty}">
														</div> 


														<c:forEach var="item2" items="${newOrderList}" varStatus="j">
														<c:if test="${j.index > i.index }" >
															<c:if  test="${item.order_id ==item2.order_id}" >
																<hr class="border-secondary">
																<div class="d-flex mb-1 align-items-center">
																	<span style="width: 103px;" class="">주문상품</span> <input
																		class="form-control rounded-0" type="text"
																		placeholder="주문상품" value="${item2.goods_title}">
																</div>
																<div class="d-flex mb-1 align-items-center">
																	<span style="width: 100px;" class="">주문수량</span> <input
																		class="form-control rounded-0" type="text"
																		placeholder="주문상품" value="${item2.order_goods_qty}">
																</div>
														</c:if>   
														</c:if>
														</c:forEach> 
														
														<div class="d-flex mb-0 align-items-center">
													
															<span style="width: 100px;" class="">주문상태</span>
															
																<c:choose>
																  <c:when test="${item.order_id != pre_order_id }">
	
																	<c:choose>
	
																	  <c:when test="${item.delivery_state=='delivery_prepared' }">
																		<select
																name="s_delivery_state${i.index }"
																id="s_delivery_state${i.index }"
																class="text-warning-emphasis bg-warning-subtle form-select rounded-0 flex-inherit text-start small border border-end text-center">
																	  </c:when>
	
																	  <c:when test="${item.delivery_state=='finished_delivering' }">
																		<select
																name="s_delivery_state${i.index }"
																id="s_delivery_state${i.index }"
																class="text-success bg-success-subtle form-select rounded-0 flex-inherit text-start small border border-end text-center"> 
																	  </c:when>
	
																	  <c:otherwise>
																		<select
																name="s_delivery_state${i.index }"
																id="s_delivery_state${i.index }"
																class="text-danger bg-danger-subtle form-select rounded-0 flex-inherit text-start small border border-end text-center">  
																	  </c:otherwise>
	
																	</c:choose>
															 
																	<c:choose>
																		<c:when
																			test="${item.delivery_state=='delivery_prepared' }">
																			<option value="delivery_prepared" class="text-secondary" selected>배송준비중</option>
																			<option value="delivering">배송중</option>
																			<option value="finished_delivering">배송완료</option>
																			<option value="cancel_order">주문취소</option>
																			<option value="returning_goods">반품</option>
																		</c:when>
																		<c:when test="${item.delivery_state=='delivering' }">
																			<option value="delivery_prepared">배송준비중</option>
																			<option value="delivering" selected>배송중</option>
																			<option value="finished_delivering">배송완료</option>
																			<option value="cancel_order">주문취소</option>
																			<option value="returning_goods">반품</option>
																		</c:when>
																		<c:when
																			test="${item.delivery_state=='finished_delivering' }">
																			<option value="delivery_prepared">배송준비중</option>
																			<option value="delivering">배송중</option>
																			<option value="finished_delivering" selected>배송완료</option>
																			<option value="cancel_order">주문취소</option>
																			<option value="returning_goods">반품</option>
																		</c:when>
																		<c:when test="${item.delivery_state=='cancel_order' }">
																			<option value="delivery_prepared">배송준비중</option>
																			<option value="delivering">배송중</option>
																			<option value="finished_delivering">배송완료</option>
																			<option value="cancel_order" selected>주문취소</option>
																			<option value="returning_goods">반품</option>
																		</c:when>
																		<c:when
																			test="${item.delivery_state=='returning_goods' }">
																			<option value="delivery_prepared">배송준비중</option>
																			<option value="delivering">배송중</option>
																			<option value="finished_delivering">배송완료</option>
																			<option value="cancel_order">주문취소</option>
																			<option value="returning_goods" selected>반품</option>
																		</c:when>
																		<c:otherwise>
																		<option value="delivery_prepared">배송준비중</option>
																			<option value="주문오류" selected>주문오류</option>
																			<option value="delivering">배송중</option>
																			<option value="finished_delivering">배송완료</option>
																			<option value="cancel_order">주문취소</option>
																			<option value="returning_goods">반품</option>
																		</c:otherwise>
																	</c:choose>
	
																</c:when>
																</c:choose>	
															</select>
	
														</div>

													</td>

													<td class="border-end align-middle text-center">${item.pay_order_time }</td>

													<td class="text-center align-middle"><input
														class="w-100 btn border-main small rounded-0 samll mb-2"
														type="button" value="수정"
														onClick="fn_modify_order_state('${item.order_id}','s_delivery_state${i.index}')" />
													</td>
												</tr>
											</c:when>
											</c:choose>	
											<c:set  var="pre_order_id" value="${item.order_id }" />
										</c:forEach>
										</c:otherwise>

									</c:choose>	

								</tbody>
						</table>
					</div>


				</form>  
				
			</div>
		</div>
	</div>
</div>
<script>
if (window.location.href.includes("fixedSearchPeriod")) {
	const badges = document.querySelectorAll(".badge");
	for (b of badges){ 
		b.classList.remove("active");
	}
	
	if (window.location.href.includes("today")) {
		badges[0].classList.add("active");
	} else if (window.location.href.includes("one_month")) {
		badges[1].classList.add("active");
	}else if (window.location.href.includes("two_month")) {
		badges[2].classList.add("active");
	}else if (window.location.href.includes("three_month")) {
		badges[3].classList.add("active");
	}else if (window.location.href.includes("six_month")) {
		badges[4].classList.add("active");
	}

}</script>

