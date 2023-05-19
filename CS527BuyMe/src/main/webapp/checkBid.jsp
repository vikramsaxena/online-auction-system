<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
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
			//Database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			Statement stmt3 = con.createStatement();
			
			String username = (String) session.getAttribute("username");
			if (username == null) {
				response.sendRedirect("login.jsp");
			}
			String lid = request.getParameter("lid");
			String bid = request.getParameter("bid");
			
			PreparedStatement prepst = con.prepareStatement("SELECT price FROM listings WHERE l_id=(?)");
			prepst.setString(1, lid);
			ResultSet r = prepst.executeQuery();
			r.next();
			String price = r.getString(1);
			Double b = Double.parseDouble(bid);
			Double p = Double.parseDouble(price);
			
            p = Math.round(p * 100.0)/100.0;
            b = Math.round(b * 100.0)/100.0;
            
			if("NONE".equals(bid)){
				%>
				<jsp:forward page="viewListing.jsp">
				<jsp:param name="msg" value="You must input a bid."/> 
				<jsp:param name="lid" value="<%=lid%>"/> 
				</jsp:forward>
			<% } else if (p >= b) { %>
				<jsp:forward page="viewListing.jsp">
				<jsp:param name="msg" value="You must input a valid bid."/> 
				<jsp:param name="lid" value="<%=lid%>"/> 
				</jsp:forward><%
			}else{

				String insert = "UPDATE listings SET price = " + b + " WHERE l_id = " + lid;
				PreparedStatement ps = con.prepareStatement(insert);
				ps.executeUpdate();
				
				insert = "INSERT INTO bids(price, dtime)" 
						+ "VALUES(?,?)";
				ps = con.prepareStatement(insert);
				ps.setString(1, bid);
				ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
				ps.executeUpdate();
				
				insert = "INSERT INTO bidson(b_id, l_id)" 
						+ "VALUES((SELECT MAX(b_id) FROM bids),?)";
				ps = con.prepareStatement(insert);
				ps.setString(1, lid);
				ps.executeUpdate();
				
				insert = "INSERT INTO places(b_id, username)" 
						+ "VALUES((SELECT MAX(b_id) FROM bids),?)";
				ps = con.prepareStatement(insert);
				ps.setString(1, username);
				ps.executeUpdate();
				
				
			} 		
			
			%>
			<jsp:forward page="viewListing.jsp">
			<jsp:param name="makeBidRet" value="Bid success!"/>
			<jsp:param name="lid" value="<%=lid%>"/>
			 
			</jsp:forward>
			<% 
		} catch (SQLException e) {
			String code = e.getSQLState();
			e.printStackTrace();
			if ("23000".equals(code)) {
				%>
				<jsp:forward page="account.jsp">
				<jsp:param name="msg" value="This bid already exists."/> 
				</jsp:forward>
				<%
			} else {
				%>
				<jsp:forward page="account.jsp">
				<jsp:param name="msg" value="Error making bid... Please try again."/> 
				</jsp:forward>
				<%
			}
		} catch (Exception e) {
			out.print("Unknown exception.");
			%>
			<jsp:forward page="account.jsp">
			<jsp:param name="msg" value="Error making bid. Please try again."/> 
			</jsp:forward>
			<%
		}
	%>
</body>
</html>