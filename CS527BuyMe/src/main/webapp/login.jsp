<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
</head>

<body style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; background-size: cover; text-decoration: none; color: white">

	<h2 style="text-align: center; color: white">BuyMe <br> Login</h2>
	
	<form method="post" action="checkLoginDetails.jsp">
	
			<div style="text-align: center; color: white">		
				Username: <input type="text" name="username" value="" required/>
				Password: <input type="password" name="password" value="" required/>
				<input type="submit" value="Log in"/>
			</div>
			<p style="text-align: center; text-decoration: none; color: white">Don't have an account? <a style="text-decoration: underline; color: white" href="userRegistration.jsp">Register</a> <br>
			For Admin or Customer Rep Login - <a style="text-decoration: underline; color: white" href="adminCustRepLogin.jsp">Click here</a> </p>

		<% if (null != request.getParameter("registerRet")) { %>
				<div><p style="text-align: center; color: white"><%=request.getParameter("registerRet")%></p></div>
		<% } else if (null != request.getParameter("loginRet")) { %>
				<div><p style="text-align: center; color: white"><%=request.getParameter("loginRet")%></p></div>
		<% } %>
	</form>
</body>
</html>