<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta name="google-site-verification" content="steZdC8BUnVNcxcTbYXJiAeEP0XjlI4jNGcZ-Iy_E-w" />
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title>My Paris Bags </title>
    <meta content="MyParisBags,Michael Kors,Longchamp,CK,Burberry,KateSpade,Coach,Tory Burch" name="keyword">
    <meta content="Welcome to My Paris Bags. I am Cherry here, how may i assist you? (whatsApp, WeChat or line: 016-2199981)" name="description">
<link rel="stylesheet" href="css/main.css" type="text/css" />
<link rel="stylesheet" href="fancybox/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />
<link rel="stylesheet" href="css/product-slider.css" type="text/css" />
<link rel="stylesheet" href="superfish/superfish.css" type="text/css" media="screen" />
<link rel="stylesheet" href="css/megamenu.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/scrollable-navig.css">
<link href='css/css1.css' rel='stylesheet' type='text/css' />
<link href='css/css2.css' rel='stylesheet' type='text/css' />
<link href='css/css3.css' rel='stylesheet' type='text/css' />
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery.tools.min.js"></script>
<script type="text/javascript" src="js/jquery.insetBorderEffect.js"></script>
<script type="text/javascript" src="fancybox/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<script type="text/javascript" src="superfish/hoverIntent.js"></script>
<script type="text/javascript" src="superfish/superfish.js"></script>

