package com.cheatsheet.repository;

import java.sql.*;
import com.cheatsheet.model.User;
import org.mindrot.jbcrypt.BCrypt;

public class UserRepository {
    private Connection conn;

    public UserRepository(Connection conn) {
        this.conn = conn;
    }

    public boolean registerUser(User user) {
        boolean f = false;
        try {
            String sql = "INSERT INTO Users(username, email, password, role) VALUES(?,?,?,'USER')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // Hash လုပ်ပြီးသား password ကို သိမ်းမည်
            if (ps.executeUpdate() == 1) f = true;
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }

    public User login(String email, String password) {
        User user = null;
        try {
            String sql = "SELECT * FROM Users WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String dbHashedPsw = rs.getString("password");
                // Password မှန်မမှန် BCrypt ဖြင့် စစ်ဆေးခြင်း
                if (BCrypt.checkpw(password, dbHashedPsw)) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return user;
    }
}