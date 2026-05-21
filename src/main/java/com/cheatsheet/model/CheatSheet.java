package com.cheatsheet.model;


import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class CheatSheet {
    private int id;
    private String userId;
    private String userName;
    private String title;
    private String content;
    private String categoryId;

    private String email;
    private String createdAt;
    private String updatedAt;
    private String categoryName;
    private boolean isBookmarked;
    private String status;
 // Getter and Setter (PropertyNotFoundException ဖြေရှင်းပြီးသား ပုံစံ)
    public boolean getIsBookmarked() {
        return isBookmarked;
    }

    public void setBookmarked(boolean isBookmarked) {
        this.isBookmarked = isBookmarked;
    }
    
    // ... မင်းဆီက ကျန်တဲ့ နဂို Getter/Setter တွေကို ဒီအောက်မှာ ဒီတိုင်း ဆက်ထားပါ ...
}

