<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<div class="container">
	<div class="row ms-5 ps-5">
		<div class="mt-5 p-0 ps-5 align-items-center">
			<div class="ps-4">

				<p class="fs-5 fw-bold mb-2">상품관리</p>


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
					<div>
						<button type="button"
							class="btn btn-main rounded-0 fw-bold p-2 ms-3 flex-fill fs-08"
							style="width: 300px;" onClick="showNewGoods()">추가하기</button>
					</div>
				</div>


				<div class="d-none">
					<input type="text" size="4" value="${beginYear}" />년 <input
						type="text" size="4" value="${beginMonth}" />월 <input type="text"
						size="4" value="${beginDay}" />일 &nbsp; ~ <input type="text"
						size="4" value="${endYear}" />년 <input type="text" size="4"
						value="${endMonth}" />월 <input type="text" size="4"
						value="${endDay}" />일
				</div>



				<div class="border-top border-main border-2 mt-2"></div>

				<div class="table-responsive mt-4">
					<table class="table border-top mb-0 small fw-light border-bottom">
						<tbody>
							<tr>
								<td
									class="table-light p-2 align-middle fw-bold border-end text-center samll"
									style="width: 45px;">상품번호</td>
								<td
									class="table-light ps-4 align-middle fw-bold text-center border-end">상품정보</td>
								<td
									class="table-light ps-4 align-middle fw-bold text-center border-end">상품이미지</td>
								<td
									class="table-light align-middle fw-bold text-center border-end"
									style="width: 114px;">등록일</td>
								<td class="table-light text-center px-4 align-middle"
									style="width: 114px;">-</td>
							</tr>


							<form action="${contextPath}/admin/goods/addNewGoods.do" method="post" enctype="multipart/form-data">
							<tr class="d-none newGoods bg-primary-subtle ">
								<td
									class="p-2 align-middle fw-bold border-end text-center samll"
									style="width: 45px;"> - </td>
								<td class="border-end align-middle">

									<div class="d-flex mb-1 align-items-center">
										<span style="width: 100px;" class="">카테고리</span> <select
											name="" id="" onchange="selectValue(this, this.value)"
											class="form-select rounded-0 flex-inherit text-start small border border-end">
											<option value="생활용품">생활용품</option>
											<option value="디지털" selected>디지털</option>
											<option value="도서">도서</option>
											<option value="건강기능식품">건강기능식품</option>
										</select> <input type="hidden" name="goods_sort" id="goods_sort"
											value="디지털">
									</div>
									<div class="d-flex mb-1 align-items-center">
										<span style="width: 100px;" class="">상품이름</span> <input
											class="form-control rounded-0" type="text" placeholder="상품이름"
											value="" name="goods_title">
									</div>
									<div class="d-flex mb-0 align-items-center">
										<span style="width: 100px;" class="">상품가격</span> <input
											class="form-control rounded-0" name="goods_sales_price" type="text" placeholder="상품가격"
											value="">
									</div>

								</td> 
								<td class="border-end align-middle">
									<div class="d-flex mb-1 align-items-center">
										<span style="width: 100px;" class="">상품이미지</span>
										<div class="input-group">
											<label onClick="filesToFackFilesInput(this)" class="d-flex w-100 filesToFackFilesInput">
													<input name='main_image' class="file_real d-none" id="f_main_image" type="file" style="opacity:.5">
													<span>파일선택</span>
											<input name='main_image_fake' class="file_fake form-control rounded-0" type="text" placeholder="main.png로 변경후 업로드해주세요." readonly tabindex="-1">
											</label>
										</div> 
									</div>
									<div class="d-flex mb-1 align-items-center">
										<span style="width: 100px;" class="">상세이미지</span>
										<div class="input-group">
											<label onClick="filesToFackFilesInput(this)" class="d-flex w-100 filesToFackFilesInput">
													<input name='detail_image1' class="file_real d-none" id="f_main_image" type="file" style="opacity:.5">
													<span>파일선택</span>
											<input name='detail_image1_fake' class="file_fake form-control rounded-0" type="text" placeholder="detail1.png로 변경후 업로드해주세요." readonly tabindex="-1">
											</label>
										</div>
									</div>
									<div class="d-flex mb-0 align-items-center">
										<span style="width: 100px;" class=""></span>
										<div class="input-group">
											<label onClick="filesToFackFilesInput(this)" class="d-flex w-100 filesToFackFilesInput">
													<input  name='detail_image2' class="file_real d-none" id="f_main_image" type="file" style="opacity:.5">
													<span>파일선택</span>
											<input name='detail_image2_fake' class="file_fake form-control rounded-0" type="text" placeholder="detail2.png로 변경후 업로드해주세요." readonly tabindex="-1">
											</label>
										</div>
									</div>

								</td>
								<td class="border-end align-middle text-center"> - 
								</td>
								<td class="align-middle">


									<button
										class="w-100 btn border-main small rounded-0 samll mb-2"
										type="button" onClick="fn_add_new_goods(this.form)">추가</button>
								</td>
								</td>
							</tr>
							</form>
					

								<c:choose>
									<c:when test="${empty newGoodsList }">
										<tr>
											<td colspan="5">
												<div class="p-4">
													<p class="my-5 text-center">조회된 상품이 없습니다.</p>
												</div>
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="item" items="${newGoodsList }">
										<form method="post" enctype="multipart/form-data">
											<tr>
												<td
													class="table-light p-2 align-middle fw-bold border-end text-center samll"
													style="width: 45px;">${item.goods_id }
													<input type="hidden" value="${item.goods_id }" name="goods_id">
													</td>
												<td class="border-end align-middle">

													<div class="d-flex mb-1 align-items-center">
														<span style="width: 100px;" class="">카테고리</span> <select
															name="" id="" onchange="selectValue(this, this.value)"
															class="form-select rounded-0 flex-inherit text-start small border border-end">
															<option value="생활용품">생활용품</option>
															<option value="디지털">디지털</option>
															<option value="도서">도서</option>
															<option value="건강기능식품">건강기능식품</option>
														</select> <input type="hidden" name="goods_sort" id="goods_sort"
															value="${item.goods_sort }">
													</div>
													<div class="d-flex mb-1 align-items-center">
														<span style="width: 100px;" class="">상품이름</span> <input
															class="form-control rounded-0" type="text"
															placeholder="상품이름" value="${item.goods_title } " name="goods_title">
													</div>
													<div class="d-flex mb-0 align-items-center">
														<span style="width: 100px;" class="">상품가격</span> <input
															class="form-control rounded-0" type="text"
															placeholder="상품가격" value="${item.goods_sales_price }" name="goods_sales_price">
													</div>

												</td>
												<td class="border-end align-middle">
													<div class="d-flex mb-1 align-items-center">
														<span style="width: 100px;" class="">상품이미지</span>
														<div class="input-group">
															<label onClick="filesToFackFilesInput(this)" class="d-flex w-100 filesToFackFilesInput">
													<input name='main_image' class="file_real d-none"  type="file" style="opacity:.5">
													<span>파일선택</span>
													<input name='main_image_fake' class="file_fake form-control rounded-0" type="text" value="main.png" placeholder="main.png로 변경후 업로드해주세요."  readonly tabindex="-1">
											</label>
												
											

															
														</div>
													</div>
													<div class="d-flex mb-1 align-items-center">
														<span style="width: 100px;" class="">상세이미지</span>
														<div class="input-group">
															<label onClick="filesToFackFilesInput(this)" class="d-flex w-100 filesToFackFilesInput">
													<input  name='detail_image1' class="file_real d-none"  type="file" style="opacity:.5">
													<span>파일선택</span>
													<input name='detail_image1_fake' class="file_fake form-control rounded-0" type="text" value="detail1.png" placeholder="detail1.png로 변경후 업로드해주세요." readonly tabindex="-1">
											</label>
												
															
														</div>
													</div>
													<div class="d-flex mb-0 align-items-center">
														<span style="width: 100px;" class=""></span>
														<div class="input-group">
															<label onClick="filesToFackFilesInput(this)" class="d-flex w-100 filesToFackFilesInput">
													<input name='detail_image2' class="file_real d-none"  type="file" style="opacity:.5">
													<span>파일선택</span>
													<input name='detail_image2_fake' class="file_fake form-control rounded-0" type="text" value="detail2.png" placeholder="detail2.png로 변경후 업로드해주세요." readonly tabindex="-1">
											</label>
														</div>
													</div>
												</td>
												<td class="border-end align-middle text-center">${item.goods_credate }
												</td>
												<td class="align-middle">


													<button
														class="w-100 btn border-main small rounded-0 samll mb-2"
														type="submit" formaction="${contextPath}/admin/goods/modifyGoods.do?goods_id=${item.goods_id }">수정</button>
													<button href="https://www.naver.com"
														class="w-100 btn border-main small rounded-0 samll mb-0" 
														onClick="deleteGoods(${item.goods_id})" type="button">삭제</button>
												</td>
												</td>
											</tr>
											</form>
										</c:forEach>
									</c:otherwise>
								</c:choose>
						</tbody>
					</table>
				</div>
				
			</div>
		</div>
	</div>
