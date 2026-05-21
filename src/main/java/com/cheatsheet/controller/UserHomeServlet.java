package com.cheatsheet.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheatsheet.config.DBConnect;
import com.cheatsheet.model.Category;
import com.cheatsheet.model.CheatSheet;
import com.cheatsheet.model.User;
import com.cheatsheet.repository.CategoryRepository;
import com.cheatsheet.repository.CheatSheetRepository;
import com.cheatsheet.repository.UserBookmarkRepository;

@WebServlet("/user-home")
public class UserHomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public UserHomeServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("userObj");
        if (user == null) { response.sendRedirect("login.jsp"); return; }

        Connection conn = DBConnect.getConnection();
        CheatSheetRepository repo = new CheatSheetRepository(conn);
        CategoryRepository catRepo = new CategoryRepository(conn);
        UserBookmarkRepository bookmarkRepo = new UserBookmarkRepository(conn);
       
        // Sidebar အတွက် Category List အမြဲယူမယ်
        List<Category> categoryList = catRepo.getAllCategory();
        request.setAttribute("categoryList", categoryList);

        String view = request.getParameter("view"); 
        
        if ("explore".equals(view)) {
            request.setAttribute("activeTab", "explore");
                
        } else if ("category".equals(view)) {
            int catId = Integer.parseInt(request.getParameter("catId"));
            List<CheatSheet> catCheats = repo.getCheatsByCategory(catId);
            
            // 🌟 Category View ထဲက ကတ်ပြားတွေမှာလည်း Bookmark မီးလင်းအောင် status စစ်ထည့်ပေးမယ်
            for(CheatSheet cs : catCheats) {
                cs.setBookmarked(bookmarkRepo.isBookmarked(user.getId(), cs.getId()));
            }
            
            request.setAttribute("userCheats", catCheats);
            request.setAttribute("activeTab", "category");
            
            for(Category c : categoryList) {
                if(c.getId() == catId) { request.setAttribute("selectedCatName", c.getName()); break; }
            }
            
        } else if ("bookmarks".equals(view)) {
            // 🌟 Sidebar က Bookmarks ကိုနှိပ်ရင် ကျလာမယ့် အပိုင်း
            request.setAttribute("userCheats", bookmarkRepo.getBookmarkedCheats(user.getId()));
            request.setAttribute("activeTab", "bookmarks");
            
        } else {
            // Default: "My Cheatsheets" ကိုယ်ပိုင်တင်ထားတာပြမည့်အပိုင်း
            List<CheatSheet> myCheats = repo.getCheatsByUser(user.getId());
            
            // 🌟 My Vault ကတ်ပြားတွေမှာ Bookmark မီးလင်းအောင် status စစ်ထည့်ပေးမယ်
            for(CheatSheet cs : myCheats) {
                cs.setBookmarked(bookmarkRepo.isBookmarked(user.getId(), cs.getId()));
            }
            
            request.setAttribute("userCheats", myCheats);
            request.setAttribute("activeTab", "my");
        }

        request.getRequestDispatcher("user-home.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}