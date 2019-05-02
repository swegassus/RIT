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
<p>Hi ${message}</p>
<p> ${message1}</p>

<input type="submit" value="View Personal Details" name="personal_details" >
<input type="button" value ="Logout" onClick="window.location.href='homepage.html'">
</form>

<%

Class.forName("com.mysql.cj.jdbc.Driver");

Connection conn = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/tbms","root","mysql");
Statement stmt = conn.createStatement();   
String userid=(String)request.getSession().getAttribute("un");
ResultSet rs;
request.setAttribute("message", userid);

if(request.getParameter("personal_details") !=null)
	{   
		rs=stmt.executeQuery("select * from customer where username ='"+userid+"' ;");
		boolean v1=rs.next();
		System.out.println(v1);
		String u=rs.getString("username");//System.out.print(u);
		String l=rs.getString("location");//System.out.print(n);
		
		%>
		userid:<%=u%><br>locality: <%=l%><br>
		
<%
	     request.setAttribute("message1", "showing");
	 	//out.println
	//	request.getRequestDispatcher("registered_user.jsp").include(request, response);
		
		}%>


</body>
</html>