<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="edu.etu.web.CookiesUtils" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="edu.etu.web.Database" %>
<%@ page import="edu.etu.web.Item" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>

<%@ include file="header.jsp"%>
<%--
  Created by IntelliJ IDEA.
  User: valerie
  Date: 23.10.17
  Time: 12:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    final Map<String, String[]> params = request.getParameterMap();
    final Map<String, Cookie> cookies = CookiesUtils.mapCookiesByName(request.getCookies());

    String lang = "";
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

    ItemFilter filter = new ItemFilter(params);

    Locale locale = new Locale.Builder().setLanguage(lang).build();
    ResourceBundle shopResources = ResourceBundle.getBundle("strings", locale);

    for(Map.Entry<String, Cookie> entry : CookiesUtils.cookiesFromFilters(filter).entrySet()) {
        response.addCookie(entry.getValue());
    }
%>

<html>
<head>
    <title>Travell with InfinitoFuerte</title>
    <link rel="stylesheet" type="text/css" href="static/index.css">

    <jsp:useBean id="spb" class="edu.etu.web.Item" scope="application" />
    <jsp:setProperty name="spb" property="id" value="spb"></jsp:setProperty>
    <jsp:setProperty name="spb" property="itemDirection" value="RUSSIA"></jsp:setProperty>
    <jsp:setProperty name="spb" property="price" value="20000"></jsp:setProperty>
    <jsp:setProperty name="spb" property="day" value="7"></jsp:setProperty>
    <jsp:setProperty name="spb" property="imageUrl" value="/static/tower.jpg"></jsp:setProperty>
    <jsp:setProperty name="spb" property="uniqueness" value="ARCHITECTURE"></jsp:setProperty>

    <jsp:useBean id="Almaty" class="edu.etu.web.Item" scope="application"></jsp:useBean>
    <jsp:setProperty name="Almaty" property="id" value="Almaty"></jsp:setProperty>
    <jsp:setProperty name="Almaty" property="itemDirection" value="ASIA"></jsp:setProperty>
    <jsp:setProperty name="Almaty" property="price" value="50000"></jsp:setProperty>
    <jsp:setProperty name="Almaty" property="day" value="7"></jsp:setProperty>
    <jsp:setProperty name="Almaty" property="imageUrl" value="/static/almaty.jpg"></jsp:setProperty>
    <jsp:setProperty name="Almaty" property="uniqueness" value="PARK"></jsp:setProperty>

    <jsp:useBean id="Karelia" class="edu.etu.web.Item" scope="application"></jsp:useBean>
    <jsp:setProperty name="Karelia" property="id" value="Karelia"></jsp:setProperty>
    <jsp:setProperty name="Karelia" property="itemDirection" value="RUSSIA"></jsp:setProperty>
    <jsp:setProperty name="Karelia" property="price" value="10000"></jsp:setProperty>
    <jsp:setProperty name="Karelia" property="day" value="2"></jsp:setProperty>
    <jsp:setProperty name="Karelia" property="imageUrl" value="/static/karelia.jpg"></jsp:setProperty>
    <jsp:setProperty name="Karelia" property="uniqueness" value="NON_TOURISTIC"></jsp:setProperty>

    <jsp:useBean id="Astana" class="edu.etu.web.Item" scope="application"></jsp:useBean>
    <jsp:setProperty name="Astana" property="id" value="Astana"></jsp:setProperty>
    <jsp:setProperty name="Astana" property="itemDirection" value="ASIA"></jsp:setProperty>
    <jsp:setProperty name="Astana" property="price" value="30000"></jsp:setProperty>
    <jsp:setProperty name="Astana" property="day" value="3"></jsp:setProperty>
    <jsp:setProperty name="Astana" property="imageUrl" value="/static/astana.jpg"></jsp:setProperty>
    <jsp:setProperty name="Astana" property="uniqueness" value="CLUB"></jsp:setProperty>

    <jsp:useBean id="Stg" class="edu.etu.web.Item" scope="application"></jsp:useBean>
    <jsp:setProperty name="Stg" property="id" value="Stg"></jsp:setProperty>
    <jsp:setProperty name="Stg" property="itemDirection" value="EUROPE"></jsp:setProperty>
    <jsp:setProperty name="Stg" property="price" value="25000"></jsp:setProperty>
    <jsp:setProperty name="Stg" property="day" value="5"></jsp:setProperty>
    <jsp:setProperty name="Stg" property="imageUrl" value="/static/stg.jpg"></jsp:setProperty>
    <jsp:setProperty name="Stg" property="uniqueness" value="MUSEUM"></jsp:setProperty>

    <%
        Database.addItem(spb);
        Database.addItem(Almaty);
        Database.addItem(Karelia);
        Database.addItem(Astana);
        Database.addItem(Stg);
    %>

    <script>
        function addToCart(id) {
            window.location.href = "/cart.jsp?add=" + id;
        }

        function applyFilters(params = "?") {
            let min_price = document.getElementById("min_price").value;
            let max_price = document.getElementById("max_price").value;

            let min_day = document.getElementById("min_day").value;
            let max_day = document.getElementById("max_day").value;

            let russia = document.getElementById("russia").checked;
            let europe = document.getElementById("europe").checked;
            let asia = document.getElementById("asia").checked;

            let national_park = document.getElementById("national_park").checked;
            let architecture = document.getElementById("architecture").checked;
            let non_touristic = document.getElementById("non_touristic").checked;
            let museum = document.getElementById("museum").checked;
            let club = document.getElementById("club").checked;

            params += "&min_price=" + min_price + "&max_price=" + max_price +
                    "&min_day=" + min_day + "&max_day=" + max_day;

            if(russia || europe || asia) {
                if(russia) {
                    params += "&direction=russia";
                }
                if(europe) {
                    params += "&direction=europe";
                }
                if(asia) {
                    params += "&direction=asia";
                }
            }

            if(national_park || architecture || non_touristic || museum || club) {
                if(national_park) {
                    params += "&uniqueness=national_park";
                }
                if(architecture) {
                    params += "&uniqueness=architecture";
                }
                if(non_touristic) {
                    params += "&uniqueness=non_touristic";
                }
                if(museum) {
                    params += "&uniqueness=museum";
                }
                if(club) {
                    params += "&uniqueness=club";
                }
            }

            window.location.href = params;
        }

        function changeLanguage(lang) {
            applyFilters("?lang=" + lang);
        }
    </script>