</div>


<script>


function filesToFackFilesInput(label){
	let file_real = label.children[0];
	let file_fake = label.children[2];
	console.log(file_fake.innerHTML);
	file_real.addEventListener("change", function () {
	let files = this.files[0].name;
		
		if(
			(file_fake.name == "main_image_fake") && (files == "main.png")||
		    (file_fake.name == "detail_image1_fake") && (files == "detail1.png")||
			(file_fake.name == "detail_image2_fake") && (files == "detail2.png")){
			console.log("올바르게 입력했습니다.");
			file_fake.value = files;
		}else{
			file_fake.value = null;
			label.classList.add("warn");
		}
});
}


function fn_add_new_goods(obj){
	const fileName = document.querySelector("#f_main_image").value;
	 if(fileName != null && fileName != undefined){
		 obj.submit();
	 }else{
		 alert("메인 이미지는 반드시 첨부해야 합니다.");
		 return;
	 }
}


function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};
	
function deleteGoods(goods_id){
	var url = getContextPath();
	url += "/admin/goods/deleteGoods.do?goods_id="+goods_id;
	 if (!confirm("삭제하시겠습니까?")) {
	    } else {
	    	location.href=url;
	    }
}

function showNewGoods(){
	const newGoods = document.querySelector(".newGoods");
	newGoods.classList.remove("d-none");
}
function selectValue(selectBox, value){
	var input = selectBox.nextElementSibling
	input.setAttribute("value", value);
}
var cart_goods_qty_inputs = document.getElementsByName("goods_sort");
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


				function search_order_history(fixedSearchPeriod) {
					var formObj = document.createElement("form");
					var i_fixedSearch_period = document.createElement("input");
					i_fixedSearch_period.name = "fixedSearchPeriod";
					i_fixedSearch_period.value = fixedSearchPeriod;
					formObj.appendChild(i_fixedSearch_period);
					document.body.appendChild(formObj);
					formObj.method = "get";
					formObj.action = "${contextPath}/admin/goods/adminGoodsMain.do";
					formObj.submit();
				}

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
				
				}
			</script>