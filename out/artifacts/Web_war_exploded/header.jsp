<%--
  Created by IntelliJ IDEA.
  User: valerie
  Date: 12.11.17
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<%@ taglib prefix='util' uri='/WEB-INF/tld/util' %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="lang" value="${util:getLang(pageContext.request, pageContext.response)}"/>
<fmt:setLocale value="${lang}"/>

<meta charset="UTF-8">
<h1>
    <fmt:setBundle basename="strings"/>
    <fmt:message key="header_1"/>
</h1>


<c:choose>
    <c:when test="${empty sessionScope.username}">
            <span class="auth" style="margin-left: 60px;">
                <button onclick="window.location.href = '/login'">
                    Authorization
                </button>
            </span>
    </c:when>
    <c:otherwise>
            <span class="user" style="margin-left: 60px;">
                <b>${sessionScope.username}</b>
                <button onclick="location.href='/person.jsp'">
                    <fmt:setBundle basename="strings"/>
                    <fmt:message key="button6"/>
                </button>
                <button onclick="window.location.href = '/logout'">
                    <fmt:setBundle basename="strings"/>
                    <fmt:message key="button7"/>
                </button>
            </span>
    </c:otherwise>
</c:choose>

<div class="main">
    <div class="language">
        <a onclick="changeLanguage('ru')"><img src="static/ru.jpeg"> </a>
        <a onclick="changeLanguage('en')"><img src="static/en.jpeg"> </a>
        <a onclick="changeLanguage('fi')"><img src="static/fi.jpeg"> </a>
    </div>

    <button onclick="location.href='/index.jsp'">
        <fmt:setBundle basename="strings"/>
        <fmt:message key="button1"/>
    </button>
    <button onclick="location.href='/cart.jsp'">
        <fmt:setBundle basename="strings"/>
        <fmt:message key="button2"/>
    </button>
</div>
