package edu.etu.web;
import com.sun.org.apache.xpath.internal.operations.Bool;

import javax.servlet.http.Cookie;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CookiesUtils {
   public static Map<String, Cookie> mapCookiesByName(Cookie[] cookies) {
        final HashMap<String, Cookie> cookiesMap = new HashMap<>();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookiesMap.put(cookie.getName(), cookie);
            }
        }
        return cookiesMap;
    }

    public static Map<String, Cookie> cookiesFromFilters(ItemFilter filter) {
        final HashMap<String, Cookie> cookieHashMap = new HashMap<>();

        final Integer lifetime = 15;

        cookieHashMap.put("min_price", new Cookie("min_price", filter.getMinPrice().toString()));
        cookieHashMap.put("max_price", new Cookie("max_price", filter.getMaxPrice().toString()));
        cookieHashMap.put("min_day", new Cookie("min_day", filter.getMinDay().toString()));
        cookieHashMap.put("max_day", new Cookie("max_day", filter.getMaxDay().toString()));

        List<Item.Direction> direction = filter.getDirection();
        Boolean isRussia = direction.contains(Item.Direction.RUSSIA);
        cookieHashMap.put("direction_russia", new Cookie("direction_russia", isRussia.toString()));
        Boolean isEurope = direction.contains(Item.Direction.EUROPE);
        cookieHashMap.put("direction_europe", new Cookie("direction_europe", isEurope.toString()));
        Boolean isAsia = direction.contains(Item.Direction.ASIA);
        cookieHashMap.put("direction_asia", new Cookie("direction_asia", isAsia.toString()));


        List<Item.Uniqueness> uniqueness = filter.getUniqueness();
        Boolean isNationalPark = uniqueness.contains(Item.Uniqueness.PARK);
        cookieHashMap.put("uniqueness_national_park", new Cookie("uniqueness_national_park", isNationalPark.toString()));
        Boolean isArchitecture = uniqueness.contains(Item.Uniqueness.ARCHITECTURE);
        cookieHashMap.put("uniqueness_architecture", new Cookie("uniqueness_architecture", isArchitecture.toString()));
        Boolean isNonTouristic = uniqueness.contains(Item.Uniqueness.NON_TOURISTIC);
        cookieHashMap.put("uniqueness_non_touristic", new Cookie("uniqueness_non_touristic", isNonTouristic.toString()));
        Boolean isMuseum = uniqueness.contains(Item.Uniqueness.MUSEUM);
        cookieHashMap.put("uniqueness_museum", new Cookie("uniqueness_museum", isMuseum.toString()));
        Boolean isClub = uniqueness.contains(Item.Uniqueness.CLUB);
        cookieHashMap.put("uniqueness_club", new Cookie("uniqueness_club", isClub.toString()));

        for(Map.Entry<String, Cookie> entry : cookieHashMap.entrySet()) {
            entry.getValue().setMaxAge(lifetime);
        }

        return cookieHashMap;
    }
}