package edu.etu.web;
import java.io.Serializable;
import java.util.List;

public class Item implements Serializable {
    public void setId(String id) {
        this.id = id;
    }

    private String id;
    private String imageUrl;
    private int price;
    private int day;
    private Direction itemDirection;
    private Uniqueness uniqueness;

    public void setPrice(int price) {
        this.price = price;
    }
    public void setDay(int day) {
        this.day = day;
    }
    public void setItemDirection(String newDirection) {
        switch (newDirection){
            case "RUSSIA":
                this.itemDirection = Direction.RUSSIA;
                break;
            case  "EUROPE":
                this.itemDirection = Direction.EUROPE;
                break;
            case "ASIA":
                this.itemDirection = Direction.ASIA;
                break;
            default:
                break;
        }
    }
    public void setItemDirection(Direction newDirection) {
        this.itemDirection = newDirection;
    }
    public void setUniqueness(String uniqueness) {
        switch (uniqueness) {
            case "PARK":
                this.uniqueness = (Uniqueness.PARK);
                break;
            case "ARCHITECTURE":
                this.uniqueness = (Uniqueness.ARCHITECTURE);
                break;
            case "NON_TOURISTIC":
                this.uniqueness = (Uniqueness.NON_TOURISTIC);
                break;
            case "MUSEUM":
                this.uniqueness = (Uniqueness.MUSEUM);
                break;
            case "CLUB":
                this.uniqueness = (Uniqueness.CLUB);
                break;
        }

    }
    public void setUniqueness(Uniqueness uniqueness) {
        this.uniqueness = uniqueness;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getId() {
        return id;
    }
    public int getPrice() {
        return price;
    }
    public int getDay() {return day; }
    public Direction getItemDirection() {
        return itemDirection;
    }
    public Uniqueness getUniqueness() {
        return uniqueness;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public enum Direction {RUSSIA, EUROPE, ASIA}
    public enum Uniqueness {PARK, ARCHITECTURE, NON_TOURISTIC, MUSEUM, CLUB}
}


