<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<%
	String STF_ID = null;
	if (session.getAttribute("STF_ID") != null) {
		STF_ID = (String) session.getAttribute("STF_ID");
	}
	if (STF_ID == null) {
		session.setAttribute("messageType", "오류 메시지");
		session.setAttribute("messageContent", "로그인이 필요합니다.");
		response.sendRedirect("index.jsp");
		return;	
	}
	String pageNumber = "1";
	if (request.getParameter("pageNumber") != null) {
		pageNumber = request.getParameter("pageNumber");
	}
	try {
		Integer.parseInt(pageNumber);
	} catch (Exception e) {
		session.setAttribute("messageType", "오류 메시지");
		session.setAttribute("messageContent", "페이지 번호가 잘못되었습니다.");
		response.sendRedirect("boardView.jsp");
		return;			
	}
	ArrayList<BoardDTO> boardList = new BoardDAO().getList(pageNumber);
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">  <!-- 반응형 웹에 사용하는 메타태그 -->
       <!-- viewport = 화면 표시영역, content = 모바일에 맞게 크기 조정, initial = 초기화면 배율, shrink-to-fit=no = 줄임방지 -->
	<link rel="stylesheet" href="css/bootstrap.css"> <!-- 스타일시트 bootstrap.css 참조 -->
	<link rel="stylesheet" href="css/custom.css"> <!-- 참조  -->
	<title>서울교통공사</title>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</head>
<body>
    <nav class ="navbar navbar-default">   <!-- navbar-색상 -->
        <div class="navbar-header">   <!-- 홈페이지 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
				<!-- class="navbar-toggle collapsed" : 네비게이션 화면 출력유무-->
				<!-- data-toggle="collapse" : 모바일에서 클릭 시 메뉴 나옴 -->				
                <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
                <span class ="icon-bar"></span> <!-- 아이콘 이미지 -->
                <span class ="icon-bar"></span>
            </button>
			<a class="navbar-brand" href="index.jsp"><img alt="Brand" src="images/logo.jpg"></a>
            	<!-- bootstrap navbar 기본 메뉴바 -->
                               
        </div>        
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">       <!-- navbar-nav : 네비게이션 바 메뉴 -->
                <li><a href="index.jsp">메인</a></li>
                <li class="active"><a href="boardView.jsp">게시판</a></li>
            </ul>
            
			<%
            // 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
                if(STF_ID == null) {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                	<a href="#" class="dropdown-toggle"
                    	data-toggle="dropdown" role ="button" aria-haspopup="true"
                    	aria-expanded="false">접속하기<span class="caret"></span>
                    	<!-- 임시 주소링크 "#" -->
                    	<!-- caret = caret 화살표 아이콘 ▼ -->
                    </a>                   	
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>                             	
            <%
            // 로그인이 되어있는 사람만 볼수 있는 화면
                } else {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                	<a href="#" class = "dropdown-toggle"
                    	data-toggle="dropdown" role ="button" aria-haspopup="true"
                    	aria-expanded="false">회원관리<span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                    	<li><a href="update.jsp">회원정보수정</a></li>
                        <li><a href="logoutAction.jsp">로그아웃</a></li>                  
                    </ul>
                </li>
            </ul>            
            <%
                }
            %>
       	</div> 
	</nav>
	<div class="container">
		<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="5"><h4>게시판</h4></th>
				</tr>
				<tr>
					<th style="background-color: #fafafa; color: #000000; width: 70px;"><h5>번호</h5></th>
					<th style="background-color: #fafafa; color: #000000;"><h5>제목</h5></th>
					<th style="background-color: #fafafa; color: #000000; width: 100px;"><h5>작성자</h5></th>
					<th style="background-color: #fafafa; color: #000000; width: 170px;"><h5>작성 날짜</h5></th>
					<th style="background-color: #fafafa; color: #000000; width: 70px;"><h5>조회수</h5></th>
				</tr>
			</thead>
			<tbody>
			<%
				for (int i=0; i<boardList.size(); i++) {
					BoardDTO board = boardList.get(i);
			%>
				<tr>
					<td><%= board.getBOARD_SQ() %></td>
					<td style="text-align: left;">
					<a href="boardShow.jsp?BOARD_SQ=<%= board.getBOARD_SQ() %>">
			<%
				for (int j=0; j<board.getBOARD_LEVEL(); j++) {
			%>
					<span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
			<% 
				}
			%>
			<%
				if (board.getBOARD_AVAILABLE() == 0) {
			%>
				(삭제된 게시물입니다.)
			<%
				} else {
			%>
				<%= board.getBOARD_NM() %>
			<%
				}
			%>
			</a></td>
					<td><%= board.getSTF_ID() %></td>
					<td><%= board.getBOARD_DT() %></td>
					<td><%= board.getBOARDHIT() %></td>
				</tr>
			<%
				}
			%>
				<tr>
					<td colspan="5">
						<a href="boardWrite.jsp" class="btn btn-primary pull-right" type="submit">글쓰기</a>
						<ul class="pagination" style="margin: 0 auto;">
					<% 
						int startPage = (Integer.parseInt(pageNumber) / 10) * 10 + 1;
						if (Integer.parseInt(pageNumber) % 10 == 0) startPage -= 10;
						int targetPage = new BoardDAO().targetPage(pageNumber);
						if (startPage != 1) {
					%>
						<li><a href="boardView.jsp?pageNumber=<%= startPage - 1 %>"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
					<%
						} else {
					%>
						<li><span class="glyphicon glyphicon-chevron-left" style="color: gray;"></span></li>
					<%
						}
						for (int i=startPage; i<Integer.parseInt(pageNumber); i++) {
					%>
						<li><a href="boardView.jsp?pageNumber=<%= i %>"><%= i %></a></li>
					<%
						}
					%>
						<li class="active"><a href="boardView.jsp?pageNumber=<%= pageNumber %>"><%= pageNumber %></a></li>	
					<%
						for (int i=Integer.parseInt(pageNumber) + 1; i<=targetPage + Integer.parseInt(pageNumber); i++) {
							if (i < startPage + 10) {
					%>
						<li><a href="boardView.jsp?pageNumber=<%= i %>"><%= i %></a></li>
					<%
							}
						}
						if (targetPage + Integer.parseInt(pageNumber) > startPage + 9) {
					%>
						<li><a href="boardView.jsp?pageNumber=<%= startPage + 10 %>"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
					<%
						} else {
					%>
						<li><span class="glyphicon glyphicon-chevron-right" style="color: gray;"></span></li>
					<%
						}
					%>	
						
						</ul>
					</td>
				</tr>			
			</tbody>
		</table>
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
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>	   
	<script>
		$('#messageModal').modal("show");
	</script>	      
</body>
</html>