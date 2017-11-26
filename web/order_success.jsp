<%--
  Created by IntelliJ IDEA.
  User: valerie
  Date: 19.11.17
  Time: 13:45
  To change this template use File | Settings | File Templates.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<%@ taglib prefix='util' uri='/WEB-INF/tld/util' %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.etu.web.HistoryEntry" %>
<c:if test="${empty sessionScope.purchaces || empty sessionScope.username ||empty param.address || empty param.delivery}">
    <c:redirect url="/"/>
</c:if>

<jsp:useBean class="edu.etu.web.HistoryEntry" id="historyEntry"/>
<jsp:setProperty name="historyEntry" property="user" value="${sessionScope.username}"/>
<jsp:setProperty name="historyEntry" property="address" value="${param.address}"/>
<jsp:setProperty name="historyEntry" property="delivery" value="${param.delivery}"/>
<jsp:setProperty name="historyEntry" property="cart" value="${HistoryEntry.encodeCartString(sessionScope.purchaces)}"/>
<jsp:useBean id="now" class="java.util.Date"/>
<jsp:setProperty name="historyEntry" property="date" value="${now}"/>

<%--<util:saveOrder value="${historyEntry}"/>--%>
<c:remove var="purchaces"/>

<c:if test="${empty sessionScope.purchaces}">
    <c:redirect url="/"/>
</c:if>
<c:if test="${empty sessionScope.username}">
    <c:redirect url="/login"/>
</c:if>


<html>
<head>
    <title>Travell with InfinitoFuerte</title>
    <link rel="stylesheet" type="text/css" href="static/index.css">
</head>
<body>
<meta charset="UTF-8">
<%@ include file="header.jsp"%>
<div class="container">
    <div class="main">
        Заказ готов!
    </div>
</div>
</body>
</html>
