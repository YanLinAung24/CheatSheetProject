package com.cheatsheet.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheatsheet.config.DBConnect;
import com.cheatsheet.model.Category;
import com.cheatsheet.model.CheatSheet;
import com.cheatsheet.repository.CategoryRepository;
import com.cheatsheet.repository.CheatSheetRepository;

/**
 * Servlet implementation class ViewEditServlet
 */
@WebServlet("/view-edit")
public class ViewEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewEditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = request.getParameter("mode"); // "view" သို့မဟုတ် "edit"
        int id = Integer.parseInt(request.getParameter("id"));

        CheatSheetRepository repo = new CheatSheetRepository(DBConnect.getConnection());
        CheatSheet cs = repo.getCheatById(id);
        request.setAttribute("cheat", cs);
        CategoryRepository catRepo = new CategoryRepository(DBConnect.getConnection());

        // Sidebar အတွက် Category List အမြဲယူမယ်
        List<Category> categoryList = catRepo.getAllCategory();
        request.setAttribute("categoryList", categoryList);

        if ("edit".equals(mode)) {
            request.getRequestDispatcher("edit-post.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("view-post.jsp").forward(request, response);
        }
    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        CheatSheetRepository repo = new CheatSheetRepository(DBConnect.getConnection());
        if (repo.updateCheat(id, title, content)) {
            response.sendRedirect("user-home");
        }
	}

}
