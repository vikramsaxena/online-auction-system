<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin and Cust Rep Login</title>
</head>
<body style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; color: white; background-size: cover">
	<h2 style="text-align: center; color: white">BuyMe <br> Admin and Customer Rep Login</h2>
	<form method="post" action="checkEmployeeLoginDetails.jsp">
		<div style="text-align: center; color: white">	
			Emp ID: <input type="text" name="employee_id" value="" required/>
			
			Password: <input type="password" name="password" value="" required/>
			
			<input type="submit" value="Log in"/>
				
		<% if (null != request.getParameter("registerRet")) { %>
			<p style="text-align: center; color: white"><%=request.getParameter("registerRet")%></p>
		<% } else if (null != request.getParameter("loginRet")) { %>
			<p style="text-align: center; color: white"><%=request.getParameter("loginRet")%></p>
		<% } %>
		</div>
	<p style="text-align:center">Not an Admin or Cust Rep? <a style="text-decoration: underline; color: white" href="login.jsp">Login Here!</a></p>
	</form>
</body>
</html>