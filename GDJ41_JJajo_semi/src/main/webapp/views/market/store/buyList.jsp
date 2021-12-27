<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<%@ page import="java.util.List,com.jm.market.model.vo.ProductBoard" %>
<%
	List<ProductBoard> list=(List)request.getAttribute("list");

%>

<style> 
	section>*{
				margin: 0px 300px 20px 300px;
		    	font-family: 'Gowun Batang', serif;
			}
</style>

		
<section>

	<h2 style="text-align: center;">구매목록</h2>
	<br>
	
<div id="product-line" class="container" style="margin-left: 900px;">
	<%if(list.isEmpty()) { %>
		<div>구매한 상품이 없습니다</div>
	<%}else{ %>
	  <%for(ProductBoard pb : list) {%>
		<div class="card" style="width: 18rem;">
			<%if(pb.getFileName().isEmpty()){ %>
				   <img src="<%=request.getContextPath()%>/images/market/camera.png" height="150px" class="card-img-top">	
		    <%}else{ %>
			   <img src="<%=request.getContextPath()%>/upload/market/<%=pb.getFileName().get(0).getFileName()%>" height="150px" class="card-img-top">
		     <%} %>   
			  <div class="card-body">
			    <h5 class="card-title"><%=pb.getTitle()%></h5>
			     <p class="card-text"><%=pb.getEnrollDate()%></p>
			   	 <div class="btn-group" role="group" aria-label="Basic outlined example">
	  				<button type="button" class="btn btn-outline-primary" onclick=location.assign("<%=request.getContextPath()%>/reviewEroll.do?productNo=<%=pb.getProductNo()%>")>거래후기남기기</button> 
			 </div>
		  </div>
		</div>
	 <%}
	  }%>	 
		
		
</div>


</section>

 





<%@ include file="/views/common/footer.jsp" %>