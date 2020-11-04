<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
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
	String BOARD_SQ = null;
	if (request.getParameter("BOARD_SQ") != null) {
		BOARD_SQ = (String) request.getParameter("BOARD_SQ");
	}
	if (BOARD_SQ == null || BOARD_SQ.equals("")) {
		session.setAttribute("messageType", "오류 메시지");
		session.setAttribute("messageContent", "게시물을 선택해주세요.");
		response.sendRedirect("index.jsp");
		return;	
	}
	BoardDAO boardDAO = new BoardDAO();
	BoardDTO board = boardDAO.getBoard(BOARD_SQ);
	if (board.getBOARD_AVAILABLE() == 0) {
		session.setAttribute("messageType", "오류 메시지");
		session.setAttribute("messageContent", "삭제된 게시물입니다.");
		response.sendRedirect("boardView.jsp");
		return;	
	}
	boardDAO.hit(BOARD_SQ);
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
            	<li><a href="apvView.jsp">정보화사업</a></li>
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
        <form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
			<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
			<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		</form>
       	</div> 
	</nav>
	<div class="container">
		<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="4"><h4>게시판 보기</h4></th>
				</tr>
				<tr>
					<td style="background-color: #fafafa; color: #000000; width: 80px;"><h5>제목</h5></td>
					<td colspan="3"><h5><%= board.getBOARD_NM() %></h5></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; color: #000000; width: 80px;"><h5>작성자</h5></td>
					<td colspan="3"><h5><%= board.getSTF_ID() %></h5></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; color: #000000; width: 80px;"><h5>작성날짜</h5></td>
					<td><h5><%= board.getBOARD_DT() %></h5></td>
					<td style="background-color: #fafafa; color: #000000; width: 80px;"><h5>조회수</h5></td>
					<td><h5><%= board.getBOARDHIT() + 1 %></h5></td>
				</tr>
				<tr>
					<td style="vertical-align: middle; min-height: 150px; background-color: #fafafa; color: #000000; width: 80px;"><h5>글 내용</h5></td>
					<td colspan="3" style="text-align: left;"><h5><%= board.getBOARD_TXT() %></h5></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; color: #000000; width: 80px;"><h5>첨부파일</h5></td>
					<td colspan="3"><h5><a href="boardDownload.jsp?BOARD_SQ=<%= board.getBOARD_SQ() %>"><%= board.getBOARD_FILE() %></h5></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="5" style="text-align : right;">
						<a href="boardView.jsp" class="btn btn-primary">목록</a>
						<a href="boardReply.jsp?BOARD_SQ=<%= board.getBOARD_SQ() %>" class="btn btn-primary">답변</a>
						<%
							if (STF_ID.equals(board.getSTF_ID())) {								
						%>
							<a href="boardUpdate.jsp?BOARD_SQ=<%= board.getBOARD_SQ() %>" class="btn btn-primary">수정</a>
							<a href="boardDelete?BOARD_SQ=<%= board.getBOARD_SQ() %>" class="btn btn-primary" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
						<%		
							}
						%>
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