</head>
<body>
<div id="fb-root"></div>
<script>(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) return;
	js = d.createElement(s); js.id = id;
	js.src = "//connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v2.3";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<div id="container">
	<jsp:include page="include/top.jsp" flush="true"/>
	<div id="content">
		<div class="promo-inner" id="promo">
			<ul id="main_navi">
				<li class="first">
					<img src="${pwk:getPicDomain()}/upload/index1.jpg" width="80" height="60">
					<span class="title">New Arrival</span>
					new arrival on 15/07/16
				</li>
				<li class="">
					<img src="${pwk:getPicDomain()}/upload/index2.jpg"  width="80" height="60">
					<span class="title">New Arrival</span>
                    new arrival on 01/08/16
				</li>
				<li class="active">
					<img src="${pwk:getPicDomain()}/upload/index3.jpg">
					<span class="title">My Paris Bags</span>
					new arrival on 10/08/16
				</li>
				<li class="last">
					<img src="${pwk:getPicDomain()}/upload/index4.jpg">
					<span class="title">100% Authentic</span>
                    100% authentic Michael Kors Selma Top-Zip Grommet Satchel
				</li>
			</ul>
			<div id="main">
				<div style="top: -940px;" id="pages">
					<div class="page">
						<div class="scrollable">
							<div class="items">
								<div class="item">
									<img src="${pwk:getPicDomain()}/upload/index1.jpg" height="330" width="750">
								</div>
								</div>
						</div>
					</div>
					<div class="page">
						<div class="scrollable">
							<div class="items">
							<div class="item">
									<img src="${pwk:getPicDomain()}/upload/index2.jpg" width="750" height="330">
								</div>
							</div>
						</div>
					</div>
					<div class="page">
						<div class="scrollable">
							<div class="items">
								<div class="item">
									<img src="${pwk:getPicDomain()}/upload/index3.jpg" width="750" height="330">
								</div>
							</div>
						</div>
					</div>
					<div class="page">
						<div class="scrollable">
							<div class="items">
							<div class="item">
									<img src="${pwk:getPicDomain()}/upload/index4.jpg" width="750" height="330">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="shadow"></div>
		<div class="message">
			${pwk:getIndexInfoById(2).content}
		</div>
		<div class="content-top">
		</div>
        <c:set value="${pwk:getBrandsByStatus(1)}" var="brands"/>
		<div class="content-inner home" style="min-height: 0;">
			<div id="slider-container">
				<div class="slider" style="height: 70px;">
				   <div class="items">
					  <div class="group-items">
                          <c:forEach items="${brands}" var="brand" begin="0" end="6">
                              <div class="single-item1">
                                  <a href="grid_${brand.id}.html" target="_blank" title="${brand.brandName}">
                                      <c:forEach items="${brand.picPath}" var="pic" begin="0" end="0">
                                         <img src="${pwk:getPicDomain()}/${pic.path}" alt="Item" style="width: 100px;height: 50px;"/>
                                      </c:forEach>
                                  </a>
                                  <br class="clear"/>
                              </div>
                          </c:forEach>
					  </div>
				   </div>
				</div>
				<br class="clear"/>
			</div>

			<div id="slider-container">
				<div class="slider" style="height: 70px;">
					<div class="items">
						<div class="group-items">
							<c:forEach items="${brands}" var="brand" begin="7" end="13">
								<div class="single-item1">
									<a href="grid_${brand.id}.html" target="_blank">
										<c:forEach items="${brand.picPath}" var="pic" begin="0" end="0">
											<img src="${pwk:getPicDomain()}/${pic.path}" alt="Item" style="width: 100px;height: 50px;"/>
										</c:forEach>
									</a>
									<br class="clear"/>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<br class="clear"/>
			</div>

			<div id="slider-container">
				<div class="slider" style="height: 70px;">
					<div class="items">
						<div class="group-items">
							<c:forEach items="${brands}" var="brand" begin="14" end="20">
								<div class="single-item1">
									<a href="grid_${brand.id}.html" target="_blank">
										<c:forEach items="${brand.picPath}" var="pic" begin="0" end="0">
											<img src="${pwk:getPicDomain()}/${pic.path}" alt="Item" style="width: 100px;height: 50px;"/>
										</c:forEach>
									</a>
									<br class="clear"/>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<br class="clear"/>
			</div>

			<div id="slider-container">
				<div class="slider" style="height: 70px;">
					<div class="items">
						<div class="group-items">
							<c:forEach items="${brands}" var="brand" begin="21" end="27">
								<div class="single-item1">
									<a href="grid_${brand.id}.html" target="_blank">
										<c:forEach items="${brand.picPath}" var="pic" begin="0" end="0">
											<img src="${pwk:getPicDomain()}/${pic.path}" alt="Item" style="width: 100px;height: 50px;"/>
										</c:forEach>
									</a>
									<br class="clear"/>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<br class="clear"/>
			</div>

			<div id="slider-container">
				<div class="slider" style="height: 70px;">
					<div class="items">
						<div class="group-items">
							<c:forEach items="${brands}" var="brand" begin="28" end="34">
								<div class="single-item1">
									<a href="grid_${brand.id}.html" target="_blank">
										<c:forEach items="${brand.picPath}" var="pic" begin="0" end="0">
											<img src="${pwk:getPicDomain()}/${pic.path}" alt="Item" style="width: 100px;height: 50px;"/>
										</c:forEach>
									</a>
									<br class="clear"/>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<br class="clear"/>
			</div>

		</div>
		<div class="shadow"></div>

		<div class="content-top">
		</div>
		<c:set value="${pwk:getProductByList(1,12,false )}" var="indexProducts"/>
		<div class="content-inner home">

			<div id="slider-container">
				<div class="slider">
					<div class="items">
						<div class="group-items">
							<c:forEach items="${indexProducts}" var="indexProduct1" begin="0" end="3">
								<div class="single-item">
									<span class="title"><a href="details_${indexProduct1.id}.html" target="_blank" title="${indexProduct1.name}">${fn:substring(indexProduct1.name, 0, 20)}</a></span>
									<span class="price">RM <fmt:formatNumber value="${indexProduct1.price}" type="currency" pattern="###,##0.00"/></span>
									<a href="details_${indexProduct1.id}.html" target="_blank">
										<c:forEach items="${indexProduct1.picPath}" var="pic" begin="0" end="0">
											<img src="${pwk:getPicDomain()}/${pic.miniPath}" alt="Item" height="180" width="180"/>
										</c:forEach>
									</a>
									<a href="details_${indexProduct1.id}.html" target="_blank" class="general-button float-left"><span class="button">Details</span></a>
							<span class="list-link">
								<a href="grid_${indexProduct1.brand.id}.html" class="regular" target="_blank">View more...</a>
							</span>
									<br class="clear"/>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<br class="clear"/>
			</div>

			<div id="slider-container">
				<div class="slider">
					<div class="items">
						<div class="group-items">
							<c:forEach items="${indexProducts}" var="indexProduct3" begin="4" end="7">
								<div class="single-item">
									<span class="title"><a href="details_${indexProduct3.id}.html" target="_blank" title="${indexProduct3.name}">${fn:substring(indexProduct3.name, 0, 20)}</a></span>
									<span class="price">RM <fmt:formatNumber value="${indexProduct3.price}" type="currency" pattern="###,##0.00"/></span>
									<a href="details_${indexProduct3.id}.html" target="_blank">
										<c:forEach items="${indexProduct3.picPath}" var="pic" begin="0" end="0">
											<img src="${pwk:getPicDomain()}/${pic.miniPath}" alt="Item" height="180" width="180"/>
										</c:forEach>
									</a>
									<a href="details_${indexProduct3.id}.html" target="_blank" class="general-button float-left"><span class="button">Details</span></a>
							<span class="list-link">
								<a href="grid_${indexProduct3.brand.id}.html" class="regular" target="_blank">View more...</a>
							</span>
									<br class="clear"/>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<br class="clear"/>
			</div>

			<div id="slider-container">
				<div class="slider">
					<div class="items">
						<div class="group-items">
							<c:forEach items="${indexProducts}" var="indexProduct5" begin="8" end="11">
								<div class="single-item">
									<span class="title"><a href="details_${indexProduct5.id}.html" target="_blank" title="${indexProduct5.name}">${fn:substring(indexProduct5.name, 0, 20)}</a></span>
									<span class="price">RM <fmt:formatNumber value="${indexProduct5.price}" type="currency" pattern="###,##0.00"/></span>
									<a href="details_${indexProduct5.id}.html" target="_blank">
										<c:forEach items="${indexProduct5.picPath}" var="pic" begin="0" end="0">
											<img src="${pwk:getPicDomain()}/${pic.miniPath}" alt="Item" height="180" width="180"/>
										</c:forEach>
									</a>
									<a href="details_${indexProduct5.id}.html" target="_blank" class="general-button float-left"><span class="button">Details</span></a>
							<span class="list-link">
								<a href="grid_${indexProduct5.brand.id}.html" class="regular" target="_blank">View more...</a>
							</span>
									<br class="clear"/>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<br class="clear"/>
			</div>
		</div>
		<div class="shadow"></div>
	</div>
    <jsp:include page="include/bottom.jsp" flush="true"/>
