package com.cheatsheet.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheatsheet.config.DBConnect;
import com.cheatsheet.model.Category;
import com.cheatsheet.model.CheatSheet;
import com.cheatsheet.model.User;
import com.cheatsheet.repository.AdminCheatRepository;
import com.cheatsheet.repository.CategoryRepository;

@WebServlet("/manage-cheats")
public class ManageCheatsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userObj");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = DBConnect.getConnection();
        CategoryRepository catRepo = new CategoryRepository(conn);
        AdminCheatRepository adminCheatRepo = new AdminCheatRepository(conn);

        // 📝 Status Action ကို စစ်ဆေးခြင်း (Ban သို့မဟုတ် Approve)
        String action = request.getParameter("action");
        String cheatIdParam = request.getParameter("id");
        String currentCatId = request.getParameter("catId");

        if (cheatIdParam != null && action != null) {
            int cheatId = Integer.parseInt(cheatIdParam);
            
            if ("ban".equals(action)) {
                adminCheatRepo.updateCheatStatus(cheatId, "BANNED");
            } else if ("approve".equals(action)) {
                adminCheatRepo.updateCheatStatus(cheatId, "APPROVED"); // 🌟 Banned ဘဝကနေ ပြန်ကယ်တင်မည့်အကွက်
            }
            
            response.sendRedirect("manage-cheats?catId=" + currentCatId);
            return;
        }

        // Sidebar Categories List
        List<Category> categoryList = catRepo.getAllCategory();
        request.setAttribute("categoryList", categoryList);

        // Category ရွေးထားလျှင် ဒေတာဆွဲထုတ်မည်
        String catIdParam = request.getParameter("catId");
        if (catIdParam != null && !catIdParam.isEmpty()) {
            int catId = Integer.parseInt(catIdParam);
            
            // 🌟 ပြောင်းလဲထားသော Method အသစ်ဖြင့် စာရင်းအားလုံး ဆွဲထုတ်ခြင်း
            List<CheatSheet> cheatList = adminCheatRepo.getAllCheatsByCategory(catId);
            request.setAttribute("cheatList", cheatList);
            request.setAttribute("selectedCatId", catId);
            
            Category selectedCategory = catRepo.getCategoryById(catId);
            request.setAttribute("selectedCategory", selectedCategory);
        }

        request.getRequestDispatcher("manage-cheats.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}