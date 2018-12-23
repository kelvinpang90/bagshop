<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:redirect url="grid_${param.id}.html"/>
<c:set value="${pwk:getBrandsByStatus(1)}" var="brands"/>
<c:set value="${pwk:getBrandById(param.bId)}" var="currentBrand"/>
<c:if test="${currentBrand.status ne 1}">
    <c:redirect url="${pageContext.request.contextPath}/index.html"/>
</c:if>
<c:set value="${pwk:getHotSaleByBrandId(param.bId,1 ,7 )}" var="hotSales"/>
<c:set value="${pwk:getProductByBrandId(param.bId,param.p ,9,false )}" var="products"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>${empty currentBrand.brandName?'All Products':currentBrand.brandName} &middot; My Paris Bags</title>
<!-- Main style -->
<link rel="stylesheet" href="css/main.css" type="text/css" />

<!-- Fancybox style -->
<link rel="stylesheet" href="fancybox/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />

<!-- Product slider style -->
<link rel="stylesheet" href="css/product-slider.css" type="text/css" /> 

<!-- Style for the superfish navigation menu -->
<link rel="stylesheet" href="superfish/superfish.css" type="text/css" media="screen" />

<!-- Style for Megamenu -->
<link rel="stylesheet" href="css/megamenu.css" type="text/css" /> 

<!-- Style for price range slider -->
<link rel="stylesheet" href="jQueryUI/css/redmond/jquery-ui-1.7.1.custom.css" type="text/css" />
<link rel="Stylesheet" href="jQueryUI/css/ui.slider.extras.css" type="text/css" />

<!-- Style for Custom Forms -->
<link rel="stylesheet" href="uniform/css/uniform.default.css" type="text/css" media="screen" charset="utf-8" />

<!-- Google font -->
<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css' />
<link href='http://fonts.googleapis.com/css?family=Qwigley' rel='stylesheet' type='text/css' />
<link href='http://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css' />

<!-- JS for jQuery -->
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>

<!-- JS for jQuery Product slider -->
<script type="text/javascript" src="js/jquery.tools.min.js"></script>

<!-- JS for jQuery Border effect -->
<script type="text/javascript" src="js/jquery.insetBorderEffect.js"></script>

<!-- JS for jQuery Fancy Box -->
<script type="text/javascript" src="fancybox/fancybox/jquery.fancybox-1.3.4.pack.js"></script>

<!-- JS for superfish navigation menu -->
<script type="text/javascript" src="superfish/hoverIntent.js"></script> 
<script type="text/javascript" src="superfish/superfish.js"></script> 

<!-- JS for Collapsible Menu -->
<script type="text/javascript" src="js/jquery.collapse.js"></script> 

<!-- JS for price range slider -->
<script type="text/javascript" src="jQueryUI/js/jquery-ui-1.7.1.custom.min.js"></script>
<script type="text/javascript" src="jQueryUI/js/selectToUISlider.jQuery.js"></script>

<!-- JS for Custom Forms -->
<script src="uniform/jquery.uniform.js" type="text/javascript"></script>

<script type="text/javascript">
	
	// Megamenu
	$(function() {
						
		var $menu = $('#ldd_menu');
		
		$menu.children('li').each(function(){
			var $this = $(this);
			var $span = $this.children('span');
			$span.data('width',$span.width());
			
			$this.bind('mouseenter',function(){
				$menu.find('.ldd_submenu').stop(true,true).hide();
				$span.stop().animate({'width':'auto'},150,function(){
					$this.find('.ldd_submenu').slideDown(300);
				});
			}).bind('mouseleave',function(){
				$this.find('.ldd_submenu').stop(true,true).hide();
				$span.stop().animate({'width':$span.data('width')+'px'},300);
			});
		});
	});
	
	$(document).ready(function() {
		
	// Custom forms
		$(function(){ 
			$("input:checkbox, input:radio").uniform();
		});
		
		// Border effects
		$(".featured-product-item img").insetBorder({
			borderColor : '#EDE6E9',
			inset: 5
		});
		
		// Navigation menu
		$("ul.sf-menu").superfish(); 
		
		// Collapsible menu
		$("#lhs, #features .box").collapse({
        show: function() {
            this.animate({opacity: 'toggle', height: 'toggle'}, 300);
        },
        hide : function() {
            this.animate({opacity: 'toggle', height: 'toggle'}, 300);
        }
    });
		
		// Slider
		$(".slider").scrollable();
	
		// Fancybox
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
		
		// Mouseover effect for thumbnails
		$("a.grouped-elements").hover(function() {
			  $(this).find(".imagehover").toggleClass("mouseon");
		});
		
		// Price range
			$('select#valueA, select#valueB').selectToUISlider();

		// Dropdown show/hide
		jQuery(".dropdown").click(function() {

      	jQuery(this).find("ul").toggle();
      	jQuery(this).find("a.nav-link").toggleClass('selected');
      });
      
		// Closing the menu if click outside
		jQuery(document).bind('click', function(e) {
			var $clicked = jQuery(e.target);
          
			if (! $clicked.parents().hasClass("dropdown")) {
				jQuery(this).find('.dropdown a.nav-link').removeClass("selected");
				jQuery(".dropdown ul").hide();
			}
          
		});
      
	});

	$(window).load(function() {
		
	});
		
