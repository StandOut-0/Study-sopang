<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:if test='${not empty message }'>
<script>
window.onload=function()
{
  result();
}
function result(){
	alert("아이디나  비밀번호가 틀립니다. 다시 로그인해주세요");
}
</script>
</c:if>
</head>
<body>
	    
<form action="${contextPath}/member/login.do" method="post">
        <input class="form-control form-control-lg rounded-0 mb-3" name="member_id" type="text" placeholder="아이디">
          
       <input class="form-control form-control-lg rounded-0 mb-0 is-valid d-none" name="member_id" type="text" placeholder="아이디">
     
         <input class="form-control form-control-lg rounded-0 mb-3 is-invalid d-none" name="member_id" type="text" placeholder="아이디">


        <input class="form-control form-control-lg rounded-0 mb-3" name="member_pw" type="text" placeholder="비밀번호">

        <div class="invalid-feedback text-start fs-07 mb-3 d-none">
            모든 정보를 입력해주세요.
          </div> 

        <button type="submit" class="btn btn-main rounded-0 w-100 d-block fw-bold p-2 lh-lg mb-3">로그인</button>
        <a class="btn border-main rounded-0 w-100 d-block fw-bold p-2 lh-lg mb-3"  href="${contextPath}/member/addMember.do">회원가입</a>
</form>


</body>
</html>