<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="goods"  value="${goodsMap.goodsVO}"  />
<c:set var="imageList"  value="${goodsMap.imageList }"  />


<div class="container">
	    <div class="row">
            <div class="p-0 align-items-center gap-3 mt-5">
                <!-- <p class="fs-6 mb-1">HOT! TREND</p>
                <p class="fs-3 fw-bold">카테고리</p> -->
            </div>
        </div>

    <div class="row">

            <div class="p-0 d-flex">

                <div class="d-flex">
                    <div class="list-group me-3" id="list-tab" role="tablist">
                        <a class="active mb-3 back_eee" id="detailThumb1"
                            data-bs-toggle="list" href="#detailThumb01" role="tab"
                            aria-controls="detailThumb01">
                            <img src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_fileName}" style="width:50px"></a>
                        <a class="mb-3 back_eee" id="detailThumb2"
                            data-bs-toggle="list" href="#detailThumb02" role="tab"
                            aria-controls="detailThumb02">
                            <img src="${contextPath}/resources/img/logo_square.png" style="width:50px"></a>
                    </div>
                    <div class="tab-content back_eee" id="nav-tabContent">
                        <div class="tab-pane show active" id="detailThumb01" role="tabpanel"
                            aria-labelledby="detailThumb1">
                            <img src="${contextPath}/download.do?goods_id=${goods.goods_id}&fileName=${goods.goods_fileName}" style="width:410px">
                        </div>
                        <div class="tab-pane back_eee" id="detailThumb02" role="tabpanel"
                            aria-labelledby="detailThumb2">
                            <img src="${contextPath}/resources/img/logo_square.png">
                        </div>
                    </div>
                </div>

                <div class="ps-4 w-100">
                    <p class="fs-6 mb-1">${goods.goods_sort }</p>
                    <p class="fs-3 fw-bold">${goods.goods_title }</p>
                    <hr>
                    <p class="fs-6 mb-1"><span class="fs-4 text-danger fw-bold">${goods.goods_sales_price }</span>원</p>

					
                    <div class="d-flex gap-2 mt-4">
					<select id="" selectedValue="1"
						class="form-select rounded-0 text-center d-none"
						onclick="selectValue(this, this.value)">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
					</select> <input type="hidden" id="goods_qty"
						name="goods_qty" value="1">

					<!-- list-group-item list-group-item-action btn mb-2 rounded-0 border-main samll -->
                        <a  href="javascript:add_cart('${goods.goods_id}')"
                            class="btn btn-lg fw-bold border-main rounded-0 d-block flex-fill">장바구니담기</a>
                        <a href="javascript:fn_order_each_goods('${goods.goods_id }','${goods.goods_title }','${goods.goods_sales_price}','${goods.goods_fileName}');"
                            class="btn btn-lg fw-bold btn-main rounded-0 d-block flex-fill">바로구매</a>
                    </div>
             
                    
                    
                    
                </div>

            </div>

            <div class="mt-5 border-top border-secondary border-3 p-0">
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                      <a class="nav-link rounded-0 text-center py-3 fw-bold active" id="detailInfo1"
                      data-bs-toggle="list" href="#detailInfo01" role="tab"
                      aria-controls="detailInfo01" style="width:250px">
                        상품상세
                      </a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link rounded-0 py-3 text-center fw-bold" id="detailInfo2"
                      data-bs-toggle="list" href="#detailInfo02" role="tab"
                      aria-controls="detailInfo02" style="width:250px">
                    배송/교환/반품 안내</a>
                    </li>
                  </ul>
                <div class="tab-content mt-5" id="nav-tabContent">
                    <div class="tab-pane show active" id="detailInfo01" role="tabpanel"
                        aria-labelledby="detailInfo1">

					<c:forEach var="image" items="${imageList }">
					<div class="mb-5" style="background:url(${contextPath}/resources/img/back1.jpg);background-size: cover;">
						<img class="" 
							src="${contextPath}/download.do?goods_id=${goods.goods_id}&fileName=${image.fileName}" style="width:1200px;">
					</div>
					</c:forEach>

                        
                        
                    </div>
                    <div class="tab-pane" id="detailInfo02" role="tabpanel"
                        aria-labelledby="detailInfo2">
                        <img src="https://via.placeholder.com/1200x412/e1e1e1">
                    </div>
                </div>
            </div>

        </div>
        
</div>

<script>
function selectValue(selectBox, value){
	var input = selectBox.nextElementSibling
	input.setAttribute("value", value);
}
</script>


<script type="text/javascript">


	function add_cart(goods_id) {
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/cart/addGoodsInCart.do",
			data : {
				goods_id:goods_id
			},
			success : function(data, textStatus) {
				/* alert(data); */
				//$('#message').append(data);
				if(data.trim()=='add_success'){
					alert("장바구니에 추가되엇습니다.");
				}else if(data.trim()=='already_existed'){
					alert("이미 카트에 등록된 상품입니다.");	
				}
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다. 아이디: "+goods_id);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
			}
		}); //end ajax	
	}

	
function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
	
	var total_price,final_total_price;
	var order_goods_qty=document.getElementById("order_goods_qty");
		
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=order_goods_qty.value;
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
	}	
</script>
