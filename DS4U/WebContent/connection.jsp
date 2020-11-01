<!-- 커넥션 풀 : DB에 접근할 때 간편하고 안정적이며, DB에 접근한 사용자의 수를 효율적으로 관리 -->

<html>
<head>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, javax.naming.InitialContext, javax.naming.*" %>
</head>
<body>
	<%
		InitialContext initCtx = new InitialContext();
		Context envContext = (Context) initCtx.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/DS4U");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("SELECT VERSION();");
		while(rset.next()) {
			out.println("MySQL Version: " + rset.getString("version()"));
		}
		rset.close();
		stmt.close();
		conn.close();
		initCtx.close();
	%>
</body>
</html>
