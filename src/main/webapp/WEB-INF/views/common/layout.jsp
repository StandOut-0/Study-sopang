<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%request.setCharacterEncoding("utf-8");%>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"
	integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer">
<link href="${contextPath}/resources/css/style.css" rel="stylesheet"
	type="text/css" media="screen">
	
	
	<link rel="shortcut icon" href="https://t0.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=http://standout.tistory.com&size=16" />
	
	
	
<title><tiles:insertAttribute name="title" /></title>
</head>
<body>

	<tiles:insertAttribute name="header" />
	<tiles:insertAttribute name="body" />

	<div
		class="footer border-top mt-5 py-5 text-center small text-secondary">
		<a href="${contextPath}/main/main.do"> <img
			src="${contextPath}/resources/img/logo.png" width="130" class="p-2"
			style="filter: grayscale(1);">
		</a>
		<p class="mb-0">
			<tiles:insertAttribute name="footer" />
		</p>
	</div>

	<tiles:insertAttribute name="quickMenu" />

	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N"
		crossorigin="anonymous"></script>
	<script src="${contextPath}/resources/js/script.js"></script>
</body>

