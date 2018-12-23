<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="${pageContext.request.contextPath}/bootstrap/js/jquery.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var range = 50;             //距下边界长度/单位px
            var elemt = 500;           //插入元素高度/单位px
            var maxnum = 20;            //设置加载最多次数
            var num = 1;
            var totalheight = 0;
            var main = $("#content");                     //主体元素
            $(window).scroll(function () {
                var srollPos = $(window).scrollTop();    //滚动条距顶部距离(页面超出窗口的高度)

                //console.log("滚动条到顶部的垂直高度: "+$(document).scrollTop());
                //console.log("页面的文档高度 ："+$(document).height());
                //console.log('浏览器的高度：'+$(window).height());

                totalheight = parseFloat($(window).height()) + parseFloat(srollPos);
                if (($(document).height() - range) <= totalheight && num != maxnum) {
                    main.append("<div style='border:1px solid tomato;margin-top:20px;color:#ac" + (num % 20) + (num % 20) + ";height:" + elemt + "' >hello world" + srollPos + "---" + num + "</div>");
                    num++;
                }
            });
        });
    </script>
</head>
<body>
<div class='list-items'>
    <span class='title'>
        <a href='details_5.html' target='_blank' title='Longchamp-pink'>Longchamp-pink</a>
    </span>
    <span class='price'>RM 730.0</span>
    <a href='details_5.html' target='_blank'>
        <img src='/upload/product/2014-2-18/1392732988191.jpg' alt='Item' width='180' height='180'/>
    </a>
    <span class='list-link'>
        <a href='details_5.html' class='general-button float-left'><span class='button'>Detail</span></a>
    </span><br class='clear'/>
</div><span class='title'><a href='details_15.html' target='_blank' title='Longchamp-blue'>Longchamp-blue</a></span><span class='price'>RM 0.0</span><a href='details_15.html' target='_blank'><img src='/upload/product/2014-3-1/1393737252977.jpg' alt='Item' width='180' height='180'/></a><span class='list-link'><a href='details_15.html' class='general-button float-left'><span class='button'>Detail</span></a></span><br class='clear'/></div><br class='clear'/></div>

</body>
</html>