package com.cheatsheet.repository;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cheatsheet.model.Tag;
 // မင်းရဲ့ Tag Entity package လမ်းကြောင်းပေးပါ

public class TagRepository {
    private Connection conn;

    public TagRepository(Connection conn) {
        this.conn = conn;
    }

    // Database ထဲက Tag အားလုံးကို ဆွဲထုတ်တဲ့ method
    public List<Tag> getAllTags() {
        List<Tag> list = new ArrayList<>();
        Tag t = null;
        try {
            String sql = "select * from tags";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                t = new Tag();
                t.setId(rs.getInt("id"));
                t.setTagName(rs.getString("tag_name"));
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}