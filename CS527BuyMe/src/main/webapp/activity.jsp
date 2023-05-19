<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Shirts</title>
</head>
<body style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; background-size: cover; text-decoration: none; color: white">

	<% 
    	//Database Connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String username = (String) session.getAttribute("username");
		if (null == username) {
			response.sendRedirect("login.jsp");
		}
		
	%>

    <div style="text-align: center">
    	<h1>Account Activity</h1>
    	<h4>View auctions for all participating users.</h4>

  		<a style="text-decoration: underline; color: white" href="home.jsp">Home</a></td><br>
		<a style="text-decoration: underline; color: white" href="account.jsp">Account</a><br><br>

<div class="container">
	<form class="form-inline" method="post" action="activity.jsp">
    	<input type="text" name="usersearch" class="form-control" placeholder="Search...">
    	<button type="submit" name="save" class="btn btn-primary">Search Another User</button>
  	</form>
  
  	<br>
  
</div>
    	
    	<% 
    		String usersearch = request.getParameter("usersearch");     
    		if (null != usersearch) {
    			%>
    			<h4>Viewing User: <%=usersearch%></h4>
    			<%
    		} else {
    			usersearch = username;
    			%>
    			<h4>Viewing User: <%=usersearch%></h4>
    			<%	
    		}
    	
    		Statement stmt1 = con.createStatement();
       		ResultSet bidhist = stmt1.executeQuery("SELECT l_id, b.b_id, price, username, dtime from bids b "+
        		"LEFT JOIN bidson bo on bo.b_id = b.b_id LEFT JOIN places p on p.b_id = bo.b_id " +
        		"WHERE username= '" +usersearch+"';");
    	
    	
    	%>
    	<br><br>
    	<h4>Bids Placed</h4>
    	<form method="post" action="viewListing.jsp">
    	<TABLE align="center">	
            <TR>
            	<TH>-View- | </TH>
                <TH>-Price- | </TH>
                <TH>-Date/Time-</TH>
            </TR>
            <% while(bidhist.next()) { 
            %>
            <TR>
            	<TD> <button name="lid" type="submit" value="<%= bidhist.getString(1) %>">>></button></TD>
                <TD><%= bidhist.getString(3) %></TD>
                <TD><%= bidhist.getString(4) %></TD>
            </TR>
            <% } %>
        </TABLE>
    	</form>
    	
    	<br>
    		<%
    			Statement stmt2 = con.createStatement();
       			ResultSet listhist = stmt2.executeQuery("SELECT l.l_id, l.itemname from listings l "+
        			"LEFT JOIN posts p on p.l_id = l.l_id " +
        			"WHERE username= '" +usersearch+"';");
    		%>
    	
    	
    	
    	    	<h4>Listings Posted</h4>
    	    	<form method="post" action="viewListing.jsp">
    	<TABLE align="center">	
            <TR>
            	<TH>-View- | </TH>
                <TH>-Item Name-</TH>
            </TR>
            <% while(listhist.next()) { 
            %>
            <TR>
            	<TD> <button name="lid" type="submit" value="<%= listhist.getString(1) %>">>></button></TD>
           		<TD><%=listhist.getString(2)%></TD>
            </TR>
            <% } %>
        </TABLE>
    	</form>

    </div>
</body>
</html>
