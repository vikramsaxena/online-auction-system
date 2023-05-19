<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String old_user = request.getParameter("old_user");
		String examined_user = old_user;
		String new_user = request.getParameter("new_user");
		String new_pass = request.getParameter("new_pass");
		String deleteOperation = request.getParameter("delete");
		
		if (null != deleteOperation && "true".equals(deleteOperation)) {
			PreparedStatement ps = con.prepareStatement(
					"DELETE FROM users WHERE username=(?)"
			);
			ps.setString(1, old_user);
			ps.executeUpdate();
			response.sendRedirect("custRepHome.jsp");
		} else {
			if (null != new_pass && !new_pass.isBlank()) {
				PreparedStatement ps = con.prepareStatement(
						"UPDATE users SET password=(?) WHERE username=(?)"
				);
				ps.setString(1, new_pass);
				ps.setString(2, old_user);
				ps.executeUpdate();
			}
			
			if (null != new_user && !new_user.isBlank()) {
				PreparedStatement ps = con.prepareStatement(
						"UPDATE users SET username=(?) WHERE username=(?)"
				);
				ps.setString(1, new_user);
				ps.setString(2, old_user);
				examined_user = new_user;
				ps.executeUpdate();
			}
		%>
	<jsp:forward page="repViewUser.jsp">
	<jsp:param name="username" value="<%=examined_user%>"/> 
	</jsp:forward>
	<% } %>
</body>
</html>