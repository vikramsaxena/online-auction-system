<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Listing Editor</title>
</head>
<body>
<% 
    		//Database Connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			String rep_id = (String) session.getAttribute("employeeid");
			if (null == rep_id) {
				response.sendRedirect("login.jsp");
			}
			String lid = request.getParameter("lid");
			Statement stmt = con.createStatement();
            ResultSet resultset = stmt.executeQuery("SELECT * from listings WHERE l_id='"+lid+"';") ; 
        	   	String name = null;
	            String subcat = null;
	            String subattr = null;
	            String price = null;
	            String minsale = null;
	            String cdt = null;
	            Double p = null;
	            Double m = null;
	            Double minbid = null;
	            
	            Statement stmt2 = con.createStatement();
	          	ResultSet fetchposter = stmt2.executeQuery("SELECT username from posts WHERE l_id="+lid+";");
	            String postedby = null;
	           	%>

                <%
                while (resultset.next()) {
		            name = resultset.getString(2);
		            subcat = resultset.getString(3);
		            subattr = resultset.getString(4);
		            price = resultset.getString(5);
		            minsale = resultset.getString(6);
		            cdt = resultset.getString(7);
		            
		            p = Double.parseDouble(price);
		            p = Math.round(p * 100.0)/100.0;
					minbid = p+.01;
					minbid = Math.round(minbid * 100.0)/100.0;
	            }
                
                while (fetchposter.next()) {
    	            postedby = fetchposter.getString(1);
    	        }
            	%>
        
        <div style="text-align: center">
        <a href="custRepHome.jsp">Exit Listing</a>
    		<h1><%=name%></h1>
    		
	    	<table align="center">
	   			<tr>  
					<td><input type="hidden" name="lid" value="<%=lid%>" /></td>
	   			</tr>
	   			<tr>  
					<td><input type="hidden" name="price" value="<%=price%>" /></td>
	   			</tr>
	   			<tr>  
					<td>Current Price: <%=price%></td>
	   			</tr> 
	    	</table>
    	</div>
    	
    	<hr>
    	<h3><u>Details:</u></h3>
    	<p><b>Seller: </b><%=postedby%></p>
    	<p><b>Closing Date/Time: </b><%=cdt%></p>
    	<p><b>Subcategory: </b><%=subcat%></p>
    	<p><b>Subattribute: </b><%=subattr%></p>
    	<p><b>Min. Sale Price: </b><%=minsale%></p>
    	
    	<hr>
		<div style="text-align: center">
		<h3>Bid History</h3>
		<%
			Statement stmt3 = con.createStatement();
	        ResultSet bidhist = stmt3.executeQuery("SELECT b.b_id, price, username, dtime from bids b "+
	        		"LEFT JOIN bidson bo on bo.b_id = b.b_id LEFT JOIN places p on p.b_id = bo.b_id " +
	        		"WHERE l_id= " +lid+";");
		%>
		
		<form action="repModifyListing.jsp">
			<TABLE align="center" BORDER="1">
	            <TR>
	                <TH>BidID</TH>
	                <TH>Price</TH>
	                <TH>Bidder</TH>
	                <TH>Date/Time</TH>
	            </TR>
	            <% while (bidhist.next()) { %>
	            <TR>
	            	<TD><%=bidhist.getString(1)%></TD>
	             	<TD><%=bidhist.getString(2)%></TD>
	                <TD><%=bidhist.getString(3)%></TD>
	                <TD><%=bidhist.getString(4)%></TD>
	                <td><button name="bid" type="submit" value="<%= bidhist.getString(1) %>">Remove Bid</button></td>
	            </TR>
	            <% } %>
	        </TABLE>
	        <input type="hidden" name="operation" value="removeBid"/>
	        <input type="hidden" name="lid" value="<%= lid %>"/>
        </form>
			
		<hr>
		
		<form action="repModifyListing.jsp">
			<button name="lid" type="submit" value="<%= lid %>">Remove Listing!</button>
			<input type="hidden" name="operation" value="removeListing"/>
		</form>
		<p> WARNING: Removal of a listing can not be undone!</p>
		</div>
</body>
</html>