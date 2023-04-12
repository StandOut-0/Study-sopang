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
	    
<form action="${contextPath}/member/login.do" method="post" id="loginForm">
        <input class="form-control form-control-lg rounded-0 mb-3" name="member_id" type="text" placeholder="아이디" required oninput="etcInptut()">

        <input class="form-control form-control-lg rounded-0 mb-3" name="member_pw" type="text" placeholder="비밀번호"  required oninput="etcInptut()">

        <div class="allRequiredInputCheck invalid-feedback text-start fs-07 mb-3 d-none">
            모든 정보를 입력해주세요.
          </div> 

        <button type="button" onClick="loginSopang()" class="btn btn-main rounded-0 w-100 d-block fw-bold p-2 lh-lg mb-3">로그인</button>
        <a class="btn border-main rounded-0 w-100 d-block fw-bold p-2 lh-lg mb-3"  href="${contextPath}/member/join.do">회원가입</a>
</form>

<script>
const form = document.getElementById("loginForm");
const inputs = form.querySelectorAll("input[required]");
var allRequiredInputCheck = document.querySelector('.allRequiredInputCheck');

function etcInptut(){
	if(this.value != ""){
		inputs.forEach(input => {
			input.classList.remove("is-invalid");	
		});
        allRequiredInputCheck.classList.add('d-none');
	}
}

function loginSopang(){
	
    let isValid = true;
    inputs.forEach(input => {
        if (!input.value) { // 값이 없으면
          isValid = false;
          input.classList.add("is-invalid"); // 유효하지 않은 입력을 표시하기 위해 스타일을 변경
        } else {
          input.classList.remove("is-invalid");
          allRequiredInputCheck.classList.add('d-none');
        }
      });
    if (isValid) {
        // 모든 입력이 유효하면 폼을 제출
        form.submit();
      } else {
    	  allRequiredInputCheck.classList.remove('d-none');
      }
}</script>
</body>
</html>