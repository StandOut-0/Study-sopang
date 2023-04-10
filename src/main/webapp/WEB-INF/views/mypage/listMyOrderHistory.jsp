<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />




<div class="container">
	<div class="row ms-5 ps-5">
		<div class="mt-5 p-0 ps-5 align-items-center">
			<div class="ps-4">

				<p class="fs-5 fw-bold mb-2">주문목록</p>

				<form method="post">

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
					</select> <a href="javascript:search_order_history('today')"
						class="badge rounded-pill btn mb-2 rounded-0 border-main samll active">오늘</a>
					<a href="javascript:search_order_history('six_month')"
						name="six_month"
						class="badge rounded-pill btn mb-2 rounded-0 border-main samll">최근
						6개월</a> <a href="javascript:search_order_history('one_year')"
						class="badge rounded-pill btn mb-2 rounded-0 border-main samll before_1year">before_1year</a>
					<a href="javascript:search_order_history('two_year')"
						class="badge rounded-pill btn mb-2 rounded-0 border-main samll before_2year">before_2year</a>
					<a href="javascript:search_order_history('three_year')"
						class="badge rounded-pill btn mb-2 rounded-0 border-main samll before_3year">before_3year</a>

					<div class="d-none">
						조회한 기간:<input type="text" size="4" value="${beginYear}" />년 <input
							type="text" size="4" value="${beginMonth}" />월 <input
							type="text" size="4" value="${beginDay}" />일 &nbsp; ~ <input
							type="text" size="4" value="${endYear}" />년 <input type="text"
							size="4" value="${endMonth}" />월 <input type="text" size="4"
							value="${endDay}" />일
					</div>
				</form>




				<div class="border-top border-main border-2 mt-2">
					<c:choose>
						<c:when test="${empty myOrderHistList }">
							<div class="shadow-sm p-4 mt-3 rounded border border-light">
								<p class="my-5 text-center">주문한 상품이 없습니다.</p>
							</div>
						</c:when>

						<c:otherwise>
							<c:forEach var="item" items="${myOrderHistList }" varStatus="i">

								<c:choose>
									<c:when test="${item.order_id != pre_order_id }">
										<c:set var="pre_order_id" value="${item.order_id }" />

										<div class="shadow-sm p-4 mt-3 rounded border border-light">
											<p class="fw-bold mb-0">${item.pay_order_time }주문</p>



											<div
												class="shadow-sm p-4 mt-3 rounded border border-light d-flex justify-content-between">
												<div class="d-flex flex-column gap-4">
													<p class="text-secondary fw-bold mb-0">
														<c:choose>
															<c:when
																test="${item.delivery_state=='delivery_prepared' }">
																		배송준비중
																	</c:when>
															<c:when test="${item.delivery_state=='delivering' }">
																		배송중
																	</c:when>
															<c:when
																test="${item.delivery_state=='finished_delivering' }">
																		배송완료
																	</c:when>
															<c:when test="${item.delivery_state=='cancel_order' }">
																		주문취소
																	</c:when>
															<c:when test="${item.delivery_state=='returning_goods' }">
																		반품중
																	</c:when>
															<c:when test="${item.delivery_state=='exchange_goods' }">
																		교환중
																	</c:when>
														</c:choose>
													</p>

													<c:forEach var="item2" items="${myOrderHistList}"
														varStatus="j">
														<c:if test="${item.order_id ==item2.order_id}">
															<div class="d-flex">

																<img
																	src="${contextPath}/thumbnails.do?goods_id=${item2.goods_id}&fileName=${item2.goods_fileName}"
																	style="width: 64px; height: 64px">

																<div class="ms-3">
																	<p class="mb-1 mt-1 small">
																		<a class="text-decoration-none"
																			href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }">${item2.goods_title}</a>
																	</p>
																	<p class="mb-0 text-secondary">
																		<span>${item2.order_goods_qty
																					}</span>개 <span> · </span>
																		<span>${item2.goods_sales_price*item2.order_goods_qty}</span>
																		원
																	</p>
																</div>
															</div>
														</c:if>
													</c:forEach>

												</div>

												<c:choose>
													<c:when test="${item.delivery_state=='cancel_order'}">
													</c:when>
													<c:otherwise>
														<div class="border-start ps-4 align-self-center align-self-stretch d-flex align-items-center">
															<div>
																<c:choose>
																	<c:when
																		test="${item.delivery_state=='delivery_prepared'}">
																		<button
																			class="btn btn-sm border-main rounded-0 small d-block my-2"
																			onClick="fn_edit_order('${item.order_id}','cancel')"
																			style="width: 150px;">주문취소</button>
																	</c:when>
																	<c:when
																		test="${item.delivery_state=='finished_delivering' }">
																		<button
																			class="btn btn-sm border-main rounded-0 small d-block my-2"
																			onClick="fn_edit_order('${item.order_id}', 'exchange')"
																			style="width: 150px;">교환신청</button>
																		<button
																			class="btn btn-sm border-main rounded-0 small d-block my-2"
																			onClick="fn_edit_order('${item.order_id}','return')"
																			style="width: 150px;">반품신청</button>
																	</c:when>
																</c:choose>
															</div>
														</div>
													</c:otherwise>
												</c:choose>

											</div>
				


			</div>
			</c:when>
			</c:choose>
			</c:forEach>
			</c:otherwise>
			</c:choose>

		</div>

	</div>
