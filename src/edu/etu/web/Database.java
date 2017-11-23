package edu.etu.web;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Database implements Serializable{
    private static Map<String, Item> items = new HashMap<>();
    public static Item getItemById(String id) {
        return items.get(id);
    }
    public static Map<String, Item> getAllItems() {
        return items;
    }
    public static void addItem(Item item) {items.put(item.getId(),item);}
}

