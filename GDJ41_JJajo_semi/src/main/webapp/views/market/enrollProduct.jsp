<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
   section>*{
		margin: 0px 200px 20px 500px; 
		font-family: 'Gowun Batang', serif;
	}

   select>div{
    display:inline;
   }
  

   .enrollTitle{
    font-size: 30px; 
     }
	  
	#inputPrice{
		width:300px;
	}
	
	#category{
	font-size:10px;
	}
	 
	.main-section{
	width: 1000px;
	}
	 
	 .bottom{
	 	display:flex;
	 justify-content:space-between;
	 }
	 
	.bottom>div{
	 display: inline-block; 
	}
	
</style>

<section>  
 
	<div class="main-section container"> 
	      <div style="border-bottom: black solid 3px">
	       		 <label for="enrollTitle" class="enrollTitle">기본정보</label>
	      </div>
	      <br>
	      <div class="col-12">
		    	<label class="form-label" style="margin-right: 300px;">상품이미지</label>
		      	<img id="target" src="<%=request.getContextPath()%>/images/market/camera.png" width="100px" height="100px">
				<input type="file" name="upFile"  accept="image/*" multiple style="display:none">
				<span id="imageContainer"></span>
		  </div>	
			
	      <div class="col-12">
		      <label class="form-label">제목</label>
		      <input type="text" class="form-control" name="boardTitle" id="inputTitle" placeholder="상품제목을 입력해주세요."> 
	      </div>
	      <br>
	      <div class="col-12" >
	     	  <label class="form-label">거래장소</label>
	     	  <input type="text" class="form-control" name="address" id="inputAddress" placeholder="원하는 거래장소를 입력해주세요.">
	      </div>
	      <br>
	      <div class="col-12">
	         <label class="form-label">가격</label>
	         <input style="display:inline-flex;" type="text" name="price" class="form-control" id="inputPrice" placeholder="숫자만 입력해주세요."> 
	         <span>원</span> 
	      </div>
	      <br>
	      <div id="select-category">
	          <label class="form-label" style="margin-right:30px">카테고리</label> 
	          <label><input type="radio" id="category" name="category" value="헬스의류" >헬스의류</label>
	          <label><input type="radio" id="category" name="category" value="헬스기구" >헬스기구</label>
	          <label><input type="radio" id="category" name="category" value="운동간식" >운동간식</label>
	          <label><input type="radio" id="category" name="category" value="기타용품" >기타용품</label>           
	      </div>
	      
	      <div class="col-12" style="border-bottom: black solid 3px">
	      	<label class="form-label">설명</label>
	      	<textarea rows="5" cols="100" id="boardContent" class="form-control" placeholder="상품 설명을 입력해주세요."></textarea>
	      	<br>
	      </div>
	       <br>
	      
	    <!-- 뒤로가기버튼 -->
	    <div class="bottom"> 
			 <div>
			    <img id="target2" src="<%=request.getContextPath()%>/images/market/back-button.png" width="40px" height="40px">
			    <input type="button" name="back"  style="display:none;"  onclick="javascript:history.back();">
			 </div> 
			<!-- 버튼 --> 
		     <div> 
	  			<button id="upload" class="btn btn-primary me-md-2  ">등록</button> 	  			
			</div>
		</div>	
		 <div>
		 	<input type="hidden" id="memberNo" value=<%=loginMember.getMemberNo()%>>
		 </div>
		
	</div>	
	 
		 	
    
	
 
	 




</section>


<script>
	$("#target").click(e=>{
		$("input[name=upFile]").click();
	})


	$("#target2").click(e=>{
		$("input[name=back]").click();
	})

	
	
	$("input[name=upFile]").change(e=>{
		$("#imageContainer").text(""); 
		for(let i=0; e.target.files.length; i++){
			if(e.target.files[i].type.includes("image")){
				let reader=new FileReader();
				reader.onload=(e)=>{
					const img=$("<img>").attr({
						src:e.target.result,
						width:"100px",
						height:"100px"
					});
					$("#imageContainer").append(img); 
				}
				reader.readAsDataURL(e.target.files[i]);
			}	
		}
	});
	
 
	//다중파일 업로드하기
 	$("#upload").click(e=>{
 		const frm=new FormData();
 		const fileInput=$("input[name=upFile]");
 		console.log(fileInput);
 		if(fileInput[0].files.length<1){
			alert("사진첨부는 필수입니다!!");
			return;
		}
 		for(let i=0;i<fileInput[0].files.length;i++){
 			frm.append("upfile"+i,fileInput[0].files[i]);
 		}
 		const title=$("#inputTitle").val().trim();
		if(title.length<1){
			alert("제목을 입력해주세요!");
			return;
		}
		const address=$("#inputAddress").val().trim();
		if(address.length<1){
			alert("거래장소를 입력해주세요!");
			return;
		}
		const price=$("#inputPrice").val().trim();
		if(price.length<1){
			alert("가격을 입력해주세요!");
			return;
		}
		const category=$("input[name=category]:checked").val();
		if(category==null){
			alert("카테고리를 선택해주세요!");
			return;
		}
 		frm.append("title",title);
 		frm.append("address",address);
 		frm.append("price",price);
 		frm.append("category",category);
 	/* 	frm.append("category",$("input[name=category]:checked").val()); */
 		frm.append("content",$("#boardContent").val());
 		frm.append("memberNo",$("#memberNo").val());
 		
 		 $.ajax({
 			url:"<%=request.getContextPath()%>/enrollProductEnd.do",
 			type:"post",
 			data:frm,
 			processData:false,
 			contentType:false,
 			success:data=>{
 				alert(data["msg"]);
 				location.replace("<%=request.getContextPath()%>"+data["loc"]);
 			}
 		}) 
 	})
	
 
	
	
	
	 
	
	
</script>



<%@ include file="/views/common/footer.jsp" %>