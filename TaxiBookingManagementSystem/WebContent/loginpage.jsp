<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import ="java.sql.SQLException"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logged in</title>
</head>
<body>
<form action="loginpage" method= "post" >


<input type="submit" value="View Personal Details" name="personal_details" >
<input type="submit" value="Delete account" name="delete">
<input type="submit" value="Book" name="book">
<input type="button" value ="Logout" onClick="window.location.href='homepage.html'">
</form>

<%

Class.forName("com.mysql.cj.jdbc.Driver");

Connection conn = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/tbms","root","mysql");
Statement stmt = conn.createStatement();   
String userid=(String)request.getSession().getAttribute("un");
ResultSet rs;

String msg="";
if(request.getParameter("personal_details") !=null)
	{   
		rs=stmt.executeQuery("select * from customer where username ='"+userid+"' ;");
		boolean v1=rs.next();
		System.out.println(v1);
		%>
		<br>Username:     <% out.println(rs.getString("username")); %>
		<br>Password:   <% out.println(rs.getString("password")); %>
		<br>Location: <% out.println(rs.getString("location")); %>
		<br>On Trip?   <% out.println(rs.getString("ontrip")); %>
		<br>Riding with: <% out.println(rs.getString("cid")); %><br><br>
				
<%
}
%>


</body>
</html>