<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<%@ page import="java.util.List,com.jm.market.model.vo.ProductBoard" %>
<%
	List<ProductBoard> list=(List)request.getAttribute("list"); 
	Member m=(Member)request.getAttribute("member");
	int totalProduct=(int)request.getAttribute("totalProduct");
	int dealProduct=(int)request.getAttribute("dealProduct");
%>
<style>
	section>*{
	  margin: 0px 300px 0px 300px;
	  font-family: 'Gowun Batang', serif;
   }
	#myImage{
		height:100px;
		width:100px; 
	} 
	.my-product{
  		height: auto;
		margin-top: 0px;
 		border-top: 2px solid gray;
	} 
	.btn btn-light{
		border:1px blue;
	} 
	.card{
		margin-right: 0px;
		margin-bottom: 30px;
		 height:350px;
	}
	
	 #pView{
	 	color:black; 
	 	text-decoration: none;
	 }

 	.mainbox { 
		font-weight: bolder;
		background-color: white;
		width: 300px;
		height: 380px;
		border-radius: 10px;
		margin-bottom: 20px;
		margin-right:20px;
	    overflow: hidden;
	}

	.mainbox:hover {
		box-shadow: 0px 0px 10px rgba(143, 140, 140, 0.5);
	}
	.card-1>div{
	 	display: inline-block;
	 }
	 
  .nav-item.show .nav-link {
    text-decoration: none
  }
  
  .store1{
  	padding-top:50px; 
  	text-align:center; 
  	background: url("./images/market/gray.jpg");
    background-size: 100% 100%;
    margin:0px;
  }
	
