<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<body>
	<div class="sticky-sm-top header">
		<div class="bg-light d-flex p-0 justify-content-end border-bottom">
			<div
				class="container d-flex align-items-center justify-content-end p-1 pe-0">
				<div class="d-flex gap-3 d-none">
					<a href="#" class="text-decoration-none samll">로그인</a> <a href="#"
						class="text-decoration-none samll">회원가입</a>
				</div>


				<div class="d-flex gap-2">
					<span class="samll"><span class="fw-bold">관리자</span></span> <a
						href="#"
						class="text-decoration-none samll btn btn-outline-secondary btn-sm p-0 px-2 rounded-0 bg-white">로그아웃</a>
				</div>

			</div>
		</div>

		<div class="container">
			<div class="row">
				<div
					class="bg-white d-flex p-0 d-flex align-items-center justify-content-between">
					<div class="btn-group m-0" role="group">
						<button type="button" class="btn btn-main rounded-0 menu_btn"
							data-bs-toggle="dropdown" aria-expanded="false" width="110px"
							height="115px">
							<i class="fa-solid fa-bars d-block mt-1 mb-1"></i> <span
								class="small">카테고리</span>
						</button>
						<ul class="dropdown-menu rounded-0 shadow border-0 px-2 py-3">
							<li><a class="dropdown-item small" href="#">생활용품</a></li>
							<li><a class="dropdown-item small" href="#">디지털</a></li>
							<li><a class="dropdown-item small" href="#">도서</a></li>
							<li><a class="dropdown-item small" href="#">건강기능식품</a></li>
						</ul>
					</div>

					<div class="logo d-flex align-items-center px-4">
						<img src="https://via.placeholder.com/174x40/e1e1e1">
					</div>

					<div class="search d-flex align-items-center flex-grow-1">
						<div
							class="input-group border border-main border-2 position-relative">
							<select name="" id=""
								class="form-select rounded-0 flex-inherit text-start small border border-end">
								<option value="">전체</option>
								<option value="">생활용품</option>
								<option value="">디지털</option>
								<option value="">건강기능식품</option>
							</select> <input type="text small" class="form-control border-0"
								placeholder="찾고 싶은 상품을 검색해보세요!"> <a href="#"
								class="text-decoration-none samll d-flex align-items-center px-2">
								<i class="fa-solid fa-magnifying-glass d-block color-main"></i>
							</a>
							<ul
								class="keywordSearchList dropdown-menu rounded-0 shadow border-0 px-2 pb-3 show position-absolute top-100 d-none"
								style="left: 120px; width: calc(100% - 120px);">
								<li><a class="dropdown-item small" href="#">생활용품</a></li>
								<li><a class="dropdown-item small" href="#">디지털</a></li>
								<li><a class="dropdown-item small" href="#">도서</a></li>
								<li><a class="dropdown-item small" href="#">건강기능식품</a></li>
							</ul>
						</div>
					</div>

					<a href="#"
						class="mySopang text-decoration-none samll d-flex flex-column px-2 text-center ps-3 mt-2">
						<i class="fa-solid fa-user d-block mb-2 color-main "></i> <span
						class="my-coupang-title">마이소팡</span>
					</a> <a href="#"
						class="cart text-decoration-none samll d-flex flex-column px-2 text-center ps-3 mt-2">
						<i class="fa-solid fa-cart-arrow-down d-block mb-2 color-main"></i>
						<span class="my-coupang-title">장바구니</span>
					</a>


				</div>
			</div>
		</div>
	</div>

</body>
</html>