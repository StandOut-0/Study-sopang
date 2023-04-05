<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
  request.setCharacterEncoding("UTF-8");
%>

<div class="hero" style="height: 450px">
	<div class="tab-content container h100 p-0 position-relative" id="">
		<div class="tab-pane show active" id="hero01" role="tabpanel"
			aria-labelledby="hero1">
			<img src="https://via.placeholder.com/1200x451/e1e1e1"
				class="today-image" data-log-props="" data-adsplatform=""
				style="display: block; z-index: 1; position: absolute;">
		</div>
		<div class="tab-pane" id="hero02" role="tabpanel"
			aria-labelledby="hero2">
			<img src="https://via.placeholder.com/1200x452/e1e1e1"
				class="today-image" data-log-props="" data-adsplatform=""
				style="display: block; z-index: 1; position: absolute;">
		</div>
		<div class="tab-pane" id="hero03" role="tabpanel"
			aria-labelledby="hero3">
			<img src="https://via.placeholder.com/1200x453/e1e1e1"
				class="today-image" data-log-props="" data-adsplatform=""
				style="display: block; z-index: 1; position: absolute;">
		</div>
		<div class="tab-pane" id="hero04" role="tabpanel"
			aria-labelledby="hero4">
			<img src="https://via.placeholder.com/1200x454/e1e1e1"
				class="today-image" data-log-props="" data-adsplatform=""
				style="display: block; z-index: 1; position: absolute;">
		</div>
		<div class="tab-pane" id="hero05" role="tabpanel"
			aria-labelledby="hero5">
			<img src="https://via.placeholder.com/1200x455/e1e1e1"
				class="today-image" data-log-props="" data-adsplatform=""
				style="display: block; z-index: 1; position: absolute;">
		</div>

		<div
			class="list-group position-absolute top-50 end-0 translate-middle-y z-2 me-5 rounded-0"
			role="tablist">
			<a class="list-group-item list-group-item-action p-0 active"
				id="hero1" data-bs-toggle="list" href="#hero01" role="tab"
				aria-controls="hero01"> <img
				src="https://via.placeholder.com/176x56/f5f5f5">
			</a> <a class="list-group-item list-group-item-action p-0" id="hero2"
				data-bs-toggle="list" href="#hero02" role="tab"
				aria-controls="hero02"> <img
				src="https://via.placeholder.com/176x56/f5f5f5">
			</a> <a class="list-group-item list-group-item-action p-0" id="hero3"
				data-bs-toggle="list" href="#hero03" role="tab"
				aria-controls="hero03"> <img
				src="https://via.placeholder.com/176x56/f5f5f5">
			</a> <a class="list-group-item list-group-item-action p-0" id="hero4"
				data-bs-toggle="list" href="#hero04" role="tab"
				aria-controls="hero04"> <img
				src="https://via.placeholder.com/176x56/f5f5f5">
			</a> <a class="list-group-item list-group-item-action p-0" id="hero5"
				data-bs-toggle="list" href="#hero05" role="tab"
				aria-controls="hero05"> <img
				src="https://via.placeholder.com/176x56/f5f5f5">
			</a>
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="d-flex p-0 align-items-center gap-3 mt-5">
			<p class="fs-3 fw-bold">오늘의 발견</p>
			<p class="fs-6">| 오늘 소팡이 엄선한 가장 HOT한 상품!</p>
		</div>
	</div>
		<style>
			.bestseller a:nth-child(1) , .bestseller a:nth-child(2) {width:calc(50% - 9px);height:300px}
			.bestseller a:nth-child(3) , .bestseller a:nth-child(4) ,
			.bestseller a:nth-child(5) , .bestseller a:nth-child(6) {width:279px;height:300px}
			.bestseller img{height:100%}
		</style>
	<div class="row border p-3">
		<div class="d-flex p-0 align-items-center gap-3 flex-wrap bestseller">
		<c:set  var="goods_count" value="0" />
		<c:forEach var="item" items="${goodsMap.bestseller}">
	   <c:set  var="goods_count" value="${goods_count+1 }" />
			<a class="back_eee position-relative" href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
			<img class="position-absolute top-50 start-50 translate-middle" src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
			</a>
		</c:forEach>
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="p-0 align-items-center gap-3 mt-5">
			<p class="fs-6 mb-1">HOT! TREND</p>
			<p class="fs-3 fw-bold">카테고리별 추천상품</p>
		</div>
	</div>
	<style>.categoryTabGoodList img{width:200px;height:200px}</style>
	<div class="row position-relative">

		<div
			class="list-group position-absolute bottom-0 start-0 z-2 rounded-0 mb-4"
			role="tablist" style="width: 150px">
			<a
				class="list-group-item list-group-item-action active btn mb-2 rounded-0 border-main samll"
				id="trend1" data-bs-toggle="list" href="#trend01" role="tab"
				aria-controls="trend01"># 디지털</a> <a
				class="list-group-item list-group-item-action btn mb-2 rounded-0 border-main samll"
				id="trend2" data-bs-toggle="list" href="#trend02" role="tab"
				aria-controls="trend02"># 도서</a> <a
				class="list-group-item list-group-item-action btn mb-2 rounded-0 border-main samll"
				id="trend3" data-bs-toggle="list" href="#trend03" role="tab"
				aria-controls="trend03"># 건강기능식품</a> <a
				class="list-group-item list-group-item-action btn mb-2 rounded-0 border-main samll"
				id="trend4" data-bs-toggle="list" href="#trend04" role="tab"
				aria-controls="trend04"># 생활용품</a>
		</div>


		<div class="tab-content border-top border-main border-2 p-0">

			<div class="tab-pane fade show active" id="trend01" role="tabpanel"
				aria-labelledby="trend1">

				<div class="d-flex justify-content-between">

					<div class="pt-4 pe-5 flex-grow-1 box-sixing-content"
						style="width: 200px">
						<a href="#" class="text-decoration-none">
							<p class="fw-bold fs-4 mb-1">카테고리1</p> <span class="small">바로가기
								> </span>
						</a>
					</div>

					<div class="position-relative">
						<img src="https://via.placeholder.com/350x600/e1e1e1">
						<button type="button"
							class="btn btn-main rounded-0 position-absolute bottom-0 start-50 translate-middle z-2 rounded-0 py-3 w100 d-block"
							style="width: 80%">
							<p class="mb-0 fw-bold">상품이름</p>
							<span class="small">상품에 대한 간단 설명</span>
						</button>
					</div>

					<div
						class="d-flex p-4 pe-0 pb-0 categoryTabGoodList align-items-start flex-wrap" style="gap: 1.8rem!important;">
						<c:forEach var="item" items="${goodsMap.cate_digital}" end="5">
	   					<c:set  var="goods_count" value="${goods_count+1 }" />
	   					<div>
						<a class="text-decoration-none" href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
						<div class="back_eee">
							<img src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
							</div>
							<p class="mt-2 mb-1 text-truncate">${item.goods_title}</p>
							<p><span class="fw-bold">${item.goods_sales_price}</span>원</p>
						</a>
						</div>
						</c:forEach>
					</div>
					
				</div>

			</div>

			<div class="tab-pane fade" id="trend02" role="tabpanel"
				aria-labelledby="trend2">

				<div class="d-flex justify-content-between">

					<div class="pt-4 pe-5 flex-grow-1 box-sixing-content"
						style="width: 200px">
						<a href="#" class="text-decoration-none">
							<p class="fw-bold fs-4 mb-1">카테고리2</p> <span class="small">바로가기
								> </span>
						</a>
					</div>

					<div class="position-relative">
						<img src="https://via.placeholder.com/350x600/e1e1e1">
						<button type="button"
							class="btn btn-main rounded-0 position-absolute bottom-0 start-50 translate-middle z-2 rounded-0 py-3 w100 d-block"
							style="width: 80%">
							<p class="mb-0 fw-bold">상품이름</p>
							<span class="small">상품에 대한 간단 설명</span>
						</button>
					</div>


					<div
						class="d-flex p-4 pe-0 pb-0 categoryTabGoodList align-items-start flex-wrap" style="gap: 1.8rem!important;">
						<c:forEach var="item" items="${goodsMap.cate_book}" end="5">
	   					<c:set  var="goods_count" value="${goods_count+1 }" />
	   					<div>
						<a class="text-decoration-none" href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
								<div class="back_eee">
							<img src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
							</div>
							<p class="mt-2 mb-1 text-truncate">${item.goods_title}</p>
							<p><span class="fw-bold">${item.goods_sales_price}</span>원</p>
						</a>
						</div>
						</c:forEach>
					</div>

				</div>

			</div>

			<div class="tab-pane fade" id="trend03" role="tabpanel"
				aria-labelledby="trend3">

				<div class="d-flex justify-content-between">

					<div class="pt-4 pe-5 flex-grow-1 box-sixing-content"
						style="width: 200px">
						<a href="#" class="text-decoration-none">
							<p class="fw-bold fs-4 mb-1">카테고리3</p> <span class="small">바로가기
								> </span>
						</a>
					</div>

					<div class="position-relative">
						<img src="https://via.placeholder.com/350x600/e1e1e1">
						<button type="button"
							class="btn btn-main rounded-0 position-absolute bottom-0 start-50 translate-middle z-2 rounded-0 py-3 w100 d-block"
							style="width: 80%">
							<p class="mb-0 fw-bold">상품이름</p>
							<span class="small">상품에 대한 간단 설명</span>
						</button>
					</div>


					<div
						class="d-flex p-4 pe-0 pb-0 categoryTabGoodList align-items-start flex-wrap" style="gap: 1.8rem!important;">
						<c:forEach var="item" items="${goodsMap.cate_health}" end="5">
	   					<c:set  var="goods_count" value="${goods_count+1 }" />
	   					<div>
						<a class="text-decoration-none" href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
								<div class="back_eee">
							<img src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
							</div>
							<p class="mt-2 mb-1 text-truncate">${item.goods_title}</p>
							<p><span class="fw-bold">${item.goods_sales_price}</span>원</p>
						</a>
						</div>
						</c:forEach>
					</div>

				</div>

			</div>

			<div class="tab-pane fade" id="trend04" role="tabpanel"
				aria-labelledby="trend4">

				<div class="d-flex justify-content-between">

					<div class="pt-4 pe-5 flex-grow-1 box-sixing-content"
						style="width: 200px">
						<a href="#" class="text-decoration-none">
							<p class="fw-bold fs-4 mb-1">카테고리4</p> <span class="small">바로가기
								> </span>
						</a>
					</div>

					<div class="position-relative">
						<img src="https://via.placeholder.com/350x600/e1e1e1">
						<button type="button"
							class="btn btn-main rounded-0 position-absolute bottom-0 start-50 translate-middle z-2 rounded-0 py-3 w100 d-block"
							style="width: 80%">
							<p class="mb-0 fw-bold">상품이름</p>
							<span class="small">상품에 대한 간단 설명</span>
						</button>
					</div>


					<div
						class="d-flex p-4 pe-0 pb-0 categoryTabGoodList align-items-start flex-wrap" style="gap: 1.8rem!important;">
						<c:forEach var="item" items="${goodsMap.cate_daily}" end="5">
	   					<c:set  var="goods_count" value="${goods_count+1 }" />
	   					<div>
						<a class="text-decoration-none" href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
								<div class="back_eee">
							<img src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
							</div>
							<p class="mt-2 mb-1 text-truncate">${item.goods_title}</p>
							<p><span class="fw-bold">${item.goods_sales_price}</span>원</p>
						</a>
						</div>
						</c:forEach>
					</div>

				</div>

			</div>

		</div>



	</div>
</div>






