<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<%@ page import="com.jm.market.model.vo.ProductBoard" %> 
<%
	ProductBoard pb=(ProductBoard)request.getAttribute("productBoard"); 
 
 %>
<style> 
	*{
		list-style: none;
		text-decoration: none; 
		margin: 0px;
		padding: 0px;
		color: black;
		font-family: 'Gowun Batang', serif;

	}

	 section>*{
		margin: 0px 300px 200px 300px;
	 }
	 #myImage{
		height:70px;
		width:70px; 
	}
	
 	.w-100{
		width:0px;
		height:400px;
	}
	.carousel-item{
		margin-right:500px; 
	}
	 
	.carousel-inner{
		height:400px;
	}
	 
	.content{
		height:400px;
		background: none;
	}
	#profile>div{
		display:inline-block;
	}
	 
</style> 
 	
<section>

<div class="container" style="margin-top:20px;  margin-bottom:20px;">
  <div class="row">
    <div class="col">
      	<div id="carouselExampleDark" class="carousel carousel-dark slide container" data-bs-ride="carousel">
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		     <%for(int i=1; i<pb.getFileName().size();i++) { %>  
			    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to=<%=i%> aria-label="Slide"+<%=i+1%>></button> 
		      <%} %>
		  </div>
		  <div class="carousel-inner">
		    <div class="carousel-item active" data-bs-interval="10000">
		      <img src="<%=request.getContextPath()%>/upload/market/<%=pb.getFileName().get(0).getFileName()%>"  class="d-block w-100"    >
		    </div>
		  <%for(int i=1; i<pb.getFileName().size();i++) { %>  
		    <div class="carousel-item" data-bs-interval="2000">
		      <img src="<%=request.getContextPath()%>/upload/market/<%=pb.getFileName().get(i).getFileName()%>" class="d-block w-100"  >
		    </div>
		  <%} %>   
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
    </div>
    
    <div class="col">
      <div id="content-1">
        <div style="border-top: gray 1px solid;  padding-top:20px;">
			 <h1 style="font-weight: 700;"><%=pb.getTitle()%></h1>
	    </div>
	    <div>
	    	 <p style="color: cornflowerblue;">#<%=pb.getCategory()%></p>
		</div>
	    <div>
		     <p style="margin-bottom: 0px; font-size:30px; font-weight: bolder; "><%=pb.getPrice()%>???</p>
	    </div>	
	    <br>
   	    <div class="col-12 content" style="font-size:25px;  height:150px; border-bottom: gray 1px solid; padding:0px;"> 
	 	  	  <%=pb.getContent()%> 
      	<br>
	    </div>
      </div>
      
      <div class="container" style="padding-left:0px;">
		  <div class="row" style="margin-left:0px; padding-left:0px;">
		    <div class="col-2">
		    	<a href="<%=request.getContextPath()%>/myStore.do?memberNo=<%=pb.getMemberNo()%>"><img src="<%=request.getContextPath()%>/images/market/myprofile1.png" id="myImage" class="rounded-circle"></a>
		    </div>
		    <div class="col" style="margin-left:0px">
		      <h3><%=pb.getMember_name()%></h3>	
			  <p><%=pb.getAddress()%></p>
		    </div> 
		  </div>
		</div>
      
    </div> 
    
    
    
  </div>
</div>
 
 <div class="container">  
	 <!--  <div class="col-1">
			<img id="target2" src="<%=request.getContextPath()%>/images/market/back-button.png" width="50px" height="50px">
			<input type="button" name="back"  style="display:none;"  onclick="javascript:history.back();">
	  </div> --> 
	  
 	  <div class="col d-grid gap-2 d-md-flex justify-content-md-end">
 	   <%if(pb.getMemberNo()!=loginMember.getMemberNo()&&pb.getIsDelete().equals("N")){ %>
			 <!-- Button trigger modal -->  
			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
			 	????????????
			</button>
			
			<!-- Modal -->
			<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="staticBackdropLabel">????????????</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        ??????????????? ????????? ????????????????????????? 
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">?????????</button>
			        <button type="button" class="btn btn-primary"  id="pay"  >???</button>
 
			      </div>
			    </div>
			  </div>
			</div>  
		<%}else if(pb.getMemberNo()!=loginMember.getMemberNo()&&pb.getIsDelete().equals("Y")){ %>
		<button type="button" class="btn btn btn-danger">?????? ??????</button>
		<%}else{ %>
		<button type="button" class="btn btn-outline-primary" onclick="location.assign('<%=request.getContextPath()%>/updateProduct.do?productNo=<%=pb.getProductNo()%>')">????????????</button>
		<%} %>	
	  </div>
 	
	 
</div>
 
</section>


<script> 
	$("#target2").click(e=>{
		$("input[name=back]").click();
	})
	
	
  	$("#pay").click(e=>{  
    	     var IMP = window.IMP; // ????????????
	        IMP.init('imp68230080'); // 'iamport' ?????? ???????????? "????????? ????????????"??? ??????
	        var msg;
	        
	        IMP.request_pay({
	            pg : 'kakaopay',
	            pay_method : 'card',
	            merchant_uid : 'merchant_' + new Date().getTime(),
	            name : 'goodeehealth ???????????? ??????',
	            amount : <%=pb.getPrice()%>, 
	            buyer_email : '<%=loginMember.getEmail()%>',
	            buyer_name : '<%=loginMember.getMemberName()%>',
	            buyer_tel : '<%=loginMember.getPhone()%>',
	            buyer_addr : '<%=loginMember.getAddress()%>',
	            buyer_postcode : '123-456',
	            //m_redirect_url : 'http://www.naver.com'
	        }, function(rsp) {
	            if ( rsp.success ) {
	                //[1] ??????????????? ???????????? ????????? ?????? jQuery ajax??? imp_uid ????????????
	                jQuery.ajax({
	                    url: "/payments/complete", //cross-domain error??? ???????????? ????????? ??????????????????
	                    type: 'POST',
	                    dataType: 'json',
	                    data: {
	                        imp_uid : rsp.imp_uid
	                        //?????? ????????? ???????????? ????????? ?????? ??????
	                    }
	                }).done(function(data) {
	                    //[2] ???????????? REST API??? ?????????????????? ??? ?????????????????? ???????????? ??????
	                    if ( everythings_fine ) {
	                        msg = '????????? ?????????????????????.';
	                        msg += '\n??????ID : ' + rsp.imp_uid;
	                        msg += '\n?????? ??????ID : ' + rsp.merchant_uid;
	                        msg += '\?????? ?????? : ' + rsp.paid_amount;
	                        msg += '?????? ???????????? : ' + rsp.apply_num;
	                        
	                        alert(msg);
	                    } else {
	                        //[3] ?????? ????????? ????????? ?????? ???????????????.
	                        //[4] ????????? ????????? ????????? ????????? ?????? ????????? ?????????????????????????????????.
	                    }
	                });
	                //????????? ????????? ?????????
	                
	                location.href='<%=request.getContextPath()%>/buyProduct.do?productNo=<%=pb.getProductNo()%>&&memberNo=<%=loginMember.getMemberNo()%>';
<%-- 	                location.href='<%=request.getContextPath()%>/order/paySuccess?msg='+msg; --%>
	            } else {
	                msg = '????????? ?????????????????????.';
	                msg += '???????????? : ' + rsp.error_msg;
	                //????????? ????????? ?????????
	                location.href="<%=request.getContextPath()%>/productView.do?productNo=<%=pb.getProductNo()%>";
	                alert(msg);
	            }
	        });
	        
	    });
	
	
	 
</script>
 	

<%@ include file="/views/common/footer.jsp" %>