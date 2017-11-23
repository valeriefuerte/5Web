package edu.etu.web;

/**
 * Created by valerie on 19.11.17.
 */
import org.hibernate.Session;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "COMMENT")
public class CommentEntry {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private int id;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DATE")
    private Date date;

    @Column(name = "TEXT", nullable = false)
    private String text;

    public static List<CommentEntry> getAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        List list = session.createCriteria(CommentEntry.class).list();
        session.close();
        return list;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
