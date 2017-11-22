package edu.etu.web;

import org.hibernate.Session;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.util.Map;

/**
 * Created by valerie on 09.11.17.
 */
public class JstlUtils {
    public static String getLang(HttpServletRequest request,
                                 HttpServletResponse response) {
        final Map<String, Cookie> cookies = CookiesUtils.mapCookiesByName(request.getCookies());
        final Map<String, String[]> params = request.getParameterMap();

        String lang;
        if (!params.containsKey("lang")) {
            if(cookies.containsKey("lang")) {
                lang = cookies.get("lang").getValue();
            } else {
                lang = "ru";
            }
        } else {
            lang = params.get("lang")[0];
        }
        response.addCookie(new Cookie("lang", lang));
        return lang;
    }

    public static class SaveOrderTag extends SimpleTagSupport {

        private HistoryEntry value;

        public void setValue(HistoryEntry value) {
            this.value = value;
        }

        public void doTag() {
            Session dbSession = HibernateUtil.getSessionFactory().openSession();
            dbSession.beginTransaction();
            dbSession.save(value);
            dbSession.getTransaction().commit();
            dbSession.close();
        }
    }
}
