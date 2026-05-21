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
import com.cheatsheet.model.CheatSheet;
import com.cheatsheet.model.User;

import com.cheatsheet.repository.AdminRepository;
import com.cheatsheet.repository.AdminCheatRepository; // 🌟 ရှေ့က တည်ဆောက်ခဲ့သော Repo

@WebServlet("/admin-dash")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User adminUser = (User) session.getAttribute("userObj");

        // 🔒 Security Check
        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = DBConnect.getConnection();
        AdminRepository dashRepo = new AdminRepository(conn);
        AdminCheatRepository cheatRepo = new AdminCheatRepository(conn);

        // 🌟 [ထပ်တိုးအကွက်] Table ထဲက Ban သို့မဟုတ် Delete Action ဝင်လာခဲ့လျှင် ကိုင်တွယ်ခြင်း
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if (idParam != null && action != null) {
            int cheatId = Integer.parseInt(idParam);
            if ("ban".equals(action)) {
                // Status ကို BANNED သို့ ပြောင်းလဲပစ်မည်
                cheatRepo.updateCheatStatus(cheatId, "BANNED");
            } else if ("delete".equals(action)) {
                // တကယ်လို့ ဖျက်ချင်တယ်ဆိုရင် (ဒီနေရာမှာ မင်းရဲ့ delete logic ကို ထည့်ပါ)
                // cheatRepo.deleteCheat(cheatId); 
            }
            // အလုပ်ပြီးရင် Dashboard Overview ဆီ ဒေတာအသစ်နဲ့ ပြန်မောင်းနှင်မည်
            response.sendRedirect("admin-dash");
            return;
        }

        // 📊 Dashboard Counter များအားလုံးကို ဆွဲထုတ်ခြင်း
        int totalCheats = dashRepo.getTotalCheatsCount();
        int activeUsers = dashRepo.getActiveUsersCount();
        int bannedCheats = dashRepo.getBannedCheatsCount();
        List<CheatSheet> recentCheats = dashRepo.getRecentCheatSheets(5); // လတ်တလော ၅ ခု

        // 🎯 JSP ဆီသို့ သတ်မှတ်ချက် Attribute များ ပေးပို့ခြင်း
        request.setAttribute("totalCheats", totalCheats);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("bannedCheats", bannedCheats);
        request.setAttribute("cheatList", recentCheats);

        // admin-dash.jsp ဆီသို့ Forward လှည့်ပေးခြင်း
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}