<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set value="${pwk:getPaymentTotalByMonth(param.y,param.m )}" var="total"/>
<jsp:useBean id="now" class="java.util.Date" scope="session"/>
<%--column--%>
<c:set value="${pwk:getPaymentDataByMonth(param.y,param.m)}" var="paymentData"/>
<%--pie--%>
<c:set value="${pwk:getProductShareByMonth(param.y, param.m)}" var="soldProducts"/>
<%--time--%>
<c:set value="${pwk:getTransactionHistory(param.y)}" var="transactionHistory"/>
<html>
<html>
<head>
    <title>Payment List</title>
    <script src="${pageContext.request.contextPath}/js/hightCharts/js/highcharts.js"></script>
    <script src="${pageContext.request.contextPath}/js/hightCharts/js/highcharts-3d.js"></script>
    <script src="${pageContext.request.contextPath}/js/hightCharts/js/modules/exporting.js"></script>
    <script src="${pageContext.request.contextPath}/js/hightCharts/js/modules/data.js"></script>
    <script src="${pageContext.request.contextPath}/js/hightCharts/js/modules/drilldown.js"></script>

</head>
<body>
    <div class="control-group" style="text-align: center;font-size: 16px;">
        <c:set value="${pwk:getPVSum()}" var="pv"/>
        <span style="color: green;">Today's User View:${pv.get('date').get(0).get(0)}(PC),${pv.get('date').get(0).get(1)}(mobile)&nbsp;&nbsp;&nbsp;</span>
        <span style="color: red;">Monthly User View:${pv.get('month').get(0).get(0)}(PC),${pv.get('month').get(0).get(1)}(mobile)&nbsp;&nbsp;&nbsp;</span>
        <span style="color: darkmagenta;">Yearly User View:${pv.get('year').get(0).get(0)}(PC),${pv.get('year').get(0).get(1)}(mobile)<br>&nbsp;&nbsp;&nbsp;</span>
        <span style="color: #800080;" id="online">Online Users:<%=session.getServletContext().getAttribute("online")%></span>
    </div>
    <div class="control-group">
        <div id="container3" style="min-width: 310px; height: 400px; margin: 0 auto">
        </div>
        <div class="input-group col-lg-3">
            <select name="year" id="year" class="form-control">
                <option value="2017" ${param.y eq 2017?'selected':''}>2017</option>
                <option value="2016" ${param.y eq 2016?'selected':''}>2016</option>
                <option value="2015" ${param.y eq 2015?'selected':''}>2015</option>
                <option value="2014" ${param.y eq 2014?'selected':''}>2014</option>
            </select>
            <span class="input-group-addon">Year</span>
            <select name="month" id="month" class="form-control">
                <option value="0" ${param.m eq 0?'selected':''}>全年</option>
                <option value="1" ${param.m eq 1?'selected':''}>1</option>
                <option value="2" ${param.m eq 2?'selected':''}>2</option>
                <option value="3" ${param.m eq 3?'selected':''}>3</option>
                <option value="4" ${param.m eq 4?'selected':''}>4</option>
                <option value="5" ${param.m eq 5?'selected':''}>5</option>
                <option value="6" ${param.m eq 6?'selected':''}>6</option>
                <option value="7" ${param.m eq 7?'selected':''}>7</option>
                <option value="8" ${param.m eq 8?'selected':''}>8</option>
                <option value="9" ${param.m eq 9?'selected':''}>9</option>
                <option value="10" ${param.m eq 10?'selected':''}>10</option>
                <option value="11" ${param.m eq 11?'selected':''}>11</option>
                <option value="12" ${param.m eq 12?'selected':''}>12</option>
            </select>
            <span class="input-group-addon">month</span>
        </div>
    </div>
    <div id="container2" style="min-width: 310px; height: 400px; margin: 0 auto">
    </div>
    <div id="container1" style="min-width: 310px; height: 400px; margin: 0 auto">
    </div>

    <div>
        <h4>Payment List</h4>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
            <tr>
                <th>Count</th>
                <th>Pay Date</th>
                <th>Pay Type</th>
                <th>Order ID</th>
                <th>Total Price</th>
                <th>Payment Fee</th>
                <th>Operation</th>
            </tr>
            <c:forEach items="${pwk:getPaymentListByMonth(param.p, param.s,param.y,param.m)}" var="payment" varStatus="vs">
                <tr>
                    <td class="td2">${vs.count}</td>
                    <td class="td2">${payment.payDate}</td>
                    <td class="td2">${payment.method}</td>
                    <td class="td2"><a href="${pageContext.request.contextPath}/back/order/orderDetail.jsp?id=${payment.orderId}">${payment.orderId}</a> </td>
                    <td class="td2">${payment.totalPrice}</td>
                    <td class="td2">${payment.fee}</td>
                    <td class="td2">
                        <a href="paymentDetail.jsp?id=${payment.id}" class="btn btn-success">Detail</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <c:forEach items="${transactionHistory}" var="history" varStatus="vs">
        ${history.amount}
        ${not vs.last?',':''}
    </c:forEach>
