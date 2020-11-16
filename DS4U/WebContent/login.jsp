<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/head.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- <link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css"> -->
	<link rel="stylesheet" type="text/css" href="css/headerMain.css"/>
	<link rel="stylesheet" type="text/css" href="css/footerMain.css"/>
	<link rel="stylesheet" type="text/css" href="css/animate.css"/>
	<link rel="stylesheet" type="text/css" href="css/login.css"/>
	<link rel="stylesheet" type="text/css" href="css/modal.css"/>
	<title>서울교통공사</title>
	<script src="js/bootstrap.js"></script>
</head>
<body>
	<%
		String STF_ID = null;
		if (session.getAttribute("STF_ID") != null) {
			STF_ID = (String) session.getAttribute("STF_ID");
		}
		if (STF_ID != null) {
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messageContent", "이미 로그인 되어 있습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
	%>
	<div id="wrap">
		<%@ include file="/headerMain.jsp" %>
		<div id="loginAll">
			<section>
				<div id="loginBox" class="animated fadeIn">
					<div class="header">
						<!--위 내용-->
						<div class="inner-header flex">
							<div class="loginBox-Head">
								<h3 style='font-weight: bolder; font-size: 30px'>로그인</h3>
								<p>LOG IN</p>
							</div>
						</div>
					</div><!--header end-->						
					<!--아래 내용-->
					<div class="content flex">
						<div class="loginBox-Body">
							<form action="./userLogin" method="post" id="loginForm">	
								<div>
									<h4>ID</h4>
									<input type="text" name="STF_ID" placeholder="아이디를 입력하세요." id="STF_ID" maxlength="10">
								</div>
								<div class="pwDiv">
									<h4>PASSWORD</h4>
									<input type="password" name="STF_PW" placeholder="비밀번호를 입력하세요." id="STF_PW" maxlength="20">
									<a class="pwForget" href='${contextPath}/pwReset.jsp'>비밀번호를 잊어버리셨나요?</a>
								</div>
								<div>
								</div>
								<div>
									<input type="submit" value="로그인" class="loginFormButton">
								</div>
								<div id="joinBtnInLoginForm">
									<input type="button" value="회원가입" class="loginFormButton" onclick="location.href='${contextPath}/join.jsp'">
								</div>
							</form>
						</div>
					</div><!--Content ends-->
				</div>
			</section>
		</div>
	</div> 						
	<%
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if (session.getAttribute("messageType") != null) {
			messageType = (String) session.getAttribute("messageType");
		}
		if (messageContent != null) {
	%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content <% if(messageType.equals("오류 메시지")) out.println("panel-warning"); else out.println("panel-success");%>">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%= messageType %>
						</h4>
					</div>
					<div class="modal-body">
						<%= messageContent %>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#messageModal').modal("show");
	</script>
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							확인 메시지
						</h4>
					</div>
					<div id="checkMessage" class="modal-body">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>	
	</div>
</body>
</html>