<%--
  Created by IntelliJ IDEA.
  User: valerie
  Date: 13.11.17
  Time: 9:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<%@ taglib prefix='util' uri='/WEB-INF/tld/util' %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="javax.servlet.http.Cookie"%>
<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="java.util.Map" %>
<%@ page import="edu.etu.web.CookiesUtils" %>
<%@ page import="edu.etu.web.Item" %>
<%@ page import="edu.etu.web.Database" %>
<%@ page import="java.util.Locale" %>


<c:set var="lang" value="${util:getLang(pageContext.request, pageContext.response)}"/>
<fmt:setLocale value="${lang}"/>
<%
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
    String item_id = "Almaty";

    Locale locale = new Locale.Builder().setLanguage(lang).build();
    ResourceBundle resources = ResourceBundle.getBundle(item_id, locale);
%>
<html>
<head>
    <title>Travell with InfinitoFuerte</title>
    <link rel="stylesheet" type="text/css" href="static/index.css">
    <script>
        function changeLanguage(lang) {
            window.location.href = "?lang=" + lang;
        }
    </script>
</head>
<body>
<div class="container">
    <div class="main">
        <fmt:setBundle basename="strings"/>
        <fmt:message key="username"/>:
        ${sessionScope.username}
        <br>
        <fmt:message key="default_tab"/>
        <%
            String activeTab = application.getInitParameter("ActiveButton");
            String str = "";
            if(activeTab.equals("info_content")){
                str = resources.getString("menu_1");
            } else{
                if(activeTab.equals("characteristic_content")){
                    str = resources.getString("menu_2");

                } else{
                    if(activeTab.equals("review_content")){
                        str = resources.getString("menu_3");
                    }
                }
            }
        %>
        <%=str%>
    </div>
</div>
</body>
</html>
