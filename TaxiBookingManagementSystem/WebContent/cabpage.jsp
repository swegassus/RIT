<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import ="java.sql.SQLException"%>
<%@page import ="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logged in</title>
</head>
<body>
<form action="booking" method= "post" >


<input type="submit" value="View cab details that are available" name="cab_details" >
<input type="submit" value="Book regular" name="regular" >
<input type="submit" value="Book mini" name="mini" >
<input type="button" value ="Back" onClick="window.location.href='loginpage.jsp'">
</form>

<% 

Class.forName("com.mysql.cj.jdbc.Driver");
PrintWriter ps = response.getWriter();

Connection conn = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/tbms","root","mysql");
Statement stmt = conn.createStatement();   
String userid=(String)request.getSession().getAttribute("un");
ResultSet rs,rs2;

String msg="";
if(request.getParameter("cab_details") !=null)
	{
		rs=stmt.executeQuery("select * from cabs where ontrip='false' ;");
		///boolean v1=rs.next();
		//System.out.println(v1);
		%>
		<h1>CAR DETAILS</h1>
		<% 
		while(rs.next())
		{ %>
			<br>Type:     <% out.println(rs.getString("type")); %>
			<br>Cab ID:   <% out.println(rs.getString("cid")); %>
			<br>Location: <% out.println(rs.getString("location")); %>
			<br>On Trip?   <% out.println(rs.getString("ontrip")); %><br><br>
		<%}
	}

if(request.getParameter("regular") !=null)
{
	rs2=stmt.executeQuery("select * from customer where username='"+userid+"' ;");

	rs2.next();
	String r2=rs2.getString("location");
	rs=stmt.executeQuery("select * from cabs where ontrip='false' and type='regular' and location='"+r2+"';");
	boolean v1=rs.next();
    System.out.println(v1);
    if(v1)
    {
    	String cid=rs.getString("cid");
    	stmt.executeUpdate("update cabs set ontrip = 'true' ,userid='" + userid +"' where cid='"+cid+"' ;");
    	stmt.executeUpdate("update customer set ontrip = 'true' ,cid='" + cid +"' where username='"+userid+"' ;");
    	ps.println("Cab booked with ID-"+cid);
    	RequestDispatcher red=request.getRequestDispatcher("loginpage.jsp");
        red.forward(request, response);
    }
    else
    {
    	ps.println("Regular not available at your location.");
    }
	}
if(request.getParameter("mini") !=null)
{
	rs2=stmt.executeQuery("select * from customer where username='"+userid+"' ;");

	rs2.next();
	String r2=rs2.getString("location");
	rs=stmt.executeQuery("select * from cabs where ontrip='false' and type='mini' and location='"+r2+"';");
	boolean v1=rs.next();
    System.out.println(v1);
    if(v1)
    {
    	String cid=rs.getString("cid");
    	stmt.executeUpdate("update cabs set ontrip = 'true' ,userid='" + userid +"' where cid='"+cid+"' ;");
    	stmt.executeUpdate("update customer set ontrip = 'true' ,cid='" + cid +"' where username='"+userid+"' ;");
    	ps.println("Cab booked with ID-"+cid);
    	RequestDispatcher red=request.getRequestDispatcher("loginpage.jsp");
        red.forward(request, response);
    }
    else
    {
    	ps.println("Mini not available at your location.");
    }
	}
%>


</body>
</html>