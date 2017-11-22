package edu.etu.web;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Database {
    private static Map<String, Item> items = new HashMap<>();
    public static Item getItemById(String id) {
        return items.get(id);
    }
    public static Map<String, Item> getAllItems() {
        return items;
    }
    public static void addItem(Item item) {items.put(item.getId(),item);}
}

