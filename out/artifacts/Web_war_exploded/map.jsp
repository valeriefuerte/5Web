<%--
  Created by IntelliJ IDEA.
  User: valerie
  Date: 18.11.17
  Time: 15:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<%@ taglib prefix='util' uri='/WEB-INF/tld/util' %>

<fmt:setLocale value="${lang}"/>
<c:set var="lang" value="${util:getLang(pageContext.request, pageContext.response)}"/>

<c:if test="${empty sessionScope.purchaces}">
    <c:redirect url="/"/>
</c:if>
<c:if test="${empty sessionScope.username}">
    <c:redirect url="/login"/>
</c:if>

<c:choose>
    <c:when test="${lang eq 'en'}">
        <c:set var="points" value="${['Passage', 'ETU', 'Pulkovo']}" />
    </c:when>
    <c:when test="${lang eq 'fi'}">
        <c:set var="points" value="${['Käytävä', 'ETU', 'Pulkovo']}" />
    </c:when>
    <c:otherwise>
        <c:set var="points" value="${['Пассаж', 'ЛЭТИ', 'Пулково']}" />
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
<head>
    <title>
        Travell with InfinitoFuerte</title>
    <link rel="stylesheet" type="text/css" href="static/index.css">
    <script src="https://api-maps.yandex.ru/2.0-stable/?load=package.full&lang=ru-RU" type="text/javascript"></script>
    <script>
        function changeLanguage(lang) {
            window.location.href = "?lang=" + lang;
        }

        var myMap;
        ymaps.ready(function () {
        myMap = new ymaps.Map("YMapsID", {
            center: [59.96, 30.18],
            zoom: 10,
            type: 'yandex#map'
        });

        myPlacemarkCollection = new ymaps.GeoObjectCollection(),
        lastOpenedBalloon = false;
        var firstPoint = new ymaps.Placemark([59.935187, 30.334355], { iconContent: '${points[0]}', balloonContent: '${points[0]}', myId: 'firstPoint' }, {preset: 'twirl#greyStretchyIcon'});
        var secondPoint = new ymaps.Placemark([59.971226, 30.320039], { iconContent: '${points[1]}', balloonContent: '${points[1]}', myId: 'secondPoint' }, {preset: 'twirl#greyStretchyIcon'});
        var thirdPoint = new ymaps.Placemark([59.799534, 30.271511], { iconContent: '${points[2]}', balloonContent: '${points[2]}', myId: 'thirdPoint' }, {preset: 'twirl#greyStretchyIcon'});

        myMap.controls
            .add('typeSelector')
            .add('smallZoomControl');

        //myMap.events.add(['balloonclose'], setLocationHash);
        // Обработка событий открытия балуна для любого элемента коллекции.
        // В данном случае на карте находятся только метки одной коллекции.
        // Чтобы обработать события любых геообъектов карты можно использовать
        // myMap.geoObjects.events.add(['balloonopen'],function (e) { ...

        if(deliveryType() == 'from_here') {
            myPlacemarkCollection
                .add(firstPoint)
                .add(secondPoint)
                .add(thirdPoint);
            myMap.geoObjects.add(myPlacemarkCollection);
            myPlacemarkCollection.events.add(['balloonopen'], function (e) {
                lastOpenedBalloon = e.get('target').properties.get('myId');
                setLocationHash();
                });
            setMapStateByHash();

            document.getElementById('delivery_from_here_radio_button').checked = true;
                show_shops_addresses();
        } else {
                myMap.controls.add('searchControl');
                document.getElementById('delivery_by_courier_radio_button').checked = true;
                hide_shops_addresses();

                myMap.events.add(['balloonopen'], function (e) {
                    var t = document.getElementsByClassName("ymaps-b-balloon__content-body")[0];
                    lastOpenedBalloon = t.getElementsByTagName("h3")[0].innerHTML;
                    setLocationHash();
                });
        }

        });

        function deliveryType() {
            if(window.location.href.includes('courier')) {
                return 'courier';
            } else {
                return 'from_here';
            }
        }

        function show_shops_addresses() {
            document.getElementById('delivery_address_form').style.display = 'block';
        }

        function hide_shops_addresses() {
            document.getElementById('delivery_address_form').style.display = 'none';
        }

        // Получение значение параметра name из адресной строки браузера.
        function getParam (name, location) {
            location = location || window.location.hash;
            var res = location.match(new RegExp('[#&]' + name + '=([^&]*)', 'i'));
            return (res && res[1] ? res[1] : false);
        }

        // Передача параметров, описывающих состояние карты в адресную строку браузера.

        function setLocationHash () {
            var params = [];
            if (myMap.balloon.isOpen()) {
                params.push('open=' + lastOpenedBalloon);
                show_list_item(lastOpenedBalloon);
            }
            window.location.hash = params.join('&');
        }



        function show_list_item(lastOpenedBalloon) {
            myPlacemarkCollection.each(function (geoObj) {
                var id = geoObj.properties.get('myId');
                if (id == lastOpenedBalloon) {
                    var adresses = document.getElementById('addresses');
                    var current_address = geoObj.properties.get('balloonContent');
                    adresses.value = current_address;
                }
            });
        }


        function setMapStateByHash () {
            var open = getParam('open');
            if (open) {
                myPlacemarkCollection.each(function (geoObj) {
                    var id = geoObj.properties.get('myId');
                    if (id == open) {
                        geoObj.balloon.open();
                    }
                });
            }
        }

        function show_balloon() {
            var addresses = document.getElementById('addresses');
            var current_address = addresses.value;
            myPlacemarkCollection.each(function (geoObj) {
                var content = geoObj.properties.get('balloonContent');
                if (content == current_address) {
                    var current_id = geoObj.properties.get('myId');
                    lastOpenedBalloon = current_id;
                    params = [];
                    params.push('open=' + lastOpenedBalloon);
                    window.location.hash = params.join('&');
                    setMapStateByHash();
                }
            });
        }

        function submitOrder() {
            location.href =
                'order_success.jsp?delivery=' + (deliveryType() === "courier")
                + "&address=" + getParam('open');
        }

    </script>
