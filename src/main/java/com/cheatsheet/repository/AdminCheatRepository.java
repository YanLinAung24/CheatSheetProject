package com.cheatsheet.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.cheatsheet.model.CheatSheet;

public class AdminCheatRepository {
    private Connection conn;

    public AdminCheatRepository(Connection conn) {
        this.conn = conn;
    }

    // 🌟 (က) Status က ဘာပဲဖြစ်ဖြစ် (Approved ရော Banned ရော) Category အလိုက် အကုန်ဆွဲထုတ်မည်
    public List<CheatSheet> getAllCheatsByCategory(int catId) {
        List<CheatSheet> list = new ArrayList<>();
        String sql = "SELECT cs.*, c.name as cname, u.username as uname FROM cheat_sheets cs " +
                     "JOIN categories c ON cs.category_id = c.id " +
                     "JOIN users u ON cs.user_id = u.id " +
                     "WHERE cs.category_id = ? " + // ❌ Status Check row ကို ဖြုတ်ချလိုက်ပါပြီ
                     "ORDER BY cs.id DESC";
                     
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, catId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CheatSheet cs = new CheatSheet();
                    cs.setId(rs.getInt("id"));
                    cs.setTitle(rs.getString("title"));
                    cs.setContent(rs.getString("content"));
                    cs.setCreatedAt(rs.getString("created_at"));
                    cs.setUpdatedAt(rs.getString("updated_at"));
                    cs.setCategoryName(rs.getString("cname"));
                    cs.setUserName(rs.getString("uname"));
                    cs.setStatus(rs.getString("status")); // APPROVED သို့မဟုတ် BANNED
                    list.add(cs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🌟 (ခ) Status ကို ပြောင်းလဲပေးမည့် အထွေထွေ Method (Ban ရော Approved ပါ တစ်ခုတည်းနဲ့ လုပ်နိုင်သည်)
    public boolean updateCheatStatus(int id, String status) {
        String sql = "UPDATE cheat_sheets SET status = ?, updated_at = NOW() WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}