</div>
</div>
</div>



<script>
			let date = new Date();
			let before_1year = date.getFullYear() - 1;
			let before_2year = date.getFullYear() - 2;
			let before_3year = date.getFullYear() - 3;
			document.querySelector('.before_1year').innerHTML = before_1year;
			document.querySelector('.before_2year').innerHTML = before_2year;
			document.querySelector('.before_3year').innerHTML = before_3year;
			
			function search_order_history(fixedSearchPeriod) {
				var formObj = document.createElement("form");
				var i_fixedSearch_period = document.createElement("input");
				i_fixedSearch_period.name = "fixedSearchPeriod";
				i_fixedSearch_period.value = fixedSearchPeriod;
				formObj.appendChild(i_fixedSearch_period);
				document.body.appendChild(formObj);
				formObj.method = "get";
				formObj.action = "${contextPath}/mypage/listMyOrderHistory.do";
				formObj.submit();
			}
			
			function fn_edit_order(order_id, option){
				var formObj=document.createElement("form");
				var i_order_id = document.createElement("input"); 
				 	i_order_id.name="order_id";
				    i_order_id.value=order_id;
					
				    formObj.appendChild(i_order_id);
				    document.body.appendChild(formObj); 
				    formObj.method="post";
				   
				    if(option == "cancel"){
				    	var answer=confirm("주문을 취소하시겠습니까?");
						if(answer==true){
							formObj.action="${contextPath}/mypage/cancelMyOrder.do";
							formObj.submit();
						}
				    }else if(option == "return"){
				    	var answer=confirm("반품신청 하시겠습니까?");
						if(answer==true){
				    	formObj.action="${contextPath}/mypage/returnMyOrder.do";
				    	formObj.submit();
						}
				    }else if(option == "exchange"){
				    	var answer=confirm("교환신청 하시겠습니까?");
						if(answer==true){
				    	formObj.action="${contextPath}/mypage/exchangeMyOrder.do";
				    	formObj.submit();
						}
				    }
				    	
				
			}
			
			if (window.location.href.includes("fixedSearchPeriod")) {
				const badges = document.querySelectorAll(".badge");
				for (b of badges){ 
					b.classList.remove("active");
				}
				
				if (window.location.href.includes("today")) {
					badges[0].classList.add("active");
				} else if (window.location.href.includes("six_month")) {
					badges[1].classList.add("active");
				}else if (window.location.href.includes("one_year")) {
					badges[2].classList.add("active");
				}else if (window.location.href.includes("two_year")) {
					badges[3].classList.add("active");
				}else if (window.location.href.includes("three_year")) {
					badges[4].classList.add("active");
				}
			
			}
			
		</script>