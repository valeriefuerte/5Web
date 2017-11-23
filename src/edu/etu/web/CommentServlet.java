package edu.etu.web;

/**
 * Created by valerie on 19.11.17.
 */
import org.hibernate.Session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class CommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String text = req.getParameter("text");

        if (text != null && !text.equals("")) {
            CommentEntry commentEntry = new CommentEntry();
            commentEntry.setDate(new Date());
            commentEntry.setText(text);

            Session dbSession = HibernateUtil.getSessionFactory().openSession();
            dbSession.beginTransaction();
            dbSession.save(commentEntry);
            dbSession.getTransaction().commit();
            dbSession.close();
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String lang = JstlUtils.getLang(req, resp);
        Locale locale = new Locale.Builder().setLanguage(lang).build();

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        List<CommentEntry> comments = CommentEntry.getAll();
        for (CommentEntry comment : comments) {
            out.write("<div class=\"comment_item\">");

            /**out.write(comment.getText());*/
            out.write(DateFormat.getDateTimeInstance(DateFormat.DEFAULT, DateFormat.DEFAULT, locale).format(comment.getDate()));
            out.write("<br/>");
            String commentDecoded = new String(comment.getText().getBytes("ISO-8859-1"), "UTF-8");
            out.write(commentDecoded);

            out.write("</div><br/>");
        }
    }
}
