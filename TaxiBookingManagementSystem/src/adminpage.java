import java.io.*;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;
@WebServlet("/adminpage")

public class adminpage extends HttpServlet{

	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter ps = response.getWriter();
		if(request.getParameter("unbook" )!= null) {
		request.getRequestDispatcher("adminpage.jsp").forward(request, response);}
		if(request.getParameter("cabs" )!= null) {
			request.getRequestDispatcher("adminpage.jsp").forward(request, response);}
		if(request.getParameter("details" )!= null) {
			request.getRequestDispatcher("adminpage.jsp").forward(request, response);}
	}}