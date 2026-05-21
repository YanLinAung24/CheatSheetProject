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
import com.cheatsheet.model.User;
import com.cheatsheet.repository.AdminUserRepository;

@WebServlet("/manage-users")
public class ManageUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User adminUser = (User) session.getAttribute("userObj");

        // 🔒 Admin Security Check
        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = DBConnect.getConnection();
        AdminUserRepository userRepo = new AdminUserRepository(conn);

        // 📝 DELETE Action ကို စစ်ဆေးခြင်း
        String action = request.getParameter("action");
        String userIdParam = request.getParameter("id");
        
        if ("delete".equals(action) && userIdParam != null) {
            int userId = Integer.parseInt(userIdParam);
            userRepo.deleteUser(userId);
            
            // ဖျက်ပြီးရင် မျက်နှာပြင်ဆီ ချက်ချင်း ပြန်မောင်းနှင်မယ်
            response.sendRedirect("manage-users");
            return;
        }

        // Normal Users List အားလုံးကို ဆွဲထုတ်ပြီး JSP ထံ ပို့ပေးခြင်း
        List<User> userList = userRepo.getAllNormalUsers();
        request.setAttribute("userList", userList);

        request.getRequestDispatcher("manage-users.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}