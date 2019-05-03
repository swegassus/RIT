import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;
@WebServlet("/loginpage")

public class loginpage extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter ps = response.getWriter();
		
		if(request.getParameter("personal_details" )!= null) {
		request.getRequestDispatcher("loginpage.jsp").forward(request, response);}
		try{Class.forName("com.mysql.cj.jdbc.Driver");

			Connection conn = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/tbms","root","mysql");
			Statement stmt = conn.createStatement();   
			String userid=(String)request.getSession().getAttribute("un");
			ResultSet rs;
			if(request.getParameter("delete" )!= null) {
				stmt.executeUpdate("delete from customer where username='" +userid+ "';");
				request.getRequestDispatcher("homepage.html").forward(request, response);
			}
		

			if(request.getParameter("book" )!= null) {  
				String flag = "false";
				String query1 = "select * from customer where username ='"+userid+"'and ontrip='"+flag+"';";
	            rs= stmt.executeQuery(query1);
	            boolean v1=rs.next();
	            System.out.println(v1);
	            if(v1)
	            {
	                //flag="true";
	    			//stmt.executeUpdate("update customer set ontrip = '"+flag+"' where username='" +userid+ "';");
	    			//ps.println("Your cab is booked. You are now on trip");
	                RequestDispatcher red=request.getRequestDispatcher("cabpage.jsp");
	                red.include(request, response);
	             }
	             else
	             {
	            	 ps.println("Already on trip");
	                 RequestDispatcher red=request.getRequestDispatcher("loginpage.jsp");
	                 red.include(request, response);
	             }
				}
			
			if(request.getParameter("unbook" )!= null) {  
				String flag = "true";
				String query1 = "select * from customer where username ='"+userid+"'and ontrip='"+flag+"';";
	            rs= stmt.executeQuery(query1);
	            boolean v1=rs.next();
	            System.out.println(v1);
	            if(v1)
	            {
	                flag="false";
	    			stmt.executeUpdate("update customer set ontrip = '"+flag+"' ,cid='NULL' where username='" +userid+ "';");
	    			stmt.executeUpdate("update cabs set ontrip = '"+flag+"' ,userid='NULL' where userid='" +userid+ "';");
	    			ps.println("Your booking has ended. Thank you for riding with us.");
	                RequestDispatcher red=request.getRequestDispatcher("loginpage.jsp");
	                red.include(request, response);
	             }
	             else
	             {
	            	 ps.println("Not on trip");
	                 RequestDispatcher red=request.getRequestDispatcher("loginpage.jsp");
	                 red.include(request, response);
	             }
				}
			}catch(Exception e)
			{
				e.printStackTrace();
			}
	}

}
