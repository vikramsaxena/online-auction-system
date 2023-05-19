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
			String itemname = request.getParameter("itemname");
			String subcategory = request.getParameter("subcategory");
			if ("NONE".equals(subcategory)) {
				%>
				<jsp:forward page="postListing.jsp">
				<jsp:param name="msg" value="You must select a subcategory."/> 
				</jsp:forward>
			<%} else {
				String subattribute = request.getParameter("subattribute");
				String price = request.getParameter("price");
				String minsale = request.getParameter("minsale");
				String dt = request.getParameter("dt");
				
				String insert = "INSERT INTO listings(itemname, subcategory, subattribute, price, minsale, dt) " 
						+ "VALUES(?, ?, ?, ?, ?, ?)";
				
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1, itemname);
				ps.setString(2, subcategory);
				ps.setString(3, subattribute);
				ps.setString(4, price);
				ps.setString(5, minsale);
				ps.setString(6, dt);
				ps.executeUpdate();
				
				insert = "INSERT INTO posts(l_id, username) " 
						+ "VALUES((SELECT MAX(l_id) FROM listings),?)";
				ps = con.prepareStatement(insert);
				ps.setString(1, username);
				ps.executeUpdate();
			} 		
			
			%>
			<jsp:forward page="account.jsp">
			<jsp:param name="createListingRet" value="Listing is successfully posted."/> 
			</jsp:forward>
			<% 
		} catch (SQLException e) {
			String code = e.getSQLState();
			if ("23000".equals(code)) {
				%>
				<jsp:forward page="postListing.jsp">
				<jsp:param name="msg" value="The Listing already exists."/> 
				</jsp:forward>
				<%
			} else {
				%>
				<jsp:forward page="account.jsp">
				<jsp:param name="msg" value="Error posting listing. Please try again."/> 
				</jsp:forward>
				<%
			}
		} catch (Exception e) {
			out.print("Unknown exception.");
			%>
			<jsp:forward page="account.jsp">
			<jsp:param name="msg" value="Error posting listing. Please try again."/> 
			</jsp:forward>
			<%
		}
	%>
</body>
</html>
