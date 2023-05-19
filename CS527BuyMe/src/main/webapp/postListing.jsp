<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Post Listing</title>
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
    	<h1>Post a Listing</h1>
    	<form method="post" action="checkListing.jsp">
	    	<table align="center">
	    		<tr>  
					<td>Item Name: <input type="text" name="itemname" value="" maxlength="30" required/></td>
	   			</tr>
	   			<tr>  
	  				<label for="subcategory">Subcategory:</label>
	  				<select name="subcategory" id="subcategory" onchange="func()">
	    				<option value="NONE">-SELECT AN OPTION-</option>
	    				<option value="shirts">Shirts</option>
	    				<option value="shoes">Shoes</option>
	    				<option value="jackets">Jackets</option>
	  				</select>					
	   			</tr>
	   			<tr>  
					<td><label for="subattribute" id="Subattr">Subattribute:</label><input type="text" name="subattribute" value="" maxlength="30" required/></td>
	   			</tr>
	   			<tr>  
					<td>Starting Price: <input type="number" required name="price" min="0" value="0" step=".01"></td>
	   			</tr>
	   			<tr>  
					<td>Minimum Sale Price (Hidden): <input type="number" required name="minsale" min="0.01" value="0" step=".01"></td>
	   			</tr>
	   			<tr>  
					<td>Closing Date/Time: <input type="datetime-local" required name="dt"></td>
	   			</tr>
	   			<tr>
					<td><input type="submit" value="Post" style="width: 100%;"/></td>
				</tr>
	   			<tr>
	   				<td><a style="text-decoration: underline; color: white" href="account.jsp">Back</a></td>
	   			</tr>
	   			
	   			<% if (null != request.getParameter("msg")) { %>
				<tr>
					<td><p style="text-align: center; color: red"><%=request.getParameter("msg")%></p></td>
				</tr>
				<% } %>
	    	</table>
    	</form>
    </div>
    <script>
    	function func(){
    	    var idElement = document.getElementById("subcategory");
    	    var selectedValue = idElement.options[idElement.selectedIndex].text;   
    	    if(selectedValue=="Shoes"){document.getElementById("Subattr").innerHTML = "Size: ";}
    	   	else if(selectedValue=="Shirts"){document.getElementById("Subattr").innerHTML = "Sleeve: ";}
    	   	else if(selectedValue=="Jackets"){document.getElementById("Subattr").innerHTML = "Waterproof: ";}
    	   	else{document.getElementById("Subattr").innerHTML = ": ";}
    	}
    </script>
</body>
</html>