</style>

  
<section>  

	<div class="container">
	  <div class="row" style="border:1px darkgrey solid; padding:0px;">
	    <div class="col-4" style="padding:0px;">
	      <div class="text-center container store1" style="height:300px; width:400px;">
	      	<div style="display:inline-block;">
			  <img src="<%=request.getContextPath()%>/images/market/myprofile1.png" id="myImage" class="rounded-circle">
			  <br><br>
			  <span style="font-size: 20px; font-weight: bolder;"><%=m.getMemberName()%></span><br><br>
			  <% if(loginMember!=null&&loginMember.getMemberNo()==m.getMemberNo()) { %>
	 		 	<button type="button" class="btn btn-outline-dark" onclick=location.assign("<%=request.getContextPath()%>/buyList.do?memberNo=<%=loginMember.getMemberNo()%>")>????????????</button>
	 		  <%} %>
			</div>  
		  </div>
	    </div>
	    <div class="col-8">
	    <br><br>
	    	<img src="<%=request.getContextPath()%>/images/market/shop.png" width="50px" height="50px" >
	       <span style="font-size: 30px; font-weight: bolder;"> <%=m.getMemberName()%>?????? ??????</span><br><br>
	       <span>?????? ?????????:<%=m.getEnrollDate()%></span>
	       <br><br>
	       <span>???????????? ?????? :<%=totalProduct %>???  </span> &nbsp&nbsp
	       <span>???????????? :<%=dealProduct%>???</span>
	    </div>
	  </div>
	</div>
	
	<br><br>
	
	 
  
	 
	<div class="btn-group" role="group" aria-label="Basic outlined example" style="margin-left:200px;">
  	<button type="button" class="btn btn-outline-dark"  >????????????</button> 
  	<button type="button" class="btn btn-outline-dark" onclick=location.assign("<%=request.getContextPath()%>/review.do?memberNo=<%=m.getMemberNo()%>&&memberName=<%=m.getMemberName()%>")>??????</button> 
	</div>
 
 	
 	
	<div class="my-product container">
		 	 <%if(list!=null&&list.isEmpty()){%>
			  		<p>????????? ???????????? ????????????</p>
			  <%}else{ %>        
			   <div class="d-flex flex-wrap" style="margin-top:20px;">
			     <%for(ProductBoard pb : list) {%> 
			        <div class="mainbox" style="display:inline-block"> 
					  <div class="card container"  style="width: 19rem;   padding:0px; margin-right:20px; margin-bottom:0px; height:450px;"> 
					  	<a id="pView" href="<%=request.getContextPath()%>/productView.do?productNo=<%=pb.getProductNo()%>">
						  	<%if(pb.getFileName().isEmpty()){ %>
						 	   <img src="<%=request.getContextPath()%>/images/market/camera.png" height="150px" class="card-img-top">	
						 	<%}else{ %>
							  <img src="<%=request.getContextPath()%>/upload/market/<%=pb.getFileName().get(0).getFileName()%>" width="300px" height="230px" class="card-img-top">
						 	<%} %>   
						 	   <div class="card-body" style="height:50px;">
						   	        <h5 class="card-title" style="margin-bottom:10px;"><%=pb.getTitle()%> </h5>
						     	    <p class="card-text" style="color:cornflowerblue;">#<%=pb.getCategory()%></p>
						     	     <div class="card-1">
				     	    			<div class="card-text" style="margin-right:120px; font-size:21px;"><%=pb.getMember_name()%></div>
				     	    			<div class="card-text" style="color:gray;"><%=pb.getEnrollDate()%></div>
				    				</div>
						 </a>
					     	  <%--   <%if(pb.getIsSale().equals("Y")){ %>
					    			<a href="<%=request.getContextPath()%>/productView.do?productNo=<%=pb.getProductNo()%>" class="btn btn-primary">????????????</a> 
					    		<%}else{ %>
					    			<a href="<%=request.getContextPath()%>/productView.do?productNo=<%=pb.getProductNo()%>" class="btn btn-primary">????????????</a> 
					    			<button type="button" class="btn btn btn-danger">????????????</button> 
					    		<%} %> --%>
					    		
					    		<!-- ?????????????????? ????????? ???????????? -->  
					    		<% if(loginMember!=null&&loginMember.getMemberNo()==pb.getMemberNo()) { %>
						     	  <div class="btn-group" role="group" aria-label="Basic outlined example">
					    		<%if(pb.getIsSale().equals("Y")){ %>
					  				<button type="button" class="btn btn-outline-dark" onclick="location.assign('<%=request.getContextPath()%>/updateProduct.do?productNo=<%=pb.getProductNo()%>')">??????</button>
					  			    <%-- <button type="button" class="btn btn-outline-primary" onclick="location.replace('<%=request.getContextPath()%>/deleteProduct.do?productNo=<%=pb.getProductNo()%>&&memberNo=<%=pb.getMemberNo()%>')">??????</button>
					  		        <button type="button" class="btn btn-outline-primary" onclick="location.assign('<%=request.getContextPath()%>/dealProduct.do?productNo=<%=pb.getProductNo()%>&&memberNo=<%=pb.getMemberNo()%>')">????????????</button> --%>
					  			 <%-- <%} %> --%>
					  			 
 				  				<!-- ?????? ?????? Button trigger modal -->
								<button type="button" class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop">??????</button> 
								<!-- ???????????? Modal -->
								<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h5 class="modal-title" id="staticBackdropLabel">????????? ??????</h5>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <div class="modal-body">
								        ?????? ???????????? ?????????????????????????
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">?????????</button>
								        <button type="button" class="btn btn-primary" onclick="location.replace('<%=request.getContextPath()%>/deleteProduct.do?productNo=<%=pb.getProductNo()%>&&memberNo=<%=pb.getMemberNo()%>')">???</button>
								      </div>
								    </div>
								  </div>
								</div>
								
								<!-- ???????????? Button trigger modal -->
								<!-- <button type="button" class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#exampleModal">????????????</button> -->
										
								<!-- ???????????? Modal -->
								<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
								  <div class="modal-dialog">
									 <div class="modal-content">
										 <div class="modal-header">
										    <h5 class="modal-title" id="exampleModalLabel">????????????</h5>
										       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										  </div>
										  <div class="modal-body">
									      ?????? ??????????????? ????????????????????????? <br>
									      ?????? ???????????? ?????? ??????????????? ????????? ??? ????????????
										  </div>
										  <div class="modal-footer">
											     <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">?????????</button>
										     <button type="button" class="btn btn-primary" onclick="location.assign('<%=request.getContextPath()%>/dealProduct.do?productNo=<%=pb.getProductNo()%>&&memberNo=<%=pb.getMemberNo()%>')">???</button>
										   </div>
									  </div>
								  </div>
						       	</div>
								 <%}else{ %> 
								 	<!-- ?????? ?????? Button trigger modal -->
									<button type="button" class="btn btn btn-danger">????????????</button>  
									<button type="button" class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop">??????</button>
									<!-- ???????????? Modal -->
									<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
									  <div class="modal-dialog">
									    <div class="modal-content">
									      <div class="modal-header">
									        <h5 class="modal-title" id="staticBackdropLabel">????????? ??????</h5>
									        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									      </div>
									      <div class="modal-body">
									        ?????? ???????????? ?????????????????????????
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">?????????</button>
									        <button type="button" class="btn btn-primary" onclick="location.replace('<%=request.getContextPath()%>/deleteProduct.do?productNo=<%=pb.getProductNo()%>&&memberNo=<%=pb.getMemberNo()%>')">???</button>
									      </div>
									    </div>
									  </div>
									</div>

								 <%} %>

								 
							 </div>
							<%} %> 
					  	   </div>
					   </div>            		
			        </div>
			      <%} %>
			    </div>	       
			   <%} %> 
 	</div>
 	<br>
 	
 	<div class="container">
		<img id="target2" src="<%=request.getContextPath()%>/images/market/back-button.png" width="50px" height="50px">
		<input type="button" name="back"  style="display:none;"  onclick="javascript:history.back();">
	</div>
	
	
	

</section>



<script> 
	$("#target2").click(e=>{
		$("input[name=back]").click();
	})
</script>


<%@ include file="/views/common/footer.jsp" %>