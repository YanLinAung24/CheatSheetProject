package com.cheatsheet.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.cheatsheet.model.CheatSheet;

public class UserBookmarkRepository {
    private Connection conn;

    public UserBookmarkRepository(Connection conn) {
        this.conn = conn;
    }

    // 🌟 [TOGGLE LOGIC] ရှိရင် Delete လုပ်မယ်၊ မရှိရင် Insert လုပ်မယ်
    public boolean toggleBookmark(int userId, int cheatsheetId) {
        String checkSql = "SELECT * FROM user_bookmarks WHERE user_id = ? AND cheatsheet_id = ?";
        try {
            try (PreparedStatement ps = conn.prepareStatement(checkSql)) {
                ps.setInt(1, userId);
                ps.setInt(2, cheatsheetId);
                ResultSet rs = ps.executeQuery();
                
                if (rs.next()) {
                    // [DELETE] အကွက်: ရှိပြီးသားမို့လို့ ပြန်ဖြုတ်မယ်
                    String deleteSql = "DELETE FROM user_bookmarks WHERE user_id = ? AND cheatsheet_id = ?";
                    try (PreparedStatement dps = conn.prepareStatement(deleteSql)) {
                        dps.setInt(1, userId);
                        dps.setInt(2, cheatsheetId);
                        dps.executeUpdate();
                    }
                    return false; 
                } else {
                    // [INSERT] အကွက်: မရှိသေးလို့ အသစ်သိမ်းမယ်
                    String insertSql = "INSERT INTO user_bookmarks (user_id, cheatsheet_id) VALUES (?, ?)";
                    try (PreparedStatement ips = conn.prepareStatement(insertSql)) {
                        ips.setInt(1, userId);
                        ips.setInt(2, cheatsheetId);
                        ips.executeUpdate();
                    }
                    return true; 
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🌟 [CHECK STATUS] ကတ်ပြားပေါ်မှာ မီးလင်းဖို့အတွက် စစ်ဆေးပေးမည့် Method
    public boolean isBookmarked(int userId, int cheatsheetId) {
        String sql = "SELECT 1 FROM user_bookmarks WHERE user_id = ? AND cheatsheet_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, cheatsheetId);
            ResultSet rs = ps.executeQuery();
            return rs.next(); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🌟 [SELECT LIST] Bookmark ထားသမျှကို ဆွဲထုတ်ပေးမည့် Method
    public List<CheatSheet> getBookmarkedCheats(int userId) {
        List<CheatSheet> list = new ArrayList<>();
        String sql = "SELECT cs.*, c.name as cname FROM cheat_sheets cs " +
                     "JOIN user_bookmarks ub ON cs.id = ub.cheatsheet_id " +
                     "JOIN categories c ON cs.category_id = c.id " +
                     "WHERE ub.user_id = ? ORDER BY cs.id DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CheatSheet cs = new CheatSheet();
                cs.setId(rs.getInt("id"));
                cs.setTitle(rs.getString("title"));
                cs.setContent(rs.getString("content"));
                cs.setCreatedAt(rs.getString("created_at"));
                cs.setUpdatedAt(rs.getString("updated_at"));
                cs.setCategoryName(rs.getString("cname"));
                cs.setBookmarked(true); // ဝင်လာသမျှက Bookmark ဖိုင်တွေမို့ အသေ True ပေးထားမယ်
                list.add(cs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}