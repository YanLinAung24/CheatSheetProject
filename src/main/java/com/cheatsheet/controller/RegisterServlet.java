package com.cheatsheet.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import com.cheatsheet.config.DBConnect;
import com.cheatsheet.model.User;
import com.cheatsheet.repository.UserRepository;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("register.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String name = request.getParameter("username");
        String email = request.getParameter("email");
        String psw = request.getParameter("password");

        // 1. Validation Logic
        if (psw == null || psw.length() < 6 || !psw.matches(".*[a-zA-Z].*")) {
            request.setAttribute("errorMsg", "Password must be at least 6 characters and contain letters!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 2. Password Hashing
        String hashedPassword = BCrypt.hashpw(psw, BCrypt.gensalt());

        User user = new User();
        user.setUsername(name);
        user.setEmail(email);
        user.setPassword(hashedPassword);

        UserRepository repo = new UserRepository(DBConnect.getConnection());
        if (repo.registerUser(user)) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("errorMsg", "Registration Failed! Try Again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
	}

}
