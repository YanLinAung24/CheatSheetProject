package com.cheatsheet.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheatsheet.config.DBConnect;
import com.cheatsheet.model.User;
import com.cheatsheet.repository.UserRepository;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String email = request.getParameter("email");
	        String psw = request.getParameter("password");

	        UserRepository repo = new UserRepository(DBConnect.getConnection());
	        User user = repo.login(email, psw);

	        if (user != null) {
	            HttpSession session = request.getSession();
	            session.setAttribute("userObj", user);

	            // Role အလိုက် စစ်ဆေးပြီး redirect လုပ်ခြင်း
	            if ("ADMIN".equals(user.getRole())) {
	                response.sendRedirect("admin-dash");
	            } else {
	                response.sendRedirect("user-home");
	            }
	        } else {
	            request.setAttribute("errorMsg", "Invalid Email or Password");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
	        }
	}

}
