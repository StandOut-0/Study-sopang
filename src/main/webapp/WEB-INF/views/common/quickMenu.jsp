<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<script>
	var array_index=0;
	var SERVER_URL="${contextPath}/thumbnails.do";
	function fn_show_next_goods(){
		var img_sticky=document.getElementById("img_sticky");
		var cur_goods_num=document.getElementById("cur_goods_num");
		var _h_goods_id=document.frm_sticky.h_goods_id;
		var _h_goods_fileName=document.frm_sticky.h_goods_fileName;
		if(array_index <_h_goods_id.length-1)
			array_index++;
		 	
		var goods_id=_h_goods_id[array_index].value;
		var fileName=_h_goods_fileName[array_index].value;
		img_sticky.src=SERVER_URL+"?goods_id="+goods_id+"&fileName="+fileName;
		cur_goods_num.innerHTML=array_index+1;
	}


 function fn_show_previous_goods(){
	var img_sticky=document.getElementById("img_sticky");
	var cur_goods_num=document.getElementById("cur_goods_num");
	var _h_goods_id=document.frm_sticky.h_goods_id;
	var _h_goods_fileName=document.frm_sticky.h_goods_fileName;
	
	if(array_index >0)
		array_index--;
	
	var goods_id=_h_goods_id[array_index].value;
	var fileName=_h_goods_fileName[array_index].value;
	img_sticky.src=SERVER_URL+"?goods_id="+goods_id+"&fileName="+fileName;
	cur_goods_num.innerHTML=array_index+1;
}

function goodsDetail(){
	var cur_goods_num=document.getElementById("cur_goods_num");
	arrIdx=cur_goods_num.innerHTML-1;
	
	var img_sticky=document.getElementById("img_sticky");
	var h_goods_id=document.frm_sticky.h_goods_id;
	var len=h_goods_id.length;
	
	if(len>1){
		goods_id=h_goods_id[arrIdx].value;
	}else{
		goods_id=h_goods_id.value;
	}
	
	
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    
	i_goods_id.name="goods_id";
	i_goods_id.value=goods_id;
	
    formObj.appendChild(i_goods_id);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="${contextPath}/goods/goodsDetail.do?goods_id="+goods_id;
    formObj.submit();
	
	
}
</script>  
 
 <div class="d-flex flex-column position-absolute top-50 end-0 translate-middle z-2" width="100px"
        style="width: 110px;">
        <a href="" class="btn btn-main rounded-0 py-2 d-block small">장바구니</a>
        <p href="" class="btn btn-dark rounded-0 py-2 d-block small mb-0">최근본상품</p>
        <div class="d-flex flex-column bg-white border border-top-0 p-2">
            <div id="carouselExample" class="carousel slide">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="https://via.placeholder.com/91x90/e1e1e1" class="mb-2">
                        <img src="https://via.placeholder.com/91x90/e1e1e1" class="mb-2">
                        <img src="https://via.placeholder.com/91x90/e1e1e1" class="mb-2">
                    </div>
                    <div class="carousel-item">
                        <img src="https://via.placeholder.com/92x90/e1e1e1" class="mb-2">
                        <img src="https://via.placeholder.com/92x90/e1e1e1" class="mb-2">
                        <img src="https://via.placeholder.com/92x90/e1e1e1" class="mb-2">
                    </div>
                    <div class="carousel-item">
                        <img src="https://via.placeholder.com/93x90/e1e1e1" class="mb-2">
                        <img src="https://via.placeholder.com/93x90/e1e1e1" class="mb-2">
                        <img src="https://via.placeholder.com/93x90/e1e1e1" class="mb-2">
                    </div>
                </div>
                <div class="d-flex justify-content-between">
                    <button class="samll btn btn-outline-secondary btn-sm p-1 rounded-0 bg-light"
                        data-bs-target="#carouselExample" data-bs-slide="prev">
                        <i class="fa-solid fa-chevron-left"></i>
                    </button>
                    <div class="num"></div>
                    <button class="samll btn btn-outline-secondary btn-sm p-1 rounded-0 bg-light"
                        data-bs-target="#carouselExample" data-bs-slide="next">
                        <i class="fa-solid fa-chevron-right"></i>
                    </button>

                </div>
            </div>
        </div>
    </div>

 
