package com.cheatsheet.controller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheatsheet.config.DBConnect;
import com.cheatsheet.model.User;
import com.cheatsheet.repository.UserBookmarkRepository;

/**
 * Servlet implementation class BookmarkServlet
 */
@WebServlet("/toggle-bookmark")
public class BookmarkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookmarkServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userObj");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int cheatsheetId = Integer.parseInt(request.getParameter("id"));
        Connection conn = DBConnect.getConnection();
        UserBookmarkRepository bookmarkRepo = new UserBookmarkRepository(conn);
        
        // Toggle လုပ်မယ်
        bookmarkRepo.toggleBookmark(user.getId(), cheatsheetId);
        
        // 🌟 နှိပ်လိုက်တဲ့နေရာကနေ မထွက်ဘဲ မူလစာမျက်နှာဆီ ပြန်လွှတ်ပေးမယ်
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : "user-home");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