</head>
<body>
<%@ include file="header.jsp"%>
<meta charset="UTF-8">
<div class="container">
    <div class="main">
        <h1>
            <fmt:setBundle basename="strings"/>
            <fmt:message key="h1M"/>
        </h1>
        <div class="right">
            <button class="next_step" onclick="submitOrder();">
                <fmt:setBundle basename="strings"/>
                <fmt:message key="button1M"/>
            </button>
        </div>
        <div class="left">
            <form id="delivery_type_form" class="delivery_type_form" method="get">
                <h3>
                    <fmt:setBundle basename="strings"/>
                    <fmt:message key="h2M"/>
                </h3>
                <input type="radio" name="delivery_type" value="from_here"  id="delivery_from_here_radio_button"> <fmt:setBundle basename="strings"/><fmt:message key="input1M"/> </input>
                <input type="radio" name="delivery_type" value="courier" id="delivery_by_courier_radio_button"> <fmt:setBundle basename="strings"/><fmt:message key="input2M"/> </input>
                <br />

                <button onclick="show_shops_addresses()" class="submit">
                    <fmt:setBundle basename="strings"/>
                    <fmt:message key="button2M"/>
                </button>
            </form>

            <form id="delivery_address_form" class="delivery_address_form">
                <h3>
                    <fmt:setBundle basename="strings"/>
                    <fmt:message key="h3M"/>
                </h3>
               <select id="addresses">
                    <option value="${points[0]}" >${points[0]}</option>
                    <option value="${points[1]}">${points[1]}</option>
                    <option value="${points[2]}">${points[2]}</option>
                </select>

                <br />

                <button onclick="show_balloon()" class="choose">
                    <fmt:setBundle basename="strings"/>
                    <fmt:message key="button3M"/>
                </button>
            </form>
        </div>
        <div id="YMapsID" style="width: 100%; height: 750px"></div>
    </div>
</div>
</body>
</html>
