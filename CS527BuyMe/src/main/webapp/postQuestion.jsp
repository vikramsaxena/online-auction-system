<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Ask a Question</title>
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
    	<h1>Ask a Question</h1>
    	<form method="post" action="checkQuestion.jsp">
	    	<table align="center">
	    		<tr>  
					<td>
  						<textarea id="question" name="question" rows="4" placeholder="Enter your question" cols="50"></textarea>
  					</td>
	   			</tr>
	   			<tr>
	   				<td><input type="submit" value="Post" style="width: 50%;"/></td>
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
    	    if(selectedValue=="shoes"){document.getElementById("Subattr").innerHTML = "Size: ";}
    	   	else if(selectedValue=="shirts"){document.getElementById("Subattr").innerHTML = "Sleeve: ";}
    	   	else{document.getElementById("Subattr").innerHTML = "Waterproof: ";}
    	}
    </script>
</body>
</html>