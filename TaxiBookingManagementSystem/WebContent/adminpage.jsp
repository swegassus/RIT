<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import ="java.sql.SQLException"%>
<%@page import ="java.io.*"%>


<meta charset="ISO-8859-1">
<title>Logged in</title>
</head>
<body>
<form action="adminpage" method= "post" >

Select user to end trip: <input type="text" name="enduser">
<input type="submit" value="View all customer details" name="details" >
<input type="submit" value="View all cab details" name="cabs">
<input type="submit" value="End Trip" name="unbook">
<input type="button" value ="Logout" onClick="window.location.href='homepage.html'">
</form>

<%

Class.forName("com.mysql.cj.jdbc.Driver");

Connection conn = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/tbms","root","mysql");
Statement stmt = conn.createStatement();   
String userid=(String)request.getSession().getAttribute("un");
ResultSet rs;

String msg="";
if(request.getParameter("details") !=null)
	{   
		rs=stmt.executeQuery("select * from customer;");
		while(rs.next()){
		%>
		<br>Username:     <% out.println(rs.getString("username")); %>
		<br>Password:   <% out.println(rs.getString("password")); %>
		<br>Location: <% out.println(rs.getString("location")); %>
		<br>On Trip?   <% out.println(rs.getString("ontrip")); %>
		<br>Riding with: <% out.println(rs.getString("cid")); %><br><br>
				
<%
}}

if(request.getParameter("unbook") !=null)
{
    PrintWriter ps = response.getWriter();
	String endid=request.getParameter("enduser");
	String flag = "true";
	String query1 = "select * from customer where username ='"+endid+"'and ontrip='"+flag+"';";
    rs= stmt.executeQuery(query1);
    boolean v1=rs.next();
    System.out.println(v1);
    if(v1)
    {
        flag="false";
		stmt.executeUpdate("update customer set ontrip = '"+flag+"' ,cid='NULL' where username='" +endid+ "';");
		stmt.executeUpdate("update cabs set ontrip = '"+flag+"' ,userid='NULL' where userid='" +endid+ "';");
		ps.println("Booking has ended.");
     }
     else
     {
    	 ps.println("That user is not on trip");
     }
	}

if(request.getParameter("cabs") !=null)
{   
	rs=stmt.executeQuery("select * from cabs;");
	while(rs.next()){
	%>
	<br>Type:     <% out.println(rs.getString("type")); %>
	<br>Cab ID:   <% out.println(rs.getString("cid")); %>
	<br>Location: <% out.println(rs.getString("location")); %>
	<br>On Trip?   <% out.println(rs.getString("ontrip")); %>
	<br>Riding with: <% out.println(rs.getString("userid")); %><br><br>
			
<%
}}
%>


</body>
</html>