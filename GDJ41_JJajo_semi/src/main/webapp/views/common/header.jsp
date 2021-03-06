<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.jj.member.model.vo.Member"%>

<%
    Member loginMember = (Member) session.getAttribute("loginMember");
    String saveId = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
    	for (Cookie c : cookies) {
    		if (c.getName().equals("saveId")) {
    	saveId = c.getValue();
    	break;
    		}
    	}
    }
    %>


<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<script>
      var myModal = document.getElementById('myModal');
      var myInput = document.getElementById('myInput');
        

      if(myModal!=null && myInput!=null){
        myModal.addEventListener('shown.bs.modal', function () {
        myInput.focus();
        })
      } 

    </script>



	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<title>GOODEE HEALTH</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/style.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/challengers.css">
</head>
<body>

	<header>

		<br>
		<!------------------------------------------------ ????????? ????????? --------------------------------------------->
		<div class="container-fluid" id="container-head">
			<div class="row">
				<div class="col-1"></div>

				<div class="col-2" id="header-side"></div>
				<div class="col-2" id="header-middle-side"></div>
				<div class="col-2" id="header-title">GOODEE HEALTH</div>
				<div class="col-2" id="header-middle-side"></div>
				<div class="col-2" id="header-side"></div>
				<div class="col-1"></div>
			</div>
		</div>
		<br> <br>


		<!------------------------------------------------ ?????? ??? ???????????? --------------------------------------------->
		<div class="container-fluid">
			<%if(loginMember==null){ %>
			<form id="loginForm" name="loginSubmit"
				action="<%=request.getContextPath() %>/login.do" method="post">
				<div class="row">
					<div class="col-1"></div>
					<div class="col-7">
						<ul class="nav nav-pills">
							<li class="nav-item"><a class="nav-link active"
								aria-current="page" href="#">Home</a></li>
							<li class="nav-item"><a class="nav-link disabled" href="#">MY-BLOG</a>
							</li>
							<li class="nav-item"><a class="nav-link disabled" href="#">???????????????</a>
							</li>
							<li class="nav-item"><a class="nav-link disabled">??????????????????</a>
							</li>
							<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/challengers/main.do">Challengers</a>
							</li>
							<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/marketMainView.do">????????????</a>
							</li>
							<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/notice/noticeList.do">????????????</a>
							</li>
						</ul>
					</div>

					<div class="col-1">
						<input type="text" class="form-control" placeholder="?????????"
							name="memberId" value="<%=saveId!=null?saveId:"" %>" />
					</div>

					<div class="col-1" style="padding-left: 0px">
						<input type="password" class="form-control" placeholder="????????????"
							name="memberPwd">
					</div>

					<div class="col-1">
						<button type="button" class="btn btn-outline-warning"
							onclick="loginDo()">?????????</button>
					</div>
					<input type="hidden" name="saveId" id="saveId">
					<!-- from???????????? ?????? ????????? ????????? ??? ????????? hidden????????? ??? -->
					<div class="col-1"></div>

				</div>
			</form>

			<%}else{ %>

			<div class="row">
				<div class="col-1"></div>
				<div class="col-7" style="padding-top: 15px">
					<ul class="nav nav-pills">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="<%=request.getContextPath()%>">Home</a>
						</li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath() %>/blog/blogmain.do?memberNo=<%=loginMember.getMemberNo()%>">MY-BLOG</a>
						</li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/find/findPosition.do">???????????????</a>
						</li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/find/findFriend.do?memberNo=<%=loginMember.getMemberNo()%>">??????????????????</a>
						</li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/challengers/main.do">Challengers</a>
						</li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/marketMainView.do">????????????</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/notice/noticeList.do">????????????</a>
						</li>
					</ul>
				</div>


				<div class="col-1" style="text-align: center; padding-right:0;">
					<img class="home_avatar"
						src="<%=request.getContextPath()%>/images/market/myprofile1.png" />
				</div>


				<div class="col"
					style="padding-top: 20px; padding-left: 0px; padding-right: 0px">
					<span style="color: #01DFA5">HELLO. <%=loginMember.getMemberName()%>???,<br>
					???????????????
					</span>
				</div>

					<div class="col"
						style="padding-left: 0px; padding-right: 0px; padding-top: 12px">
						<button type="button" class="btn btn-outline-success"
							onclick="memberView();">????????? ??????</button>
						<button type="button" class="btn btn-outline-danger"
							onclick="location.replace('<%=request.getContextPath()%>/logout.do');"
							>????????????</button>
					</div>

					<div class="col-1"></div>

				</div>

				<%} %>

			</div>


			<!------------------------------------------------ ???????????? ??? ????????? ???????????? ?????? ??? --------------------------------------------->
			<%if(loginMember==null){ %>
			<div class="container-fluid">
				<div class="row">
					<div class="col-1"></div>


					<div class="col-1"></div>
					<div class="col-7"></div>

					<div class="col-1">
						<input type="checkbox" id="viewSaveId"
							<%=saveId!=null?"checked":"" %>> <label for="saveId">?????????
							??????</label>
						<!-- form ???????????? ????????? ?????? ?????? ????????? ?????? ????????? ?????? -->
					</div>

					<div class="col-1">

						<button type="button" class="btn btn-outline-success"
							onclick="location.assign('<%=request.getContextPath()%>/member/enrollMember.do')">????????????</button>
					</div>
					<!-- onclick????????? ???????????? ?????? ????????? ??? ?????? -->

					<!-- <button type="button" class="btn btn-outline-success">ID / PW ??????</button> -->

					<div class="col-1"></div>
				</div>
			</div>
			<%} %>

			<!------------------------------------------------ ??????????????? ???????????? ?????????--------------------------------------------->
			<div class="container-fluid">
				<div class="row">
					<div class="col-1"></div>
					<span class="placeholder col-10 placeholder-xs bg-info"></span>
					<div class="col-1"></div>
				</div>

			</div>

			<script>
      $(()=>{
        $("body").css({width:screen.availWidth, height:screen.availHeight});
       console.log("??????", $("section>div"));
      })
    
    </script>
	</header>

	<script>
	/* ???????????? ???????????? servlet??????, ?????? ????????? ?????? ????????? ????????? ????????????(get???????????? ??????) */
	const memberView=()=>{

	location.assign("<%=request.getContextPath()%>/member/memberView.do?memberId=<%=loginMember!=null?loginMember.getMemberId():""%>")
			}															// userId??? ?????? ????????? ??????...



	</script>