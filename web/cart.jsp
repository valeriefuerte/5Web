<%@ page import="edu.etu.web.Database" %>
<%@ include file="header.jsp"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<%@ taglib prefix='util' uri='/WEB-INF/tld/util' %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="lang" value="${util:getLang(pageContext.request, pageContext.response)}"/>
<fmt:setLocale value="${lang}"/>
<c:if test="${empty sessionScope.purchaces}">
    <jsp:useBean id="cartMap" class="java.util.HashMap" scope="request"/>
    <c:set var="purchaces" scope="session" value="${cartMap}"/>
</c:if>
<c:set var="itemsMap" value="${Database.getAllItems()}" scope="request"/>
<c:if test="${not empty param.add}">
    <c:if test="${empty sessionScope.purchaces[param.add]}">
        <c:set target="${purchaces}" property="${param.add}" value="${0}"/>
    </c:if>
    <c:set target="${purchaces}" property="${param.add}" value="${sessionScope.purchaces[param.add] + 1}"/>
</c:if>
<c:if test="${not empty param.setcountid && not empty param.setcountq}">
    <c:catch var="parseerror">
        <fmt:parseNumber var="setcountqparsed" integerOnly="false" value="${param.setcountq}"/>
    </c:catch>
    <c:if test="${parseerror == null && setcountqparsed > 0}">
        <c:set target="${purchaces}" property="${param.setcountid}" value="${setcountqparsed}"/>
    </c:if>
</c:if>
<c:if test="${not empty param.remove}">
    <c:set target="${purchaces}" property="${param.remove}" value="${null}"/>
</c:if>

<html>
<head>
    <title>Travell with InfinitoFuerte</title>
    <link rel="stylesheet" type="text/css" href="static/index.css">
    <script>
        function setCount(id) {
            window.location.href =
                "/cart.jsp?setcountid=" + id +
                "&setcountq=" + document.getElementById( id + '_count').value;
        }

        function removeItem(id) {
            window.location.href = "/cart.jsp?remove=" + id;
        }
        function changeLanguage(lang) {
            window.location.href = "?lang=" + lang;
        }
    </script>
</head>
<body>
<meta charset="UTF-8">
<div class="container">
    <div class="main">
        <p class="cart_p">
            <fmt:setBundle basename="strings"/>
            <fmt:message key="b1"/>
        </p>
        <b class="cart_price_value">
            <c:set var="totalCost" scope="request" value="0"/>
            <c:forEach var="purchace" items="${sessionScope.purchaces}">
                <c:if test="${requestScope.itemsMap.containsKey(purchace.key)}">
                    <c:set scope="request" var="item" value="${requestScope.itemsMap.get(purchace.key)}"/>
                    <c:set var="totalCost" scope="request"
                           value="${totalCost + requestScope.item.getPrice() * purchace.value}"/>
                </c:if>
            </c:forEach>
            ${totalCost}
        </b>
        <button class="cart_release" onclick="window.location.href = '/map.jsp'">
            <fmt:setBundle basename="strings"/>
            <fmt:message key="button10"/>
        </button>
        <div class="items_container">
            <c:if test="${not empty sessionScope.purchaces}">
                <c:forEach var="purchace" items="${sessionScope.purchaces}">
                    <c:if test="${requestScope.itemsMap.containsKey(purchace.key)}">
                        <c:set scope="request" var="item" value="${requestScope.itemsMap.get(purchace.key)}"/>

                        <div class="item">
                            <div class="item_header">
                                <b class="title">
                                    <fmt:setBundle basename="${requestScope.item.getId()}"/>
                                    <fmt:message key="header"/>
                                </b>
                                <b class="price_value">
                                    <c:out value="${item.getPrice() * purchace.value}"/>
                                </b>
                                <p>
                                    <fmt:setBundle basename="${requestScope.item.getId()}"/>
                                    <fmt:message key="p1"/>
                                </p>
                            </div>
                            <img src="<c:out value="${item.getImageUrl()}"/>" width="300px" height="300px" />
                            <p class="cart_font">
                                <fmt:setBundle basename="strings"/>
                                <fmt:message key="p1"/>
                            </p>
                            <input class="cart_font" id="${item.getId()}_count" type="text" value="${purchace.value}">
                            <button class="add_to_cart" onclick="setCount('${item.getId()}')">
                                <fmt:setBundle basename="strings"/>
                                <fmt:message key="update"/>
                            </button>
                            <button class="delete_button" onclick="removeItem('${item.getId()}')">
                                <fmt:setBundle basename="strings"/>
                                <fmt:message key="delete_button"/>
                            </button>
                            <br><br><br><br>
                            <a href="${pageContext.request.contextPath}/item?id=<c:out value="${item.getId()}"/>&lang=<c:out value="${lang}"/>">
                                <button class="details">
                                    <fmt:setBundle basename="strings"/>
                                    <fmt:message key="details"/>
                                </button>
                            </a>
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>

