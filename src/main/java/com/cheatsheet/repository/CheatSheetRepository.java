package com.cheatsheet.repository;

import com.cheatsheet.model.CheatSheet;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class CheatSheetRepository {
    private Connection conn;
    public CheatSheetRepository(Connection conn) { this.conn = conn; }

    // အချိန်ကို 12-hour AM/PM ပုံစံပြောင်းပေးတဲ့ Helper Method (Second မပါတော့ပါ)
    private String formatTime(Timestamp timestamp) {
        if (timestamp == null) return null;
        LocalDateTime ldt = timestamp.toLocalDateTime();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm a");
        return ldt.format(formatter);
    }

    // 1. View All for Dashboard
    public List<CheatSheet> getCheatsByUser(int userId) {
        List<CheatSheet> list = new ArrayList<>();
        String sql = "SELECT cs.*, c.name as cname FROM cheat_sheets cs " +
                     "JOIN categories c ON cs.category_id = c.id " +
                     "WHERE cs.user_id=? ORDER BY cs.id DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                CheatSheet cs = new CheatSheet();
                cs.setId(rs.getInt("id"));
                cs.setTitle(rs.getString("title"));
                cs.setContent(rs.getString("content"));
                cs.setCategoryName(rs.getString("cname"));
                
                // အချိန်တွေကို Format ပြောင်းပြီး ထည့်မယ်
                cs.setCreatedAt(formatTime(rs.getTimestamp("created_at")));
                cs.setUpdatedAt(formatTime(rs.getTimestamp("updated_at")));
                
                list.add(cs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 2. View Single by ID
    public CheatSheet getCheatById(int id) {
        CheatSheet cs = null;
        String sql = "SELECT cs.*, c.name as cname FROM cheat_sheets cs " +
                     "JOIN categories c ON cs.category_id = c.id WHERE cs.id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                cs = new CheatSheet();
                cs.setId(rs.getInt("id"));
                cs.setTitle(rs.getString("title"));
                cs.setContent(rs.getString("content"));
             
                cs.setCategoryName(rs.getString("cname"));
                
                cs.setCreatedAt(formatTime(rs.getTimestamp("created_at")));
                cs.setUpdatedAt(formatTime(rs.getTimestamp("updated_at")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return cs;
    }

    // 3. Add Post
    public boolean saveCheat(CheatSheet cs, int userId, int catId) {
        try {
            String sql = "INSERT INTO cheat_sheets (title, content, category_id, user_id) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cs.getTitle());
            ps.setString(2, cs.getContent());
            ps.setInt(3, catId);
            ps.setInt(4, userId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 4. Update
    public boolean updateCheat(int id, String title, String content) {
        try {
            String sql = "UPDATE cheat_sheets SET title=?, content=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setInt(3, id);
            return ps.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 5. Delete
    public boolean deleteCheat(int id) {
        try {
            String sql = "DELETE FROM cheat_sheets WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id); // မင်းရဲ့ code မှာ parameter index ပြန်စစ်ပါ၊ ၁ ခုပဲရှိလို့ ၁ ဖြစ်ရပါမယ်
            return ps.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
    
    public List<CheatSheet> getCheatsByCategory(int catId) {
        List<CheatSheet> list = new ArrayList<>();
        String sql = "SELECT cs.*, c.name as cname, u.username as uname FROM cheat_sheets cs " +
                "JOIN categories c ON cs.category_id = c.id " +
                "JOIN users u ON cs.user_id = u.id " +
                "WHERE cs.category_id = ? ORDER BY cs.id DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, catId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                CheatSheet cs = new CheatSheet();
                cs.setId(rs.getInt("id"));
                cs.setTitle(rs.getString("title"));
                cs.setContent(rs.getString("content"));
                cs.setCategoryName(rs.getString("cname"));
                cs.setUserName(rs.getString("uname"));
                cs.setCreatedAt(formatTime(rs.getTimestamp("created_at")));
                cs.setUpdatedAt(formatTime(rs.getTimestamp("updated_at")));
                list.add(cs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}