<ul id="page"></ul>

<script>
    var options = {
        bootstrapMajorVersion:3,
        alignment: 'center',
        currentPage: ${empty param.p?1:param.p},
        totalPages: ${(total+10)/10},
        pageUrl: function (type, page, current) {
            return "${pageContext.request.contextPath}/back/payment/paymentList.jsp?s=10&p=" + page;
        }
    };

    $('#page').bootstrapPaginator(options);
</script>
<script>
    $("#month").change(function(){
        var year = $("#year").val();
        var month = $("#month").val();
        window.location.href= '${pageContext.request.contextPath}/back/payment/paymentList.jsp?y='+year+'&m='+month;
    });
</script>
    <script type="text/javascript">
        $(function () {
            $('#container1').highcharts({
                chart: {
                    type: 'column',
                    margin: 75,
                    options3d: {
                        enabled: true,
                        alpha: 10,
                        beta: 25,
                        depth: 70
                    }
                },
                title: {
                    text: 'MyParisBags Sales Data'
                },
                subtitle: {
                    text: '(${paymentData[0].y}年${paymentData[0].m}月)'
                },
                xAxis: {
                    categories: [
                        <c:forEach items="${paymentData}" var="pData" varStatus="vs">
                        '${pData.m}.${pData.day}(${pData.count})'
                        <c:if test="${not vs.last}">,</c:if>
                        </c:forEach>
                    ]
                },
                yAxis: {
                    opposite: true
                },
                tooltip: {
                    pointFormat: '<tr><td style="color:{series.color};padding:0">销量: </td>' +
                    '<td style="padding:0"><b>{point.y}</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0
                    }
                },
                series: [{
                    name: 'MyParisbags',
                    data: [<c:forEach items="${paymentData}" var="d" varStatus="vs">
                        ${d.count}
                        <c:if test="${not vs.last}">,</c:if>
                        </c:forEach> ]
                }]
            });
        });
    </script>
    <script>
        $(function () {
            $('#container2').highcharts({
                chart: {
                    type: 'pie',
                    options3d: {
                        enabled: true,
                        alpha: 45,
                        beta: 0
                    }
                },
                title: {
                    text: 'Brands Share'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        depth: 35,
                        dataLabels: {
                            enabled: true,
                            format: '{point.name}'
                        }
                    }
                },
                series: [{
                    type: 'pie',
                    name: 'Product Share',
                    data:[
                        <c:forEach items="${soldProducts}" var="soldProduct" varStatus="vs">
                        ['${soldProduct.brand_name}',${pwk:getPercentage(soldProduct.count,total )}]${not vs.last?',':''}
                        </c:forEach>
                    ]
                }]
            });
        });
    </script>
    <script type="text/javascript">
        $(function () {
            $('#container3').highcharts({
                chart: {
                    zoomType: 'x'
                },
                title: {
                    text: 'Whole Sale of year ${empty param.y?'2016':param.y}'
                },
                xAxis: {
                    type: 'datetime',
                    minRange: 14 * 24 * 3600000 // fourteen days
                },
                yAxis: {
                    title: {
                        text: 'Sale Revenue'
                    }
                },
                legend: {
                    enabled: false
                },
                plotOptions: {
                    area: {
                        fillColor: {
                            linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
                            stops: [
                                [0, Highcharts.getOptions().colors[0]],
                                [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                            ]
                        },
                        marker: {
                            radius: 2
                        },
                        lineWidth: 1,
                        states: {
                            hover: {
                                lineWidth: 1
                            }
                        },
                        threshold: null
                    }
                },

                series: [{
                    type: 'area',
                    name: 'Revenue',
                    pointInterval: 24 * 3600 * 1000,
                    pointStart: Date.UTC(${param.y eq null?'2016':param.y}, 0),
                    data: [
                        <c:forEach items="${transactionHistory}" var="history" varStatus="vs">
                            ${history.amount}
                            ${not vs.last?',':''}
                        </c:forEach>
                    ]
                }]
            });
        });
    </script>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>