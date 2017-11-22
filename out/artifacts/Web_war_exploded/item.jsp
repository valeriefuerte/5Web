<%--
  Created by IntelliJ IDEA.
  User: valerie
  Date: 29.10.17
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="item">
    <div class="item_header">
        <b class="title"><%=itemResources.getString("header")%></b>
        <b class="price_value"><%=item.getPrice()%></b>
        <!--<input type="text" title="шт" oninput="">-->
    </div>
    <img src="<%=item.getImageUrl()%>" width="300px" height="300px" />
    <p>
        <%=itemResources.getString("p1")%>
    </p>
    <button class="add_to_basket"><%=shopResources.getString("add_to_basket")%></button>
    <a href="${pageContext.request.contextPath}/item?id=<%=item.getId()%>&lang=<%=lang %>"><button class="details"><%=shopResources.getString("details")%></button></a>
</div>
