<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pwk:getProductById(param.id,false)}" var="product"/>
<c:if test="${empty product}">
    <c:redirect url="${pageContext.request.contextPath}/index.html"/>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>${product.name} &middot; My Paris Bags</title>
<!-- Main style -->
<link rel="stylesheet" href="css/main.css" type="text/css" />

<!-- Fancybox style -->
<link rel="stylesheet" href="fancybox/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />

<!-- Product slider style -->
<link rel="stylesheet" href="css/product-slider.css" type="text/css" />

<!--[if IE 6]>
	<link rel="stylesheet" href="css/ie6.css" type="text/css" media="screen" />
<![endif]-->

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

<!-- JS for price range slider -->
<script type="text/javascript" src="jQueryUI/js/jquery-ui-1.7.1.custom.min.js"></script>
<script type="text/javascript" src="jQueryUI/js/selectToUISlider.jQuery.js"></script>

<!-- JS for Collapsible Menu -->
<script type="text/javascript" src="js/jquery.collapse.js"></script> 

<!-- Style for product gallery -->
<link href="exposure/exposure.css" type="text/css" rel="stylesheet" />
		
<!-- JS for product gallery -->
<script src="exposure/jquery.exposure.js" type="text/javascript"></script>

<!-- JS for Custom Forms -->
<script src="uniform/jquery.uniform.js" type="text/javascript"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
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
	
	// Tabs
	$(function() {
			$("ul.tabs").tabs("div.panes > .tab-content");
	});
	
	$(document).ready(function() {
		
		// Exposure product image gallery
		$(function(){
				var gallery = $('#images');
				gallery.exposure({controlsTarget : '#controls',
					imageControls : false,
					controls : { prevNext : false, pageNumbers : false, firstLast : false },
					pageSize : 5,
					enableSlideshow: false,
					showCaptions: false,
					slideshowControlsTarget : '#slideshow',
					onThumb : function(thumb) {
						var li = thumb.parents('li');				
						var fadeTo = li.hasClass($.exposure.activeThumbClass) ? 1 : 0.7;
						
						thumb.css({display : 'none', opacity : fadeTo}).stop().fadeIn(200);
						
						thumb.hover(function() { 
							thumb.fadeTo('fast',1); 
						}, function() { 
							li.not('.' + $.exposure.activeThumbClass).children('img').fadeTo('fast', 0.7); 
						});
					},
					onImageHoverOver : function() {
						if (gallery.imageHasData()) {						
							// Show image data as an overlay when image is hovered.
							gallery.dataElement.stop().show().animate({bottom:0+'px'},{queue:false,duration:160});
						}
					},
					onImageHoverOut : function() {
						// Slide down the image data.
						var imageDataBottom = -gallery.dataElement.outerHeight();
						gallery.dataElement.stop().show().animate({bottom:imageDataBottom+'px'},{queue:false,duration:160});
					},
					onImage : function(image, imageData, thumb) {
						var w = gallery.wrapper;
						
						// Fade out the previous image.
						image.siblings('.' + $.exposure.lastImageClass).stop().fadeOut(500, function() {
							$(this).remove();
						});
						
						// Fade in the current image.
						image.hide().stop().fadeIn(500);
						
						// Setup hovering for the image data container.
						imageData.hover(function() {
							// Trigger mouse enter event for wrapper element.
							w.trigger('mouseenter');
						}, function() {
							// Trigger mouse leave event for wrapper element.
							w.trigger('mouseleave');
						});
						
						// Check if wrapper is hovered.
						var hovered = w.hasClass($.exposure.imageHoverClass);						
						if (hovered) {
							if (gallery.imageHasData()) {
								gallery.onImageHoverOver();
							} else {
								gallery.onImageHoverOut();
							}	
						}
		
						if (gallery.showThumbs && thumb && thumb.length) {
							thumb.parents('li').siblings().children('img.' + $.exposure.selectedImageClass).stop().fadeTo(200, 0.7, function() { $(this).removeClass($.exposure.selectedImageClass); });			
							thumb.fadeTo('fast', 1).addClass($.exposure.selectedImageClass);
						}
					}
				});
			});
		// Exposure end
		
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

			// Hiding any open menus
			jQuery(".dropdown").not(this).each(function() {
				jQuery(this).find("ul").hide();
				jQuery(this).find("a.nav-link").removeClass('selected');
			})
		
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
		
</script>
</head>
<%--<body oncontextmenu="return false">--%>
<body>
<div id="container">

<jsp:include page="/include/top.jsp" flush="true"/>

	<div id="content">
	
		<div class="content-top"></div>
		<div class="content-inner">
			
			<!-- List Begin -->
			
			<div class="breadcrumbs">
				<ul>
					<li><a href="index.html">Home</a></li>
					<li><a href="grid_0.html">All Product</a></li>
					<li><a href="grid_${product.brand.id}.html">${product.brand.brandName}</a></li>
					<li><a href="javascript:void(0)">${product.category.name}</a></li>
					<li class="last">${product.name}</li>
				</ul>
				<br class="clear"/>
			</div>
			
				<!-- Left Column Begin -->
			<div id="lhs" class="left-side float-left">
				<h3 class="active">Brands</h3>
				<ul>
                    <c:set value="${pwk:getBrandsByStatus(1)}" var="brands"/>
                    <c:forEach items="${brands}" var="brand">
                        <c:if test="${brand.id eq product.brand.id}">
                            <li><a href="grid_${brand.id}.html">${brand.brandName}>></a></li>
                        </c:if>
                        <c:if test="${brand.id ne product.brand.id}">
                            <li><a href="grid_${brand.id}.html">${brand.brandName}</a></li>
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
                <c:set value="${pwk:getHotSaleByBrandId(product.brand.id,1 ,7 )}" var="hotSales"/>
				<div class="featured-product">
                    <c:forEach items="${hotSales}" var="hotSale">
                        <div class="featured-product-item">
                            <a href="${pageContext.request.contextPath}/details_${hotSale.product.id}.html" class="float-left">
                                <c:forEach items="${hotSale.product.picPath}" var="pic" begin="0" end="0">
                                    <img src="${pwk:getPicDomain()}/${pic.path}" style="height: 80px;width: 80px;"/>
                                </c:forEach>
                            </a>
                            <span class="title"><a href="${pageContext.request.contextPath}/details_${hotSale.product.id}.html" title="${hotSale.product.name}">${fn:substring(hotSale.product.name, 0, 20)}</a></span>
                            <span class="price">RM <fmt:formatNumber value="${hotSale.product.price}" type="currency" pattern="###,##0.00"/></span>
                        </div>
                        <br class="clear"/>
                    </c:forEach>
				</div>
				<!-- Featured Products Begin -->

			</div>
			<!-- Left Column End -->

			<!-- Main Column Begin -->
			<div class="main-content">
			
				<div class="detail-item">
					
						<!-- Product Gallery Begin -->
						<div class="product-gallery float-left">
							<div id="exposure"></div>
							<div class="panel">	
								<div id="controls"></div>				
								<div id="slideshow"></div>
								<ul id="images">
                                    <c:forEach items="${product.picPath}" var="pic" begin="0" end="3">
                                        <li><a href="${pwk:getPicDomain()}/${pic.miniPath}"><img src="${pwk:getPicDomain()}/${pic.miniPath}" /></a></li>
                                    </c:forEach>
								</ul>
							</div>	
						</div>
						<!-- Product Gallery End -->
					
			 		<div class="text-info">
			 			<span class="title">${product.name}</span>
						<span class="price" id="price">RM <fmt:formatNumber value="${product.price}" type="currency" pattern="###,##0.00"/></span>
													
						<span class="description">
							<p>${product.shortDescription} </p>
						</span>
				
						<div class="dropdown-container">
							<span class="size">Color:</span>
							<div class="color">
								<div class="dropdown">
									<a href="javascript:void(0)" class="dropdown-link" id="color">Select color...</a>
                                    <input type="hidden" id="colorVal">
									<ul class="search-menu" style="display: none; position: absolute;">
                                        <c:forEach items="${product.colors}" var="color">
                                            <li>
                                                <span class="menu-link">
                                                    <a href="javascript:void(0)" onclick="selectColor(${color.id},'${color.name}');">${color.name}
                                                        <c:forEach items="${color.picPath}" var="pic" begin="0" end="0">
                                                            <img src="${pwk:getPicDomain()}/${pic.path}" alt="${color.name}" style="float: right;width: 20px;height: 20px;">
                                                        </c:forEach>
                                                    </a>
                                                </span>
                                            </li>
                                        </c:forEach>
									</ul>

								</div>
							</div>
						</div>

						<c:forEach items="${product.attributes}" var="attribute" varStatus="vs">
							<div class="dropdown-container">
								<span class="size">${attribute.name}:</span>
								<div class="color">
									<select id="${attribute.id}" title="${attribute.name}" name="attribute" class="required email form-name input-text" style="width:100%">
										<option></option>
											<c:forEach items="${attribute.parameters}" var="parameter">
													<option value="${parameter.id}">
															${parameter.name}
														<c:if test="${parameter.additionalPrice ne 0}">
															+RM<fmt:formatNumber value="${parameter.additionalPrice}" type="currency" pattern="###,##0.00"/>
														</c:if>
													</option>
											</c:forEach>
									</select>
								</div>
							</div>
						</c:forEach>

						<br class="clear"/>

						<div class="float-left dropdown-container">
							<c:if test="${product.stockStatus eq 1}">
								<a href="javascript:void(0)" onclick="addToCart(${product.id},'1');" class="general-button-big"><span class="button-big">Add to cart</span></a>
								<a href="javascript:void(0)" onclick="buyNow(${product.id},'1');" class="general-button-big"><span class="button-big">Buy Now</span></a>
							</c:if>
							<c:if test="${product.stockStatus eq 0}">
								<a href="javascript:void(0)" class="general-button-big"><span class="button-big">Out of Stock</span></a>
							</c:if>
						</div>
						
						<br class="clear"/>


							<!-- Google Begin -->
							<div class="social-container float-left">
							</div>
							<!-- Google End -->

							<!-- Twitter Begin -->
							<div class="social-container float-left">
								<a href="https://twitter.com/share" class="twitter-share-button"><img src="images/twitter.png" alt="twitter" border="0" title="share"/></a>
							</div>
							<!-- Twitter End -->

							<!-- Facebook Begin -->
							<div class="social-container float-left">
								<div id="fb-root"></div>
								<div class="fb-like" data-send="false" data-layout="button_count" data-width="120" data-show-faces="false">
                                    <a href="javascript: void(window.open('http://www.facebook.com/share.php?u='.concat(encodeURIComponent(location.href)) ))" class="twitter-share-button">
                                        <img src="images/facebook.png" alt="facebook" border="0" title="share"/>
                                    </a>
								</div>
							</div>
							<!-- Facebook End -->

			 		</div>
					
					<!-- Tabs Begin -->
					<div id="tabbed-menu">
						<ul class="tabs">
							<li><a href="#">Description</a></li>
							<%--<li><a href="#">Comments</a></li>--%>
						</ul>
						<br class="clear"/>
		
						<div class="panes">
							<div class="tab-content description">
								 ${product.description}
							</div>
							<div class="tab-content">
								
								<!-- Tab 2 section -->
								<div class="single-comment blog-page">
									<div class="avatar float-left">
										<img src="images/avatar.png"/>
									</div>
									<div class="comment-text blog-single-entry">
										<span class="name">John Smith</span>
										<span class="date">January 12, 2012, Wednesday, at 10:23 a.m.</span>
										<p>Nunc porta turpis vitae tellus pulvinar dapibus. Morbi ut leo sapien, vel vulte orci. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse potenti. Fusce sed nisi enim, et tincidunt nunc. </p>
									</div>
								</div>
								
								<div class="comment-form-container">
									<span class="new-comment-heading">Post Your Comment</span>
									<div class="form-name float-left">
										<span>Your Name</span>
										<input type="text" value="" class="form-name input-text">
									</div>
									<div class="form-name float-right">
										<span>Your E-mail</span>
										<input type="text" value="" class="form-name input-text">
									</div>
									<br class="clear"/>
									<div class="form-comment">
										<span>Comment</span>
										<textarea name="comments" rows="4" cols="20" class="txtarea-comment"></textarea> 
									</div>
									<a href="#" class="general-button-big add-comment"><span class="button-big">Submit your comment</span></a>
							</div>
								<!-- End -->
							  
							</div>
							
						</div>
						
					</div>
					<!-- Tabs End -->
					
				</div>
					
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