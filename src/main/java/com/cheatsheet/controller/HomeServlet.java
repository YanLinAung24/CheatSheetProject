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
import com.cheatsheet.repository.CategoryRepository;
import com.cheatsheet.repository.PublicCheatRepository;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = DBConnect.getConnection();
        CategoryRepository catRepo = new CategoryRepository(conn);
        PublicCheatRepository publicRepo = new PublicCheatRepository(conn);

        // Search Keyword နှင့် Category ID ကန့်သတ်ချက်များ ဖတ်ယူခြင်း
        String keyword = request.getParameter("query");
        String catIdParam = request.getParameter("catId");
        Integer catId = (catIdParam != null && !catIdParam.isEmpty()) ? Integer.parseInt(catIdParam) : null;

        // ဒေတာများ ဆွဲထုတ်ခြင်း
        List<Category> categoryList = catRepo.getAllCategory();
        List<CheatSheet> publicCheats = publicRepo.getPublicCheats(keyword, catId);

        // Request attribute သတ်မှတ်ခြင်း
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("publicCheats", publicCheats);
        request.setAttribute("searchedQuery", keyword);
        request.setAttribute("activeCatId", catId);

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}