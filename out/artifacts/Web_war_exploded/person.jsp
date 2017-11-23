<%--
  Created by IntelliJ IDEA.
  User: valerie
  Date: 13.11.17
  Time: 9:35
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="edu.etu.web.HistoryEntry" %>
<%@ page import="edu.etu.web.Database" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<%@ taglib prefix='util' uri='/WEB-INF/tld/util' %>

<%@ page import="edu.etu.web.CookiesUtils" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ResourceBundle" %>

<c:set var="itemsMap" value="${Database.getAllItems()}" scope="request"/>

<c:set var="lang" value="${util:getLang(pageContext.request, pageContext.response)}"/>
<fmt:setLocale value="${lang}"/>
<%
    final Map<String, String[]> params = request.getParameterMap();
    final Map<String, Cookie> cookies = CookiesUtils.mapCookiesByName(request.getCookies());
    String lang = "";
    if (!params.containsKey("lang")) {
        if (cookies.containsKey("lang")) {
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
        function loadComments() {
            let xhr = new XMLHttpRequest();

            xhr.onreadystatechange = () => {
                if (xhr.readyState === 4) {
                    document.getElementsByClassName("comments_container")[0].innerHTML = xhr.responseText;
                }
            };

            xhr.open("GET", "/comment", true);
            xhr.send();
        }

        function postComment() {
            let xhr = new XMLHttpRequest();

            xhr.onreadystatechange = () => {
                if (xhr.readyState === 4) {
                    document.getElementsByName("comment_text")[0].value = "";
                    loadComments();
                }
            };

            xhr.open("POST", "/comment", true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.send("text=" + encodeURIComponent(document.getElementsByName("comment_text")[0].value));
        }

        onload = () => {
            loadComments();
        }
    </script>
</head>
<body>
<%@ include file="header.jsp" %>
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
            if (activeTab.equals("info_content")) {
                str = resources.getString("menu_1");
            } else {
                if (activeTab.equals("characteristic_content")) {
                    str = resources.getString("menu_2");

                } else {
                    if (activeTab.equals("review_content")) {
                        str = resources.getString("menu_3");
                    }
                }
            }
        %>
        <%=str%>

        <br>

        <c:forEach var="order" items="${HistoryEntry.getAll()}">
            <c:if test="${order.user eq sessionScope.username}">

                <div class="items_container">
                    <div class="item">
                        <c:forEach var="orderMapEntry" items="${HistoryEntry.decodeCartString(order.cart)}">
                            <c:if test="${itemsMap.containsKey(orderMapEntry.key)}">
                                <c:set var="orderItem"
                                       value="${requestScope.itemsMap.get(orderMapEntry.key)}"/>
                                <fmt:setBundle basename="strings"/>
                                <fmt:message key="b1H"/>:
                                <fmt:setBundle basename="${orderMapEntry.key}"/>
                                <fmt:message key="header"/>
                                <br>
                                <fmt:setBundle basename="strings"/>
                                <fmt:message key="b2H"/>:
                                ${orderMapEntry.value}
                                <br>
                                <fmt:setBundle basename="strings"/>
                                <fmt:message key="b3H"/>:
                                ${order.date}
                                <br>
                                <fmt:setBundle basename="strings"/>
                                <fmt:message key="b5H"/>:
                                <c:choose>
                                    <c:when test="${order.delivery}">
                                        <fmt:setBundle basename="strings"/>
                                        <fmt:message key="b42H"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:setBundle basename="strings"/>
                                        <fmt:message key="b41H"/>
                                    </c:otherwise>
                                </c:choose>
                                <br>
                                <fmt:setBundle basename="strings"/>
                                <fmt:message key="b6H"/>:
                                <c:choose>
                                    <c:when test="${order.delivery}">
                                        ${order.address}
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:setBundle basename="strings"/>
                                        <fmt:message key="${order.address}"/>
                                    </c:otherwise>
                                </c:choose>
                                <br>
                            </c:if>
                        </c:forEach>

                    </div>
                </div>

            </c:if>
        </c:forEach>

        <fmt:setBundle basename="strings"/>
        <fmt:message key="comments"/>: <br>
        <br>
        <div class="comments_container">

        </div>

        <textarea style="width:400px; height:300px" name="comment_text"></textarea>
        <br>
        <button onclick="postComment()" class="commentButton">
            Post comment
        </button>

    </div>
</div>
</body>
</html>