</div>
<div id="float_right">
	<div class="fb-page" data-href="https://www.facebook.com/myparisbagsofficial" data-width="140" data-height="590" data-hide-cover="false" data-show-facepile="true" data-show-posts="true"></div>
</div>
<div id="float_left">
	<img src="${pwk:getPicDomain()}/upload/code.png" alt="" style="max-width:150px"/>
</div>
<div id="float_left_top">
	<img src="/images/contact.jpg" alt="" style="max-width:150px"/>
</div>
<script type="text/javascript">
	function scrollx(p) {
		var d = document, dd = d.documentElement, db = d.body, w = window, o = d.getElementById(p.id), ie6 = /msie 6/i.test(navigator.userAgent), style, timer;
		if (o) {
			cssPub = ";position:"+(p.f&&!ie6?'fixed':'absolute')+";"+(p.t!=undefined?'top:'+p.t+'px;':'bottom:0;');
			if (p.r != undefined && p.l == undefined) {
				o.style.cssText += cssPub + ('right:'+p.r+'px;');
			} else {
				o.style.cssText += cssPub + ('margin-left:'+p.l+'px;');
			}
			if(p.f&&ie6){
				cssTop = ';top:expression_r(documentElement.scrollTop +'+(p.t==undefined?dd.clientHeight-o.offsetHeight:p.t)+'+ "px" );';
				cssRight = ';right:expression_r(documentElement.scrollright + '+(p.r==undefined?dd.clientWidth-o.offsetWidth:p.r)+' + "px")';
				if (p.r != undefined && p.l == undefined) {
					o.style.cssText += cssRight + cssTop;
				} else {
					o.style.cssText += cssTop;
				}
				dd.style.cssText +=';background-image: url(about:blank);background-attachment:fixed;';
			}else{
				if(!p.f){
					w.onresize = w.onscroll = function(){
						clearInterval(timer);
						timer = setInterval(function(){
							var st = (dd.scrollTop||db.scrollTop),c;
							c = st - o.offsetTop + (p.t!=undefined?p.t:(w.innerHeight||dd.clientHeight)-o.offsetHeight);
							if(c!=0){
								o.style.top = o.offsetTop + Math.ceil(Math.abs(c)/10)*(c<0?-1:1) + 'px';
							}else{
								clearInterval(timer);
							}
						},10)
					}
				}
			}
		}
	}
</script>
<script>
	scrollx({id:'float_right', r:0, t:130, f:1});
	scrollx({id:'float_left', l:0, t:250, f:1});
	scrollx({id:'float_left_top', l:0, t:130, f:1});
</script>
<script type="text/javascript">
	$(function() {
		var $menu = $('#ldd_menu');
	$(document).ready(function() {
		$("#main_navi li img").insetBorder({
			borderColor : '#EDE6E9',
			inset: 4
		});
		$('ul.sf-menu').superfish({
			delay: 100
		});
		$(".slider").scrollable({
			next: '.next2',
			prev: '.prev2'
		});
		$("a.grouped-elements").fancybox({
			'titlePosition'	: 'inside'
		});
		$("a[rel=group4]").fancybox({
			'transitionIn'		: 'none',
			'transitionOut'		: 'none',
			'titlePosition' 	: 'over',
			'titleFormat'		: function(title, currentArray, currentIndex, currentOpts) {
				return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
			}
		});
		$("a.grouped-elements").hover(function() {
			  $(this).find(".imagehover").toggleClass("mouseon");
		});
	});
	$(window).load(function() {
		$("#main").scrollable({
			vertical: true,
			keyboard: 'static',
			onSeek: function(event, i) {
				horizontal.eq(i).data("scrollable").focus();
			}
		}).navigator("#main_navi");
		var horizontal = $(".scrollable").scrollable({ circular: true }).navigator(".navi");
		horizontal.eq(0).data("scrollable").focus();
	});
	});
</script>
<c:if test="${param.t eq 'login'}">
      <script>
          login('${param.url}');
      </script>
</c:if>

</body>
</html>