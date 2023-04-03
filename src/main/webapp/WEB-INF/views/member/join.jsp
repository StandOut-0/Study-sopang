<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>


function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if(data.buildingName !== '' && data.apartment === 'Y'){
        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }
      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if(extraRoadAddr !== ''){
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }
      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
      if(fullRoadAddr !== ''){
        fullRoadAddr += extraRoadAddr;
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
      document.getElementById('roadAddress').value = fullRoadAddr;
      document.getElementById('jibunAddress').value = data.jibunAddress;

      // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
      if(data.autoRoadAddress) {
        //예상되는 도로명 주소에 조합형 주소를 추가한다.
        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

      } else if(data.autoJibunAddress) {
          var expJibunAddr = data.autoJibunAddress;
          document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
      } else {
          document.getElementById('guide').innerHTML = '';
      }
      
     
    }
  }).open();
}

function fn_overlapped(){
    var _id=$("#_member_id").val();
    if(_id==''){
   	 alert("ID를 입력하세요");
   	 return;
    }
    $.ajax({
       type:"post",
       async:false,  
       url:"${contextPath}/member/overlapped.do",
       dataType:"text",
       data: {id:_id},
       success:function (data,textStatus){
          if(data=='false'){
       	    alert("사용할 수 있는 ID입니다.");
       	    $('#btnOverlapped').prop("disabled", true);
       	    $('#_member_id').prop("disabled", true);
       	    $('#member_id').val(_id);
          }else{
        	  alert("사용할 수 없는 ID입니다.");
          }
       },
       error:function(data,textStatus){
          alert("에러가 발생했습니다.");ㅣ
       },
       complete:function(data,textStatus){
          //alert("작업을완료 했습니다");
       }
    });  //end ajax	 
 }	
</script>
</head>
<body>
	<input class="form-control form-control-lg rounded-0 mb-0" type="text" placeholder="아이디">
          
       <input class="form-control form-control-lg rounded-0 mb-0 is-valid d-none" type="text" placeholder="아이디">
     
         <input class="form-control form-control-lg rounded-0 mb-0 is-invalid d-none" type="text" placeholder="아이디">
     
            <div class="valid-feedback text-start fs-07 d-none">
                사용가능한 아이디 입니다.
              </div>
              <div class="invalid-feedback text-start fs-07 d-none">
                사용중인 아이디 입니다.
              </div> 
          <div class="mb-3"></div>


        <input class="form-control form-control-lg rounded-0 mb-3" type="text" placeholder="비밀번호">



        <input class="form-control form-control-lg rounded-0 mb-0" type="text" placeholder="비밀번호 확인">

        <input class="form-control form-control-lg rounded-0 mb-0 is-valid d-none" type="text" placeholder="비밀번호 확인">

        <input class="form-control form-control-lg rounded-0 mb-0 is-invalid d-none" type="text" placeholder="비밀번호 확인">

        <div class="valid-feedback text-start fs-07 d-none">
            비밀번호가 일치합니다.
          </div>
          <div class="invalid-feedback text-start fs-07 d-none">
            비밀번호가 일치하지않습니다.
          </div> 
      <div class="mb-3"></div>


        <input class="form-control form-control-lg rounded-0 mb-3" type="text" placeholder="이름">
        <input class="form-control form-control-lg rounded-0 mb-3" type="text" placeholder="휴대폰번호">


        <div class="invalid-feedback text-start fs-07 mb-3">
            모든 정보를 입력해주세요.
          </div> 

        <button type="button" class="btn btn-main rounded-0 w-100 d-block fw-bold p-2 lh-lg mb-3">회원가입</button>
        <a class="btn border-main rounded-0 w-100 d-block fw-bold p-2 lh-lg mb-3"  href="#">로그인</a>
</body>
</html>