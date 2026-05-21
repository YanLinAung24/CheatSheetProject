package com.cheatsheet.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Tag {
    private int id;
    private String tagName;
    private int categoryId;
    // Getters and Setters
}