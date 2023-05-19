<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Jackets</title>
</head>
<body style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; background-size: cover">

	<% 
    	//Database Connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String username = (String) session.getAttribute("username");
		if (null == username) {
			response.sendRedirect("login.jsp");
		}
		
	%>

    <div style="text-align: center; color=white">
    	<h1>Jackets</h1>
    	<a href="account.jsp">Options</a><br>
        		<a href="home.jsp">Home</a><br><br>
	    
	    <div class="container">
  <form class="form-inline" method="post" action="search.jsp?subcat=jackets">
    <input type="text" name="search" class="form-control" placeholder="Search goes here...">
    <button type="submit" name="save" class="btn btn-primary">Search</button>
  </form>
  
  
      	<br>
  
	<form class="form-inline" method="post" action="jackets.jsp">
		<select name="sortby" id="sortby">
			<option value="None">---</option>
	    	<option value="Name">Name</option>
	    	<option value="lowToHigh">Price (Ascending)</option>
	    	<option value="highToLow">Price (Descending)</option>
	    	<option value="Tag">Waterproof</option>
	    	<option value="Open">Status: Open</option>
	    	<option value="Closed">Status: Closed</option>
		</select>	
    <button type="submit" name="sortBy" >Sort By</button>
  </form>
</div>
    	    	
    	 <% 
			Statement stmt = con.createStatement();
    	 	String sortParam = request.getParameter("sortby");
    	 	ResultSet resultset = null;
    	 	if(null == sortParam){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='jackets';");
    	 	}else if(sortParam.equals("Name")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='jackets' ORDER BY itemname;");
    	 	}else if(sortParam.equals("lowToHigh")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='jackets' ORDER BY price;");
    	 	}else if(sortParam.equals("highToLow")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='jackets' ORDER BY price DESC;");
    	 	}else if(sortParam.equals("Tag")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='jackets' ORDER BY CAST(subattribute as SIGNED INTEGER);");
    	 	}else if(sortParam.equals("Open")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='jackets' AND closed='0' ORDER BY itemname;");
    	 	}else if(sortParam.equals("Closed")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='jackets' AND closed='1' ORDER BY itemname;");
    	 	}else{
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='jackets';");
    	 	}
             
       	 %>
    	<br><br>
    	<form method="post" action="viewListing.jsp">

            <% while (resultset.next()) { 
            	String status = resultset.getString(8);
            %>
				<div style="border:1px solid black">
				<br>
				<button name="lid" type="submit" value="<%= resultset.getString(1) %>">Details</button><br>
           		Name: <%=resultset.getString(2)%><br>
                Waterproof: <%= resultset.getString(4) %><br>
                Price: <%= resultset.getString(5) %><br>
                <%if ("0".equals(status)) {
                	%>
                	Status: Open<br><br>
                	<%
                }else{
                	%>
            		Status: Closed<br><br>
            		<%
                } %>
               </div>
            <% } %>
 
    	</form>
    	<a href="logout.jsp">Logout</a><br><br>
    
    </div>
</body>
</html>