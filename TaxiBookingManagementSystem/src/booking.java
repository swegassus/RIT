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
@WebServlet("/booking")

public class booking extends HttpServlet{

	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter ps = response.getWriter();
		if(request.getParameter("cab_details" )!= null) {
		request.getRequestDispatcher("cabpage.jsp").forward(request, response);}
		if(request.getParameter("regular" )!= null) {
			request.getRequestDispatcher("cabpage.jsp").forward(request, response);}
		if(request.getParameter("mini" )!= null) {
			request.getRequestDispatcher("cabpage.jsp").forward(request, response);}
	}}