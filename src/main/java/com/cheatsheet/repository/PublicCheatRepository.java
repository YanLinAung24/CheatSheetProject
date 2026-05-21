package com.cheatsheet.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.cheatsheet.model.CheatSheet;

public class PublicCheatRepository {
    private Connection conn;

    public PublicCheatRepository(Connection conn) {
        this.conn = conn;
    }

    // 🌟 (က) အခြေအနေအားလုံး (Search, Category Filter, Home) ကို တစ်ခုတည်းနဲ့ ကိုင်တွယ်မည့် Dynamic Query Method
    public List<CheatSheet> getPublicCheats(String keyword, Integer catId) {
        List<CheatSheet> list = new ArrayList<>();
        
        // BASE SQL: APPROVED ဖြစ်နေတဲ့ Cheat Sheet တွေကိုပဲ ပြသခွင့်ပေးမည်
        StringBuilder sql = new StringBuilder(
            "SELECT cs.id, cs.title, cs.content, " +
            "DATE_FORMAT(cs.created_at, '%d-%b-%Y %h:%i %p') as posted_at, " +
            "DATE_FORMAT(cs.updated_at, '%d-%b-%Y %h:%i %p') as changed_at, " +
            "c.name as cname, u.username as uname " +
            "FROM cheat_sheets cs " +
            "JOIN categories c ON cs.category_id = c.id " +
            "JOIN users u ON cs.user_id = u.id " +
            "WHERE cs.status = 'APPROVED' "
        );

        // Filter ညှိခြင်း
        if (catId != null && catId > 0) {
            sql.append("AND cs.category_id = ? ");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (cs.title LIKE ? OR cs.content LIKE ?) ");
        }
        
        sql.append("ORDER BY cs.id DESC");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            
            if (catId != null && catId > 0) {
                ps.setInt(paramIndex++, catId);
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CheatSheet cs = new CheatSheet();
                    cs.setId(rs.getInt("id"));
                    cs.setTitle(rs.getString("title"));
                    cs.setContent(rs.getString("content"));
                    cs.setCreatedAt(rs.getString("posted_at"));   // 1:00 PM format 🌟
                    cs.setUpdatedAt(rs.getString("changed_at"));  // 1:00 PM format 🌟
                    cs.setCategoryName(rs.getString("cname"));
                    cs.setUserName(rs.getString("uname"));
                    list.add(cs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🌟 (ခ) View Details အတွက် Cheat Sheet ID တစ်ခုတည်းကို သီးသန့်ဆွဲထုတ်ခြင်း
    public CheatSheet getCheatById(int id) {
        String sql = "SELECT cs.id, cs.title, cs.content, " +
                     "DATE_FORMAT(cs.created_at, '%d-%b-%Y %h:%i %p') as posted_at, " +
                     "DATE_FORMAT(cs.updated_at, '%d-%b-%Y %h:%i %p') as changed_at, " +
                     "c.name as cname, u.username as uname " +
                     "FROM cheat_sheets cs " +
                     "JOIN categories c ON cs.category_id = c.id " +
                     "JOIN users u ON cs.user_id = u.id " +
                     "WHERE cs.id = ? AND cs.status = 'APPROVED'";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CheatSheet cs = new CheatSheet();
                    cs.setId(rs.getInt("id"));
                    cs.setTitle(rs.getString("title"));
                    cs.setContent(rs.getString("content"));
                    cs.setCreatedAt(rs.getString("posted_at"));
                    cs.setUpdatedAt(rs.getString("changed_at"));
                    cs.setCategoryName(rs.getString("cname"));
                    cs.setUserName(rs.getString("uname"));
                    return cs;
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}