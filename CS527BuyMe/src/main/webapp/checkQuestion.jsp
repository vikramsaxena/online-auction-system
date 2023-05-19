<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Verify Listing</title>
</head>
<body>
	<%
		try {
			//Database Connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			String username = (String) session.getAttribute("username");
			if (null == username) {
				response.sendRedirect("login.jsp");
			}
			String question = request.getParameter("question");
			
			String insert = "INSERT INTO question(q_text) " 
					+ "VALUES(?)";
			
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, question);
			ps.executeUpdate();

			insert = "INSERT INTO asks(asker, q_id) " 
					+ "VALUES(?, (SELECT MAX(q_id) FROM question))";
			
			ps = con.prepareStatement(insert);
			ps.setString(1, username);
			ps.executeUpdate();
			
			%>
			<jsp:forward page="account.jsp">
			<jsp:param name="askQuestionRet" value="Question successfully submitted!"/> 
			</jsp:forward>
			<% 
		} catch (SQLException e) {
			String code = e.getSQLState();
			if ("23000".equals(code)) {
				%>
				<jsp:forward page="postQuestion.jsp">
				<jsp:param name="msg" value="ERROR"/> 
				</jsp:forward>
				<%
			} else {
				%>
				<jsp:forward page="postQuestion.jsp">
				<jsp:param name="msg" value="ERROR"/> 
				</jsp:forward>
				<%
			}
		} catch (Exception e) {
			out.print("Unknown exception.");
			%>
			<jsp:forward page="postQuestion.jsp">
			<jsp:param name="msg" value="ERROR"/> 
			</jsp:forward>
			<%
		}
	%>
</body>
</html>
