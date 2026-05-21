package com.cheatsheet.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.cheatsheet.model.CheatSheet;

public class AdminRepository {
    private Connection conn;

    public AdminRepository(Connection conn) {
        this.conn = conn;
    }

    // 📊 ၁။ Total Cheats အရေအတွက်ကို ရေတွက်ရန်
    public int getTotalCheatsCount() {
        String sql = "SELECT COUNT(*) FROM cheat_sheets";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 👥 ၂။ Active Users (Roleက 'USER' ဖြစ်သူများ) အရေအတွက်ကို ရေတွက်ရန်
    public int getActiveUsersCount() {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'USER'";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 🚫 ၃။ Banned Cheats အရေအတွက်ကို ရေတွက်ရန်
    public int getBannedCheatsCount() {
        String sql = "SELECT COUNT(*) FROM cheat_sheets WHERE status = 'BANNED'";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 🕒 ၄။ Recent Cheat Sheets (နောက်ဆုံးတင်ထားတဲ့ ၅ ခုခန့်) ကို ဆွဲထုတ်ရန်
    public List<CheatSheet> getRecentCheatSheets(int limit) {
        List<CheatSheet> list = new ArrayList<>();
        String sql = "SELECT cs.id, cs.title, UPPER(cs.status) as status, c.name as cname, u.username as uname " +
                     "FROM cheat_sheets cs " +
                     "JOIN categories c ON cs.category_id = c.id " +
                     "JOIN users u ON cs.user_id = u.id " +
                     "ORDER BY cs.id DESC LIMIT ?";
                     
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CheatSheet cs = new CheatSheet();
                    cs.setId(rs.getInt("id"));
                    cs.setTitle(rs.getString("title"));
                    cs.setStatus(rs.getString("status"));
                    cs.setCategoryName(rs.getString("cname"));
                    cs.setUserName(rs.getString("uname")); // @username ပြသရန်
                    list.add(cs);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}