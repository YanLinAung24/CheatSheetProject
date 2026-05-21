package com.cheatsheet.controller;

import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheatsheet.config.DBConnect;
import com.cheatsheet.model.CheatSheet;
import com.cheatsheet.repository.PublicCheatRepository;

@WebServlet("/view-cheat")
public class ViewCheatServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        Connection conn = DBConnect.getConnection();
        PublicCheatRepository publicRepo = new PublicCheatRepository(conn);
        
        int cheatId = Integer.parseInt(idParam);
        CheatSheet cheat = publicRepo.getCheatById(cheatId);

        if (cheat == null) {
            response.sendRedirect("home");
            return;
        }

        request.setAttribute("cheat", cheat);
        request.getRequestDispatcher("view-cheat.jsp").forward(request, response);
    }
}