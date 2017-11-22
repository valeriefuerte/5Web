package edu.etu.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ServletName extends HttpServlet {
    protected void
    doGet(HttpServletRequest
                  request,
          HttpServletResponse
                  response)
            throws
            ServletException,
            IOException {
        final Map<String, String[]> params = request.getParameterMap();
        final Map<String, Cookie> cookies = CookiesUtils.mapCookiesByName(request.getCookies());

        String lang = "";
        if(!params.containsKey("lang")) {
            if(cookies.containsKey("lang")) {
                lang = cookies.get("lang").getValue();
            } else {
                lang = "fi";
            }
        } else {
            lang = params.get("lang")[0];
        }
        response.addCookie(new Cookie("lang", lang));

        String item_id = params.getOrDefault("id", new String[]{null})[0];
        Item item = Database.getItemById(item_id);

        Locale locale = new Locale.Builder().setLanguage(lang).build();
        ResourceBundle resources = ResourceBundle.getBundle(item_id, locale);

        String active_tab_content = getInitParameter("ActiveButton");

        String responseString = "<html>\n" +
                "  <head>\n" +
                "    <meta charset=\"UTF-8\">\n" +
                "    <title>Travell with InfinitoFuerte</title>\n" +
                "    <style type=\"text/css\">\n" +
                "       body{\n"+
                "           background-color: #FFFAF0; \n" +
                "           overflow: auto;\n" +
                "       } \n" +
                "       .container{ \n"+
                "           max-width: 1920px; \n" +
                "           min-width: 1366px;\n" +
                "           margin-left: auto;\n" +
                "           margin-right: auto;\n" +
                "           margin-bottom: 25px;\n" +
                "           overflow: auto;\n" +
                "       }\n" +
                "       .main{ \n" +
                "           width: 90%; \n" +
                "           margin-left: auto; \n" +
                "           margin-right: auto; \n" +
                "           background-color: #fff; \n" +
                "           padding: 25px; \n" +
                "           border-radius: 5px; \n" +
                "           box-shadow: 0px 0px 10px 5px #dfdfdf;\n" +
                "           overflow: auto; \n" +
                "       }\n" +
                "       .main > button { \n" +
                "           display: inline-block; \n" +
                "           padding: 10px; \n" +
                "           margin: 0 -5px -1px 0; \n" +
                "           text-align: center; \n" +
                "           color: #666666; \n" +
                "           border: 1px solid #A9A9A9;\n" +
                "           background: #E0E0E0; \n" +
                "           cursor: pointer; \n" +
                "           font-size: 20px; \n" +
                "           border-radius: 2px;\n" +
                "           }\n" +
                "        .table { \n" +
                "            width: 100%;\n" +
                "            padding: 2px;\n" +
                "            margin: 0 auto;\n" +
                "            position: relative;\n" +
                "        }\n" +
                "        .table > div {\n" +
                "            display: none;\n" +
                "            padding: 5px;\n" +
                "            border: 1px solid #A9A9A9;\n" +
                "            background: #FFFAF0;\n" +
                "        }\n" +
                "        .table > button {\n" +
                "            display: inline-block;\n" +
                "            padding: 6px;\n" +
                "            margin: 0 -5px -1px 0;\n" +
                "            text-align: center;\n" +
                "            color: #666666;\n" +
                "            border: 1px solid #A9A9A9;\n" +
                "            cursor: pointer;\n" +
                "            font-size: 20px;\n" +
                "            border-radius: 2px;\n" +
                "        }\n" +
                "        .table > button:hover {\n" +
                "            color: darkcyan;          \n" +
                "        }\n" +
                "        .tabcontent {\n" +
                "            display: none;\n" +
                "            height: auto;\n" +
                "            padding: 5px 10px;            \n" +
                "            border: 1px solid #ccc;\n" +
                "            border-top: none;\n" +
                "            font-size: 18px;\n" +
                "        }\n" +
                "       .inactivetab {\n" +
                "            background-color: #E0E0E0;\n" +
                "       }\n" +
                "       .activetab {\n" +
                "            background-color: #A9A9A9;\n" +
                "       }\n" +
                "        .info_content {\n" +
                "            margin-right: 10px;\n" +
                "        }\n" +
                "        #buy > button {\n" +
                "            color: red; \n" +
                "            background: #FFFAF8; \n" +
                "            padding: 5px; \n" +
                "            border-radius: 5px;\n" +
                "            border: 2px solid red;\n" +
                "            width: 90px;\n" +
                "            height: 50px;\n" +
                "            font-size: 20px;\n" +
                "        }\n" +
                "        #buy > button:hover {\n" +
                "            color: darkcyan;\n" +
                "            cursor: pointer;\n" +
                "        }\n" +
                "        .review {\n" +
                "            border-bottom: 1px solid #A9A9A9;\n" +
                "            font-style: italic; \n" +
                "            font-size: 20px;\n" +
                "        }\n" +
                "        .review_last {\n" +
                "            font-style: italic; \n" +
                "            font-size: 20px;\n" +
                "        }\n" +
                "    </style>\n" +
                "        <script type=\"text/javascript\">\n" +
                "\n" +
                "      function hideAll() {\n" +
                "        var element = document.getElementsByClassName('tabcontent');\n" +
                "        for (var i = 0; i < element.length; i++) {\n" +
                "          element[i].style.display = 'none';\n" +
                "        }\n" +
                "      }\n" +
                "\n" +
                "      function showElement(elem) {\n" +
                "        hideAll();\n" +
                "        document.getElementById(elem).style.display = 'block';\n" +
                "      }\n" +
                "\n" +
                "      function findButtons() { \n" +
                "        var container = document.getElementsByClassName('table'); \n" +
                "        var tabs = container[0].getElementsByTagName('button'); \n" +
                "        for(var i = 0; i < tabs.length; i++){ \n" +
                "          tabs[i].className = 'inactivetab'; \n" +
                "        } \n" +
                "       } \n" +
                "\n" +
                "      function highlight(tab) { \n" +
                "       findButtons();\n" +
                "       tab.className = 'activetab'; \n" +
                "       } \n"+
                "\n" +
                "      function addToCart(id) { \n" +
                "       window.location.href = '/cart.jsp?add=' + id;\n" +
                "       } \n" +
                "    </script>\n" +
                "  </head>\n" +
                "\n" +
                "  <body onload=\"showElement('" + active_tab_content + "')\">\n" +
                "  <h1>" + resources.getString("header_1") + "</h1> \n" +
                "  <div class=\"container\"> \n" +
                "    <div class=\"main\"> \n" +
                "       <div class=\"language\"> \n"+
                "            <a href=\"/item?id=" + item_id + "&lang=ru\"><img src=\"static/ru.jpeg\"> </a> \n" +
                "            <a href=\"/item?id=" + item_id + "&lang=en\"><img src=\"static/en.jpeg\"> </a> \n" +
                "            <a href=\"/item?id=" + item_id + "&lang=fi\"><img src=\"static/fi.jpeg\"> </a> \n" +
                "        </div> \n" +
                "       <button onclick=\"location.href='/index.jsp'\" >" + resources.getString("button1") + "</button> \n" +
                "       <button onclick=\"location.href='/cart.jsp'\" >" + resources.getString("button2")+ "</button> \n" +
                "       <button>" + resources.getString("button4")+ "</button> \n" +
                "           <h2>" +
                resources.getString("header_2") +
                "</h2>\n" +
                "    <div class=\"table\">\n" +
                "\n" +
                "       <button class=\"inactivetab\" id=\"info\" onclick=\"showElement('info_content'); highlight(this)\">" +
                resources.getString("menu_1")+
                "       </button>\n" +
                "       <button class=\"inactivetab\" id=\"characteristic\" onclick=\"showElement('characteristic_content');highlight(this)\">"+
                resources.getString("menu_2") +
                "       </button>\n" +
                "       <button class=\"inactivetab\" id=\"review\" onclick=\"showElement('review_content');highlight(this)\">"+
                resources.getString("menu_3") +
                "       </button>\n" +
                "\n" +
                "        <div id=\"info_content\" class = \"tabcontent\">\n" +
                "            <img src=\"" + item.getImageUrl() + "\" width = \"180px\" height = \"250px\" align=\"right\" alt = \"Телевышка\">\n" +
                "            <p>" + resources.getString("info_p_1")+ "</p>\n" +
                "            <p>" + resources.getString("info_p_2") +"</p>\n" +
                "            <ul class=\"info_content\">\n" +
                "              <li>" + resources.getString("ul_1_li_1") + "</li>\n" +
                "              <li>" + resources.getString("ul_1_li_2") + "</li>\n" +
                "              <li>" + resources.getString("ul_1_li_3") + "</li>\n" +
                "              <li>" + resources.getString("ul_1_li_4") + "</li>\n" +
                "              <li>" + resources.getString("ul_1_li_5") + "</li>\n" +
                "              <li>" + resources.getString("ul_1_li_6") + "</li>\n" +
                "            </ul>\n" +
                "            <p>" + resources.getString("info_p_3") + "</p>\n" +
                "            <br>\n" +
                "            <div id=\"buy\">\n" +
                "               <button onclick=\"addToCart('" + item_id + "')\">" + resources.getString("buy_button") + "</button>\n" +
                "            </div>\n" +
                "        </div>\n" +
                "        <div id=\"characteristic_content\" class=\"tabcontent\">\n" +
                "            <h4>" + resources.getString("characteristic_h_1") + "</h4>\n" +
                "            <p>" + resources.getString("characteristic_p_1") + "</p>\n" +
                "            <p>" + resources.getString("characteristic_p_2") + "</p>\n" +
                "            <p>" + resources.getString("characteristic_p_3") + "</p>\n" +
                "            <p>" + resources.getString("characteristic_p_4") + "</p>\n" +
                "            <p>" + resources.getString("characteristic_p_5") + "</p>\n" +
                "            <p>" + resources.getString("characteristic_p_6") + "</p>\n" +
                "            <p>" + resources.getString("characteristic_p_7") + "</p>\n" +
                "            <br>\n" +
                "            <p>" + resources.getString("characteristic_p_8") + "</p>\n" +
                "            <div id=\"buy\">\n" +
                "               <button onclick=\"addToCart('" + item_id + "')\">" + resources.getString("buy_button") + "</button>\n" +
                "            </div>\n" +
                "        </div>\n" +
                "        <div id=\"review_content\" class=\"tabcontent\">\n" +
                "            <div class=\"review\">\n" +
                "                <h4>" + resources.getString("review_h_1") + "</h4>\n" +
                "                <p>" + resources.getString("review_p_1") + "</p>\n" +
                "            </div>\n" +
                "            <div class=\"review_last\">\n" +
                "                <h4>" + resources.getString("review_h_2") + "</h4>\n" +
                "                <p>" + resources.getString("review_p_2") + "</p>\n" +
                "            </div>     \n" +
                "            <div id=\"buy\">\n" +
                "               <button onclick=\"addToCart('" + item_id + "')\">" + resources.getString("buy_button") + "</button>\n" +
                "            </div>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "    </div>\n" +
                "   </div>\n" +
                "  </body>\n" +
                "</html>\n";

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println(responseString);
        out.close();
    }
}