</head>
<body>
    <meta charset="UTF-8">
    <div class="container">
        <div class="main">
            <div class="right">
                <%
                    String ref = request.getHeader("referer");
                    boolean firstVisit = (ref == null);

                    final Map<String, Cookie> userCookies = firstVisit ? cookies : CookiesUtils.cookiesFromFilters(filter);

                    Integer min_price = 0;
                    Integer max_price = 100000;
                    Integer min_day = 1;
                    Integer max_day = 30;

                    Boolean isRussia = true;
                    Boolean isEurope = true;
                    Boolean isAsia = true;

                    Boolean isNationalPark = true;
                    Boolean isArchitecture = true;
                    Boolean isNonTouristic = true;
                    Boolean isMuseum = true;
                    Boolean isClub = true;


                    try {
                        min_price = Integer.parseInt(userCookies.getOrDefault("min_price", new Cookie("min_price", "0")).getValue());
                        max_price = Integer.parseInt(userCookies.getOrDefault("max_price", new Cookie("max_price", "100000")).getValue());
                        min_day = Integer.parseInt(userCookies.getOrDefault("min_day", new Cookie("min_day", "1")).getValue());
                        max_day = Integer.parseInt(userCookies.getOrDefault("max_day", new Cookie("max_day", "30")).getValue());

                        isRussia = Boolean.parseBoolean(userCookies.getOrDefault("direction_russia", new Cookie("direction_russia", "true")).getValue());
                        isEurope = Boolean.parseBoolean(userCookies.getOrDefault("direction_europe", new Cookie("direction_europe", "true")).getValue());
                        isAsia = Boolean.parseBoolean(userCookies.getOrDefault("direction_asia", new Cookie("direction_asia", "true")).getValue());

                        isNationalPark = Boolean.parseBoolean(userCookies.getOrDefault("uniqueness_national_park", new Cookie("uniqueness_national_park", "true")).getValue());
                        isArchitecture = Boolean.parseBoolean(userCookies.getOrDefault("uniqueness_architecture", new Cookie("uniqueness_architecture", "true")).getValue());
                        isNonTouristic = Boolean.parseBoolean(userCookies.getOrDefault("uniqueness_non_touristic", new Cookie("uniqueness_non_touristic", "true")).getValue());
                        isMuseum = Boolean.parseBoolean(userCookies.getOrDefault("uniqueness_museum", new Cookie("uniqueness_museum", "true")).getValue());
                        isClub = Boolean.parseBoolean(userCookies.getOrDefault("uniqueness_club", new Cookie("uniqueness_club", "true")).getValue());
                    } catch (NumberFormatException ignored) {}


                %>
                <div class="cart">
                    <button onclick="location.href='/cart.jsp'"><%=shopResources.getString("button10")%></button>
                    <form method="GET" id="filter">
                        <h3><%=shopResources.getString("h3")%></h3>
                        <p><%=shopResources.getString("p2")%>
                            <b><%=shopResources.getString("b2")%></b>
                            <input type="text" style="width: 150px" name="" id="min_price" value="<%=min_price%>">
                            <b><%=shopResources.getString("b3")%></b>
                            <input type="text" style="width: 150px" name="" id="max_price" value="<%=max_price%>">
                        </p>
                        <p><%=shopResources.getString("p3")%>
                            <b><%=shopResources.getString("b2")%></b>
                            <input type="text" style="width: 150px" name="" id="min_day" value="<%=min_day%>">
                            <b><%=shopResources.getString("b3")%></b>
                            <input type="text" style="width: 150px" name="" id="max_day" value="<%=max_day%>">
                        </p>

                        <p>
                            <b><%=shopResources.getString("b4")%></b>
                            <br />
                            <input type="checkbox" name="Socket" id="russia" <%if(isRussia) {%> checked <%}%> ><%=shopResources.getString("input1")%>
                            <br />
                            <input type="checkbox" name="Socket" id="europe" <%if(isEurope) {%> checked <%}%> ><%=shopResources.getString("input2")%>
                            <br />
                            <input type="checkbox" name="Socket" id="asia" <%if(isAsia) {%> checked <%}%> ><%=shopResources.getString("input3")%>
                            <!--<br />
                            <input type="checkbox" name="Socket">Южная Америка
                            <br />
                            <input type="checkbox" name="Socket">Африка-->
                        </p>
                        <p>
                            <b><%=shopResources.getString("b5")%></b>
                            <br />
                            <input type="checkbox" name="Vendor" id = "national_park" <%if(isNationalPark) {%> checked <%}%> ><%=shopResources.getString("input6")%>
                            <br />
                            <input type="checkbox" name="Vendor" id = "architecture" <%if(isArchitecture) {%> checked <%}%> ><%=shopResources.getString("input7")%>
                            <br />
                            <input type="checkbox" name="Vendor" id = "non_touristic" <%if(isNonTouristic) {%> checked <%}%> ><%=shopResources.getString("input8")%>
                            <br />
                            <input type="checkbox" name="Vendor" id="museum" <%if(isMuseum) {%> checked <%}%> ><%=shopResources.getString("input9")%>
                            <br />
                            <input type="checkbox" name="Vendor" id="club" <%if(isClub) {%> checked <%}%> ><%=shopResources.getString("input10")%>
                        </p>
                        <input class="apply" type="button" onclick="applyFilters()" value="<%=shopResources.getString("input12")%>">
                        <script>
                            if(<%=firstVisit%>) {
                                applyFilters();
                            }
                        </script>
                    </form>
                </div>
            </div>
            <div class="left">
                <div class="items_container">
                    <%@include file="items.jsp"%>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
