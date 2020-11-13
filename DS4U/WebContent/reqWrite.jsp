<%@page import="req.ReqDTO"%>
<%@page import="req.ReqDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="stf.StfDTO" %>
<%@ page import="stf.StfDAO" %>
<%@ page import="apv.ApvDAO" %>
<%@ page import="apv.ApvDTO" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>

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
	StfDTO stf = new StfDAO().getUser(STF_ID);
	
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
	<!-- <script type="text/javascript"> --> 
	<!-- 
		function removeCheck() {
			 if (confirm("취소하시겠습니까?") == true){    //확인

				 window.open('', '_self', '');

				 window.close();

			 }else{   //취소

			     return false;

			 }
		}
		function registerCheck() {
			 if (confirm("등록하시겠습니까?") == true){    //확인

				 window.open('', '_self', '');

				 window.close();

			 }else{   //취소

			     return false;

			 }
		} 
		
	</script>-->
    <!--  <title>정보화사업 등록</title>
    
    <style>
        #wrap{
            width:530px;
            margin-left:auto; 
            margin-right:auto;
            text-align:center;
        }
        
        table{
            border:3px solid skyblue
        }
        
        td{
            border:1px solid skyblue
        }
        
        #title{
            background-color:skyblue
        }
    </style>-->
    
    
    <script>
    function getSelectValue(frm)
   	 {
    	frm.APV_NM.value = frm.selectBox.options[frm.selectBox.selectedIndex].text;
    	frm.APV_SQ.value = frm.selectBox.options[frm.selectBox.selectedIndex].value;
   	 } <!-- selectBox에서 정보화사업 클릭시 해당 APV_SQ와 APV_NM을 가져옴-->
    </script>
    
    
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
                <li><a href="boardView.jsp">게시판</a></li>
				<li><a href="apvView.jsp">정보화 사업</a></li>
                <li class="active"><a href="reqView.jsp">보안성 검토</a></li>
            </ul>
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
        <form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
			<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
			<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		</form>            
       	</div>
    </nav> 
    <!-- 왼쪽, 오른쪽 바깥여백을 auto로 주면 중앙정렬된다.  -->
    <div class="container">
		<form method="post" action="./reqWrite" enctype="multipart/form-data" name = "form">
			<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>보안성 검토 의뢰</h4></th>
					</tr>
				</thead>
				<tbody>
	
					<tr>
						<td style="width: 130px; text-align: left;"><h5>1. 사업명</h5></td>
							<td> <select name="selectBox" onChange="getSelectValue(this.form);">	
								<option value="" selected>===선택해주세요===</option>
								<% 

								Connection conn = null;
						    	PreparedStatement pstmt = null;
						    	ResultSet rs = null;
						    	DataSource dataSource;
						    	InitialContext initContext = new InitialContext();
								Context envContext = (Context) initContext.lookup("java:/comp/env");
								dataSource = (DataSource) envContext.lookup("jdbc/DS4U");
					    		
						    	
						    	try{
						    		
						    		conn = dataSource.getConnection();
						       
					           		String SQL = "SELECT APV_SQ, APV_NM FROM APV";

					           		pstmt = conn.prepareStatement(SQL);
					          		rs = pstmt.executeQuery();
					           
					            while (rs.next()) {
					            	
					          		int APV_SQ = rs.getInt("APV_SQ");
					            	String APV_NM = rs.getString("APV_NM").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
		    
					            	%>
					            		<option value=<%=APV_SQ%>><%=APV_NM%></option>
					            	<%
					            	
					            	}
					            
						    	} catch (Exception e) {
						            e.printStackTrace();
						        } finally {
						        	try {
						        		if (rs != null) rs.close();
						        		if (pstmt != null) pstmt.close();
						        		if (conn != null) conn.close();
						        	} catch (Exception e) {
						        		e.printStackTrace();
						        	}       	
						        }

						    	%>
					
					
						</select>
						<input type="hidden"  name="APV_NM" ><input type="hidden"  name="APV_SQ" ></td>	
					</tr>
					<tr>
						<td style="width: 130px; text-align: left;"><h5>2. 추진 목적</h5></td>
						<td><input class="form-control" type="text" id="APV_OBJ" name="APV_OBJ" maxlength="600" placeholder="추진 목적을 입력하세요."></td>				
					</tr>		
					<tr>
						<td style="width: 130px; text-align: left;"><h5>3. 사업 내용</h5></td>
						<td colspan="2"><input class="form-control" id="APV_CONT" type="text" name="APV_CONT" maxlength="1000" placeholder="사업 내용을 입력하세요."></td>				
					</tr>
					<tr>
						<td style="width: 130px; text-align: left;"><h5>4. 사업 기간</h5></td>
						<td colspan="2"><input class="form-control" id="APV_DATE" type="text" name="APV_DATE" maxlength="100" placeholder="사업 기간을 입력하세요."></td>				
					</tr>
					<tr>
						<td style="width: 130px; text-align: left;"><h5>5. 담당자</h5></td>
						<td><h5><%= stf.getSTF_ID() %></h5>
						<input type="hidden" name="STF_ID" value="<%= stf.getSTF_ID() %>"></td>				
					</tr>
					
					<tr>
						<td style="text-align: left;" colspan="3"><h5 style="color: red;"></h5>
						<input class="btn btn-primary pull-right" type="submit" value="등록"></td>
				
					</tr>																												
				</tbody>
				
			</table>
			<!-- <input class="btn btn-primary pull-right" type="button" value="취소" onclick="removeCheck()"> -->
			<!--<input class="btn btn-primary pull-right" type="submit" value="등록" onclick="registerCheck()"> -->			
		</form>
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
	
	</script>        
</body>
</html>
