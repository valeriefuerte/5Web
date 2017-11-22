package edu.etu.web;

import java.util.*;

import edu.etu.web.Item.Direction;
import edu.etu.web.Item.Uniqueness;

public class ItemFilter {
    Integer minPrice = 0;
    Integer maxPrice = 1000000;
    Integer maxDay = 30;
    Integer minDay = 1;
    List<Direction> direction = Arrays.asList(Direction.RUSSIA, Direction.EUROPE, Direction.ASIA);
    List<Uniqueness> uniqueness = Arrays.asList(Uniqueness.PARK, Uniqueness.ARCHITECTURE, Uniqueness.NON_TOURISTIC, Uniqueness.MUSEUM, Uniqueness.CLUB);

    public Integer getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Integer minPrice) {
        this.minPrice = minPrice;
    }

    public Integer getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Integer maxPrice) {
        this.maxPrice = maxPrice;
    }

    public Integer getMinDay() {
        return minDay;
    }

    public void setMinDay(Integer minDay) {
        this.minDay = minDay;
    }

    public Integer getMaxDay() {
        return maxDay;
    }

    public void setMaxDay(Integer maxDay) {
        this.maxDay = maxDay;
    }

    public List<Direction> getDirection() {
        return direction;
    }

    public void setDirection(List<Direction> direction) {
        this.direction = direction;
    }

    public List<Uniqueness> getUniqueness() {
        return uniqueness;
    }

    public void setUniqueness(List<Uniqueness> uniqueness) {
        this.uniqueness = uniqueness;
    }

    public ItemFilter(Map<String, String[]> params) {
        if (params.containsKey("min_price")) {
            try {
                minPrice = Integer.parseInt(params.get("min_price")[0]);
            } catch (NumberFormatException ignored) {}
        }
        if (params.containsKey("max_price")) {
            try {
                maxPrice = Integer.parseInt(params.get("max_price")[0]);
            } catch (NumberFormatException ignored) {}
        }

        if (params.containsKey("min_day")) {
            try {
                minDay = Integer.parseInt(params.get("min_day")[0]);
            } catch (NumberFormatException ignored) {}
        }
        if (params.containsKey("max_day")) {
            try {
                maxDay = Integer.parseInt(params.get("max_day")[0]);
            } catch (NumberFormatException ignored) {}
        }

        if (params.containsKey("direction")) {
            direction = new ArrayList<>();
            for (String d : params.get("direction")) {
                switch (d) {
                    case "russia":
                        direction.add(Direction.RUSSIA);
                        break;
                    case "europe":
                        direction.add(Direction.EUROPE);
                        break;
                    case "asia":
                        direction.add(Direction.ASIA);
                        break;
                }
            }
        }

        if (params.containsKey("uniqueness")) {
            uniqueness = new ArrayList<>();
            for (String d : params.get("uniqueness")) {
                switch (d) {
                    case "national_park":
                        uniqueness.add(Uniqueness.PARK);
                        break;
                    case "architecture":
                        uniqueness.add(Uniqueness.ARCHITECTURE);
                        break;
                    case "non_touristic":
                        uniqueness.add(Uniqueness.NON_TOURISTIC);
                        break;
                    case "museum":
                        uniqueness.add(Uniqueness.MUSEUM);
                        break;
                    case "club":
                        uniqueness.add(Uniqueness.CLUB);
                        break;
                }
            }
        }

    }

    public Map<String, Item> getFilteredItems() {
        Map<String, Item> items = Database.getAllItems();
        Map<String, Item> filteredItems = new HashMap<>();

        for (Map.Entry<String, Item> itemEntry : items.entrySet()) {
            Item item = itemEntry.getValue();

            if ((item.getPrice() >= minPrice) && (item.getPrice() <= maxPrice) &&
                    (item.getDay() >= minDay) && (item.getDay() <= maxDay) &&
                    direction.contains(item.getItemDirection()) &&
                    uniqueness.contains(item.getUniqueness())) {
                // matching item, add to result
                filteredItems.put(item.getId(), item);
            }
        }

        return filteredItems;
    }
}
