package com.cheatsheet.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.cheatsheet.model.User;

public class AdminUserRepository {
    private Connection conn;

    public AdminUserRepository(Connection conn) {
        this.conn = conn;
    }

    // 🌟 (က) Role 'USER' ဖြစ်ပြီး အချိန်ကို AM/PM Format ပြောင်းကာ ဆွဲထုတ်ခြင်း
    public List<User> getAllNormalUsers() {
        List<User> list = new ArrayList<>();
        // DATE_FORMAT ကို သုံးပြီး Time ကို 12-hour format (e.g., 01:25 PM) ပြောင်းထားပါသည် 🌟
        String sql = "SELECT id, username, email, role, " +
                     "DATE_FORMAT(created_at, '%d-%b-%Y %h:%i %p') as formatted_date " +
                     "FROM users WHERE role = 'USER' ORDER BY id DESC";
                     
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setUsername(rs.getString("username"));
                    u.setEmail(rs.getString("email"));
                    u.setRole(rs.getString("role"));
                    // User Model ထဲက createdAt field ထဲသို့ format ပြောင်းပြီးသား စာသား ထည့်မည်
                    u.setCreatedAt(rs.getString("formatted_date"));
                    
                  
                    list.add(u);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🌟 (ခ) User အကောင့်အား ဖျက်ပစ်ရန်
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}