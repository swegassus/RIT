import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/RegisterCust")
public class RegisterCust extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public RegisterCust() {
        super();
        // TODO Auto-generated constructor stub
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
         response.setContentType("text/html");
            PrintWriter ps = response.getWriter();
            //ps.println("Hello World");
            String loc= request.getParameter("newlocation");
            String un = request.getParameter("newusername");
            String pswd = request.getParameter("newpassword");
            try
            {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/tbms","root","mysql");
                Statement stmt = conn.createStatement();    
                
                String query1 = "select * from customer where username ='"+un+"' and password = '"+pswd+"'and location = '"+loc+"';";
                ResultSet rs= stmt.executeQuery(query1);
                boolean v1=rs.next();
                System.out.println(v1);
                if(v1)
                {
                    ps.println("User already exists please login.");
                    RequestDispatcher red=request.getRequestDispatcher("homepage.html");
                    red.include(request, response);
                }
                else
                {
                	String query2 = "insert into customer(username,password,location) values('" + un + "','"+pswd+"','"+loc+"');";
        			stmt.executeUpdate(query2);
        			ps.println("Resgistration Successful. You can login now");
                    RequestDispatcher red=request.getRequestDispatcher("homepage.html");
                    red.include(request, response);
                }
                
                
    }catch (Exception e)
        {
        e.printStackTrace();
        }
     ps.close();       
    }
	
}
