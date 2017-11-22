<%--
  Created by IntelliJ IDEA.
  User: valerie
  Date: 09.11.17
  Time: 20:59
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="header.jsp"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<%@ taglib prefix='util' uri='/WEB-INF/tld/util' %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="lang" value="${util:getLang(pageContext.request, pageContext.response)}"/>
<fmt:setLocale value="${lang}"/>
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
            <p class="cart_p">
                <fmt:setBundle basename="strings"/>
                <fmt:message key="button3"/>
            </p>
            <form action="j_security_check" method="post" name="loginForm" class="auth_form" style="margin: 10px;">
                <div style="width: 150px;">
                    <input type="text" name="j_username" class="username" placeholder="Username"/>
                    <input type="password" name="j_password" class="password" placeholder="Password"/>
                </div>
                <button type="submit" class="cart_release">
                    <fmt:setBundle basename="strings"/>
                    <fmt:message key="button11"/>
                </button>
            </form>
        </div>
    </div>
</body>
</html>
