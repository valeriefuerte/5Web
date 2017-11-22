<%--
  Created by IntelliJ IDEA.
  User: valerie
  Date: 23.10.17
  Time: 12:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Travell with InfinitoFuerte</title>
    <link rel="stylesheet" text="text/css" href="static/product.css">
    <script type="text/javascript" src="static/product.js"></script>
</head>

<body>
<h1>Путешествия, туры, путевки. Интернет - магазин</h1>
<a href="?lang">ru</a>
<a href="?lang=en">en</a>
<a href="?lang=fi">fi</a>
<h2>Санкт-Петербург и Ленинградская область</h2>
<div class="table">
    <button class="inactivetab" id="info" onclick="showElement('info_content'); highlight(this)">Краткая информация</button>
    <button class="inactivetab" id="characteristic" onclick="showElement('characteristic_content');highlight(this)">Характеристки</button>
    <button class="inactivetab" id="review" onclick="showElement('review_content');highlight(this)">Отзывы</button>

    <div id="info_content" class = "tabcontent">
        <img src="static/tower.jpg" width = "180px" height = "250px" align="right" alt = "Телевышка">
        <p>Предлагаем посетить один из самых красивых городов мира.</p>
        <p>Почему Вам стоит путешествовать с нами?</p>
        <ul class="info_content">
            <li>Отличные цена</li>
            <li>Комфортное размещение в центре города</li>
            <li>Трансфер из аэропорта или вокзала до отеля</li>
            <li>Только самое интересное</li>
            <li>Море впечатлений</li>
            <li>Хорошие отзывы</li>
        </ul>
        <p>По желанию заказчика возможно изменение или составление индивидуальной экскурсионной программы, бронирование билетов в театры Петербурга и Петербургский цирк, посещение музеев, океанариума и многого другого.</p>
        <br>
    </div>
    <div id="characteristic_content" class="tabcontent">
        <h4>В программу выходного дня входит:</h4>
        <p>09.00 Прибытие в город</p>
        <p>10.00 Прогулка по центру</p>
        <p>14.00 Обед</p>
        <p>16.00 Экскурсия</p>
        <p>19.00 Театр</p>
        <p>22.00 Ужин</p>
        <p>23.00 Отдых</p>
        <br>
        <p>Для уточнения цены свяжитесь с нами.</p>
    </div>
    <div id="review_content" class="tabcontent">
        <div class="review">
            <h4>Василий</h4>
            <p>Поехал на выходные. Успел посмотреть совсем мало, теперь хочу вернуться. Советую посетить экскурсию в Юсуповском дворце.</p>
        </div>
        <div class="review_last">
            <h4>Алина</h4>
            <p>Всем туристам, которые когда-либо планируют наведаться в Санкт-Петербург, я советую наряду с такими музеями, как Эрмитаж и Кунсткамера, посетить ещё и Русский музей. Где ещё вы можете увидеть такое количество картин, знакомых нам с детства? Это и монументальный «Последний день Помпеи» Брюллова, и бушующий «Девятый вал» Айвазовского, и величавая «Корабельная роща» Шишкина, и многое-многое другое из того, что мы знаем и любим.</p>
        </div>
    </div>
</div>
<button class="buy">Купить</button>
</body>
</html>
