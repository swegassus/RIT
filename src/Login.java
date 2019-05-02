import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;
@WebServlet("/Login")
public class Login extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public Login() {
        super();
        // TODO Auto-generated constructor stub
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
         response.setContentType("text/html");
            PrintWriter ps = response.getWriter();
            String un = request.getParameter("Username");
            String pswd = request.getParameter("pass");
            HttpSession session=request.getSession(true);
            try
            {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/tbms","root","mysql");
                Statement stmt = conn.createStatement();    
                String query1 = "select * from customer where username ='"+un+"' and password = '"+pswd+"';";
                ResultSet rs= stmt.executeQuery(query1);
                boolean v1=rs.next();
                System.out.println(v1);
                if(v1)
                {
                	session.setAttribute("un", un);
                	request.setAttribute("message",un );
                    RequestDispatcher red=request.getRequestDispatcher("loginpage.jsp");
                    red.forward(request, response);
                }
                else
                {
                    ps.println("User does not exist. Please register.");
                    RequestDispatcher red=request.getRequestDispatcher("askregister.html");
                    red.include(request, response);
                }
        
    }catch (Exception e)
        {
        e.printStackTrace();
        }
     ps.close();       
    }
	
	
	
	
}
