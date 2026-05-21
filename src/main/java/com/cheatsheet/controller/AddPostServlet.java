package com.cheatsheet.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheatsheet.config.DBConnect;
import com.cheatsheet.model.CheatSheet;
import com.cheatsheet.model.User;
import com.cheatsheet.repository.CategoryRepository;
import com.cheatsheet.repository.CheatSheetRepository;

/**
 * Servlet implementation class AddPostServlet
 */
@WebServlet("/add-post")
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("userObj");
        if (user == null) { response.sendRedirect("login.jsp"); return; }

        CategoryRepository catRepo = new CategoryRepository(DBConnect.getConnection());
        request.setAttribute("allCats", catRepo.getAllCategory());
        request.getRequestDispatcher("add-post.jsp").forward(request, response);
    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("userObj");
        if (user == null) { response.sendRedirect("login.jsp"); return; }

        String scatId = request.getParameter("categoryId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        if (scatId != null && !scatId.isEmpty()) {
            int catId = Integer.parseInt(scatId);
            CheatSheet cs = new CheatSheet();
            cs.setTitle(title);
            cs.setContent(content);

            CheatSheetRepository repo = new CheatSheetRepository(DBConnect.getConnection());
            if (repo.saveCheat(cs, user.getId(), catId)) {
                response.sendRedirect("user-home"); // အောင်မြင်ရင် Home ပြန်လွှတ်မယ်
            }
        }
	}

}
