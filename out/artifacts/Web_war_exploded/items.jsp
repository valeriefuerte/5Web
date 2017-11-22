<%@ page import="edu.etu.web.ItemFilter" %>
<%@ page import="edu.etu.web.Item" %><%--
  Created by IntelliJ IDEA.
  User: valerie
  Date: 29.10.17
  Time: 19:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    for (Map.Entry<String, Item> entry : filter.getFilteredItems().entrySet()) {
        Item item = entry.getValue();
        ResourceBundle itemResources = ResourceBundle.getBundle(item.getId(), locale);%>

        <%@include file="item.jsp"%>
<%}%>