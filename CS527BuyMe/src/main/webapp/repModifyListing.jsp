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
	
	String operation = request.getParameter("operation");
	String lid = request.getParameter("lid");
	if ("removeListing".equals(operation)) {
		PreparedStatement ps = con.prepareStatement("DELETE FROM listings WHERE l_id=(?)");
		ps.setString(1, lid);
		ps.executeUpdate();
		response.sendRedirect("custRepHome.jsp");
	} else if ("removeBid".equals(operation)) {
		String bid = request.getParameter("bid");
		PreparedStatement ps = con.prepareStatement("DELETE FROM bids WHERE b_id=(?)");
		ps.setString(1, bid);
		ps.executeUpdate();
		ps = con.prepareStatement(
				"SELECT MAX(b.price) " +
				"FROM listings l " +
				"INNER JOIN bidson bd ON bd.l_id = l.l_id " +
				"INNER JOIN bids b ON b.b_id = bd.b_id " +
				"WHERE l.l_id=(?)"
		);
		ps.setString(1, lid);
		ResultSet rs = ps.executeQuery();
		String new_price = null;
		if (rs.next()) {
			new_price = rs.getString(1);
		}
		if (null == new_price) {
			ps = con.prepareStatement(
					"UPDATE listings SET price=0.01 WHERE l_id=(?)"
			);
			ps.setString(1, lid);
		} else {
			ps = con.prepareStatement(
					"UPDATE listings SET price=(?) WHERE l_id=(?)"
			);
			ps.setString(1, new_price);
			ps.setString(2, lid);
		}
		ps.executeUpdate();
	%>
		<jsp:forward page="repViewListing.jsp">
		<jsp:param name="lid" value="<%= lid %>"/> 
		</jsp:forward>
	<%
	}
	%>
</body>
</html>