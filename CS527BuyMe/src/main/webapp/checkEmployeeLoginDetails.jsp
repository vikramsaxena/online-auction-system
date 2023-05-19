<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
		try {
			//Database Connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			String id = request.getParameter("employee_id");
			String password = request.getParameter("password");
			
			String lookup = "SELECT id, password FROM admin WHERE " 
						+ "id=(?) AND password=(?)";
			PreparedStatement ps = con.prepareStatement(lookup);
			ps.setString(1, id);
			ps.setString(2, password);
			ResultSet result = ps.executeQuery();

			if (result.next()) {
				session.setAttribute("employeeid", id);
				%>
				<jsp:forward page="adminHome.jsp">
				<jsp:param name="user" value="<%=id%>"/> 
				</jsp:forward>
				<%
			}
			
			lookup = "SELECT id, password FROM customer_rep WHERE " 
					+ "id=(?) AND password=(?)";
			ps = con.prepareStatement(lookup);
			ps.setString(1, id);
			ps.setString(2, password);
			result = ps.executeQuery();
			if (result.next()) {
				session.setAttribute("employeeid", id);
				%>
				<jsp:forward page="custRepHome.jsp">
				<jsp:param name="rep_id" value="<%=id%>"/> 
				</jsp:forward>
				<%
			} else {
				%>
				<jsp:forward page="adminCustRepLogin.jsp">
				<jsp:param name="loginRet" value="Incorrect employee ID or password."/> 
				</jsp:forward>
				<%
			}

		} catch (Exception e) {
			%>
			<jsp:forward page="adminCustRepLogin.jsp">
			<jsp:param name="loginRet" value="Error logging in. Please try again."/> 
			</jsp:forward>
			<%
		}
	%>
</body>
</html>