</script>

</head>
<body>

<div id="container">

	<jsp:include page="include/top.jsp" flush="true"/>

	<div id="content">
	
		<div class="content-top"></div>
		<div class="content-inner">
			
			<!-- List Begin -->

            <div class="breadcrumbs">
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="list_0.html">All Product</a></li>
                    <c:if test="${not empty param.bId}">
                        <li class="last">${currentBrand.brandName}</li>
                    </c:if>
                </ul>
                <br class="clear"/>
            </div>
			
				<!-- Left Column Begin -->
			<div id="lhs" class="left-side float-left">
                <h3 class="active">Brands</h3>
                <ul>

                    <c:forEach items="${brands}" var="brand">
                        <c:if test="${brand.id eq param.bId}">
                            <li>${brand.brandName}</li>
                        </c:if>
                        <c:if test="${brand.id ne param.bId}">
                            <li><a href="list_${brand.id}.html">${brand.brandName}</a></li>
                        </c:if>
                    </c:forEach>
                </ul>
				
				<%--<h3 class="active">Price Range</h3>--%>
				
				<!-- Price Slider Begin -->
				<div class="price-range">
					<fieldset>
						<label for="valueA">From:</label>
						<select name="valueA" id="valueA">
							<option value="$0">$0</option>
							<option value="$10">$10</option>
							<option value="$20">$20</option>
							<option value="$30" selected="selected">$30</option>
							<option value="$40">$40</option>
							<option value="$50">$50</option>
							<option value="$100">$100</option>
							<option value="$200">$200</option>
							<option value="$400">$400</option>
							<option value="$600">$600</option>
						</select>
				
						<label for="valueB">To:</label>
						<select name="valueB" id="valueB">
							<option value="$0">$0</option>
							<option value="$10">$10</option>
							<option value="$20">$20</option>
							<option value="$30">$30</option>
							<option value="$40">$40</option>
							<option value="$50">$50</option>
							<option value="$100" selected="selected">$100</option>
							<option value="$200">$200</option>
							<option value="$400">$400</option>
							<option value="$600">$600</option>
						</select>
					</fieldset>
				</div>
				<!-- Price Slider End -->
				
				<!-- Featured Products Begin -->
				<h3 class="active">Featured Products</h3>

                <div class="featured-product">
                    <c:forEach items="${hotSales}" var="hotSale">
                        <div class="featured-product-item">
                            <a href="${pageContext.request.contextPath}/details_${hotSale.product.id}.html" class="float-left"><img src="${pageContext.request.contextPath}/${pwk:getPics(hotSale.product.pic)[0]}"  height="80px" width="80px" border="0" /></a>
                            <span class="title"><a href="details_${hotSale.product.id}.html" title="${hotSale.product.name}">${fn:substring(hotSale.product.name, 0, 20)}</a></span>
                            <span class="price">RM ${hotSale.product.price}</span>
                        </div>
                        <br class="clear"/>
                    </c:forEach>
                </div>
				<!-- Featured Products Begin -->
				
			</div>
			<!-- Left Column End -->
			
			<!-- Main Column Begin -->
			<div class="main-content">
				<h3>Display as List</h3>
				
				<div class="list-options">
					<div class="float-left">
						<img src="images/icon_grid.png"/><a href="grid_${param.bId}.html" class="regular">View as grid</a>
						<img src="images/icon_list.png"/><span>View as list</span>
					</div>
				</div>

					<c:forEach items="${products}" var="product" begin="0" end="8">
                        <div class="single-list-item">
                            <a href="details_${product.id}.html" target="_blank"><img src="${pageContext.request.contextPath}/${pwk:getPics(product.pic)[0]}" width="180" height="180" class="float-left" border="0" alt="Item"/></a>
                            <div class="text-info">
                                <span class="title"><a href="details_${product.id}.html" target="_blank">${product.name}</a></span>
                                <span class="price">RM ${product.price}</span>
                                <span class="description">
                                    ${fn:substring(product.description,0 ,150 )}
                                </span>
                            </div>
                        </div>
					</c:forEach>

				
			</div>
			<!-- Main Column End -->
			
			<br class="clear"/>
			
			<!-- List End -->
			
		</div>
		<div class="shadow"></div>
		
		<br class="clear"/>
	</div>

    <jsp:include page="include/bottom.jsp" flush="true"/>
</div>


</body>
</html>