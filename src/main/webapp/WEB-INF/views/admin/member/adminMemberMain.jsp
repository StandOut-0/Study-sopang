<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
	<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
			<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
				<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


					<div class="container">
						<div class="row ms-5 ps-5">
							<div class="mt-5 p-0 ps-5 align-items-center">
								<div class="ps-4">

									<p class="fs-5 fw-bold mb-2">회원관리</p>
									<form name="frm_delivery_list">

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

										<div class="d-flex align-items-center gap-1 justify-content-between">
											<div>
												<a href="javascript:search_order_history('today')"
													class="badge rounded-pill btn mb-2 rounded-0 border-main samll active">오늘</a>
												<a href="javascript:search_goods_list('six_month')" name="six_month"
													class="badge rounded-pill btn mb-2 rounded-0 border-main samll">최근
													6개월</a> <a href="javascript:search_goods_list('one_year')"
													class="badge rounded-pill btn mb-2 rounded-0 border-main samll before_1year">before_1year</a>
												<a href="javascript:search_goods_list('two_year')"
													class="badge rounded-pill btn mb-2 rounded-0 border-main samll before_2year">before_2year</a>
												<a href="javascript:search_goods_list('three_year')"
													class="badge rounded-pill btn mb-2 rounded-0 border-main samll before_3year">before_3year</a>
											</div>
											<div>
												<button type="button"
													class="btn btn-main rounded-0 fw-bold p-2 ms-3 flex-fill fs-08"
													style="width: 300px;">추가하기</button>
											</div>
										</div>


										<div class="">
											<input type="text" size="4" value="${beginYear}" />년 <input type="text"
												size="4" value="${beginMonth}" />월 <input type="text" size="4"
												value="${beginDay}" />일 &nbsp; ~ <input type="text" size="4"
												value="${endYear}" />년 <input type="text" size="4"
												value="${endMonth}" />월 <input type="text" size="4"
												value="${endDay}" />일
										</div>

										<div class="border-top border-main border-2 mt-2"></div>

										<div class="table-responsive mt-4">
											<table class="table border-top mb-0 small fw-light border-bottom">
												<tbody>
													<tr>
														<td class="table-light p-2 align-middle fw-bold border-end text-center" style="width: 100px;">회원ID</td>
														<td class="table-light ps-4 align-middle fw-bold text-center border-end">회원정보</td>
														<td class="table-light ps-4 align-middle fw-bold text-center border-end">배송정보</td>
														<td class="table-light ps-4 align-middle fw-bold text-center border-end">가입일</td>
														<td class="table-light text-center px-4 align-middle" style="width: 114px;">-</td>
													</tr>
													<c:choose>
														<c:when test="${empty member_list}">
															<tr>
																<td colspan="5">
																<div
																	class="shadow-sm p-4 mt-3 rounded border border-light">
																	<p class="my-5 text-center">조회된 회원이 없습니다.</p>
																</div>
																</td>
															</tr>

														</c:when>


														<c:otherwise>
																<c:forEach var="item" items="${member_list}"
																	varStatus="item_num">

																	<tr>
																		<td class="align-middle border-end text-center">
																			${item.member_id}
																		</td>
																		<td class="border-end align-middle">
																			<div class="d-flex mb-1 align-items-center">
																				<span style="width: 100px;" class="">이름</span>
																				<input class="form-control rounded-0" type="text" placeholder="이름" value="${item.member_name}">
																			</div>
																			<div class="d-flex mb-1 align-items-center">
																				<span style="width: 100px;" class="">아이디</span>
																				<input class="form-control rounded-0" type="text" placeholder="아이디" value="${item.member_id}">
																			</div>
																			<div class="d-flex mb-1 align-items-center">
																				<span style="width: 100px;" class="">비밀번호</span>
																				<input class="form-control rounded-0" type="text" placeholder="비밀번호" value="${item.member_pw}">
																			</div>
																			<div class="d-flex mb-0 align-items-center">
																				<span style="width: 100px;" class="">휴대전화</span>
																				<input class="form-control rounded-0" type="text" placeholder="010-0000-0000" value="${item.hp1}">
																			</div>
																		</td>
																		<td class="border-end align-middle">
																			<div class="d-flex mb-1 align-items-center">
																				<span style="width: 100px;" class="">우편번호</span>
																				<input class="form-control rounded-0" type="text" placeholder="우편번호" value="${item.zipcode}">
																			</div><div class="d-flex mb-1 align-items-center">
																				<span style="width: 100px;" class="">주소</span>
																				<input class="form-control rounded-0" type="text" placeholder="주소" value="${item.member_address}">
																			</div><div class="d-flex mb-1 align-items-center">
																				<span style="width: 100px;" class="">상세주소</span>
																				<input class="form-control rounded-0" type="text" placeholder="상세주소" value="${item.subaddress}">
																			</div>     
																		</td>
																		<td class="border-end align-middle text-center">
																			${item.joinDate}<br>
																			<c:choose>
																			<c:when test="${item.del_yn=='N' }">
																				<strong> 활동중</strong>
																			</c:when>
																			<c:otherwise>
																			</c:otherwise>
																		</c:choose>
																		
																		<c:set var="join_date"
																			value="${item.joinDate}" />
																		<c:set var="arr"
																			value="${fn:split(join_date,' ')}" />
																		</td>
																	
																			<td class="align-middle">
																				<button class="w-100 btn border-main small rounded-0 samll mb-2" type="button">수정</button><button class="w-100 btn border-main small rounded-0 samll mb-0" type="button">삭제</button>
																				
																			</td>
																	
														</tr>
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

						let date = new Date();
						let before_1year = date.getFullYear() - 1;
						let before_2year = date.getFullYear() - 2;
						let before_3year = date.getFullYear() - 3;
						document.querySelector('.before_1year').innerHTML = before_1year;
						document.querySelector('.before_2year').innerHTML = before_2year;
						document.querySelector('.before_3year').innerHTML = before_3year;


						function search_member(fixedSearchPeriod) {
							var formObj = document.createElement("form");
							var i_fixedSearch_period = document.createElement("input");
							i_fixedSearch_period.name = "fixedSearchPeriod";
							i_fixedSearch_period.value = fixedSearchPeriod;
							formObj.appendChild(i_fixedSearch_period);
							document.body.appendChild(formObj);
							formObj.method = "get";
							formObj.action = "/bookshop01/admin/member/adminMemberMain.do";
							formObj.submit();
						}

						if (window.location.href.includes("fixedSearchPeriod")) {
							const badges = document.querySelectorAll(".badge");
							for (b of badges) {
								b.classList.remove("active");
							}

							if (window.location.href.includes("today")) {
								badges[0].classList.add("active");
							} else if (window.location.href.includes("six_month")) {
								badges[1].classList.add("active");
							} else if (window.location.href.includes("one_year")) {
								badges[2].classList.add("active");
							} else if (window.location.href.includes("two_year")) {
								badges[3].classList.add("active");
							} else if (window.location.href.includes("three_year")) {
								badges[4].classList.add("active");
							}

						}


					</script>