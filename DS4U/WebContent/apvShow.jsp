<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="apv.ApvDAO" %>
<%@ page import="apv.ApvDTO" %>
<%@ include file="/head.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	String APV_SQ = null;
	if (request.getParameter("APV_SQ") != null) {
		APV_SQ = (String) request.getParameter("APV_SQ");
	}
	if (APV_SQ == null || APV_SQ.equals("")) {
		session.setAttribute("messageType", "오류 메시지");
		session.setAttribute("messageContent", "게시물을 선택해주세요.");
		response.sendRedirect("index.jsp");
		return;	
	}

	
	ApvDAO apvDAO = new ApvDAO();
	ApvDTO apv = apvDAO.getApv(APV_SQ);
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- <link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css"> -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/css/headerWs.css"/>
	<link rel="stylesheet" type="text/css" href="${contextPath}/css/navWs.css"/>
	<link rel="stylesheet" type="text/css" href="${contextPath}/css/apv.css"/>
	<link rel="stylesheet" type="text/css" href="${contextPath}/css/modal.css"/>
	<title>서울교통공사</title>
	<script src="js/bootstrap.js"></script>
</head>

<body>
	<%@ include file="/headerWs.jsp" %>
	<%@ include file="/navWs.jsp" %>
	<div id="wsBody">
	<input type="hidden" value="board" id="pageType">
		<div id="wsBodyContainer">
		
			<h3>정보화 사업</h3>
			<h4>정보화 사업 상세보기</h4>
			<div id="boardInner">
				<div id="boardDetail">
				<div class="container">
					<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="2"><h4></h4></th>
							</tr>
							<tr>
								<td style="background-color: #fafafa; color: #000000; width: 120px; "><h5>사업명</h5></td>
								<td style="width: 800px;" colspan="2"><h5><%= apv.getAPV_NM() %></h5></td>
							</tr>				
							<tr>
								<td style="background-color: #fafafa; color: #000000; width: 120px;"><h5>사업기간</h5></td>
								<td colspan="2"><h5><%= apv.getAPV_DATE() %></h5></td>
							</tr>
							<tr>
								<td style="background-color: #fafafa; color: #000000; width: 120px;"><h5>사업시작일</h5></td>
								<td colspan="2"><h5><%= apv.getAPV_STT_DATE() %></h5></td>
							</tr>
							<tr>
								<td style="background-color: #fafafa; color: #000000; width: 120px;"><h5>사업종료일</h5></td>
								<td colspan="2"><h5><%= apv.getAPV_FIN_DATE() %></h5></td>
							</tr>
							<tr>
								<td style="background-color: #fafafa; color: #000000; width: 120px;"><h5>소요예산</h5></td>
								<td colspan="2"><h5><%= apv.getAPV_BUDGET() %></h5></td>
							</tr>
							<tr>
								<td style="background-color: #fafafa; color: #000000; width: 120px;"><h5>사업담당자</h5></td>
								<td colspan="2"><h5><%= apv.getSTF_ID() %></h5></td>
							</tr>
							<tr>
								<td style="background-color: #fafafa; color: #000000; width: 120px;"><h5>연락처</h5></td>
								<td colspan="2"><h5><%= apv.getAPV_PHONE() %></h5></td>
							</tr>
							<tr>
								<td style="background-color: #fafafa; color: #000000; width: 120px;"><h5>사업방침번호</h5></td>
								<td colspan="2"><h5><%= apv.getAPV_POLICY_SQ() %></h5></td>
							</tr>
							<tr>
								<td style="background-color: #fafafa; color: #000000; width: 120px;"><h5>첨부파일</h5></td>
								<td colspan="2"><a href="apvDownload.jsp?APV_SQ=<%= apv.getAPV_SQ() %>"><%= apv.getAPV_FILE() %></a></td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="5" style="text-align : right;">
									<a href="apvView.jsp" class="btn btn-primary">목록</a>
			
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