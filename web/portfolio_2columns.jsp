<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>Web Shop</title>
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

<!-- Style for portfolio gallery -->
<link rel="stylesheet" type="text/css" href="mofm-source/css/style.css"/>
<link rel="stylesheet" type="text/css" href="mofm-source/css/prettyPhoto.css"/>

<!-- Google font -->
<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css' />
<link href='http://fonts.googleapis.com/css?family=Qwigley' rel='stylesheet' type='text/css' />
<link href='http://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css' />

<!-- JS for jQuery -->
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>

<!-- JS for jQuery Product slider -->
<script type="text/javascript" src="js/jquery.tools.min.js"></script>

<!-- JS for jQuery Fancy Box -->
<script type="text/javascript" src="fancybox/fancybox/jquery.fancybox-1.3.4.pack.js"></script>

<!-- JS for superfish navigation menu -->
<script type="text/javascript" src="superfish/hoverIntent.js"></script> 
<script type="text/javascript" src="superfish/superfish.js"></script> 

<!-- JS for price range slider -->
<script type="text/javascript" src="jQueryUI/js/jquery-ui-1.7.1.custom.min.js"></script>
<script type="text/javascript" src="jQueryUI/js/selectToUISlider.jQuery.js"></script>

<!-- Style for product gallery -->
<link href="exposure/exposure.css" type="text/css" rel="stylesheet" />
		
<!-- JS for product gallery -->
<script src="exposure/jquery.exposure.js" type="text/javascript"></script>

<!-- JS for portfolio gallery -->
<script type="text/javascript" src="mofm-source/js/jquery.prettyPhoto.js"></script> 
<script type="text/javascript" src="mofm-source/js/jquery.quicksand.js"></script> 
<script type="text/javascript" src="mofm-source/js/jquery.easing.1.3.js"></script> 
<script type="text/javascript" src="mofm-source/js/script.js"></script>	
<script type="text/javascript" src="mofm-source/js/jquery.equalheights.js"></script>

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
	
	$(window).load(function() {
		$(".portfolio li p").equalHeights();
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
		
		// Navigation menu
		$("ul.sf-menu").superfish(); 
		
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
					<li><a href="#">Home</a></li>
					<li><a href="#">Portfolio</a></li>
					<li class="last">My portfolio in two columns</li>
				</ul>
				<br class="clear"/>
			</div>
			
			<!-- Main Begin -->
			
			<div class="full-width-content">
				<h3>My portfolio in two columns</h3>
				
				<div class="portfolio-container">
					<ul class="filter">
						<li class="current all"><a href="#">All</a></li>
						<li class="nature"><a href="#">Nature</a></li>
						<li class="cities"><a href="#">Cities</a></li>
						<li class="flowers"><a href="#">Flowers</a></li>
						<li class="thesea"><a href="#">The Sea</a></li>
						<li class="travel"><a href="#">Travel</a></li>
						<li class="night"><a href="#">Night Shots</a></li>
					</ul>
				</div>
				
				<br class="clear"/>
				
				<ul class="portfolio">
					<li data-id="id-1" data-type="cities thesea travel" class="two-columns">
						<div class="portfolio-label"><img src="images/portfolio_label_photo.png"/></div>
						<a href="portfolio/portfolio1.jpg" rel="prettyPhoto[portfolio]" class="portfolio-link">
						  <img src="portfolio/portfolio1_small.jpg"/>
						  <span class="mouseon-portfolio"></span>
						</a>
						<p>
							<a href="#" class="portfolio-title">Lorem ipsum dolor sit consectetur</a>
							Nunc porta turpis vitae tellus pulvinar dapibus. Morbi ut leo sapien, vel vue orci. Class aptent taciti sociosqu ad litora torquent per conbia nostra, per inceptos himenaeos.
						</p>
					</li>
					
					<li data-id="id-2" data-type="nature thesea" class="two-columns">
						<div class="portfolio-label"><img src="images/portfolio_label_design.png"/></div>
						<a href="portfolio/portfolio2.jpg" rel="prettyPhoto[portfolio]" class="portfolio-link">
						  <img src="portfolio/portfolio2_small.jpg" />
						  <span class="mouseon-portfolio"></span>
						</a>
						<p>
							<a href="#" class="portfolio-title">Morbi ut leo sapien, suspendisse vel</a>
							Aliquam ac libero elit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut ornare sollicitudin leo, et rhoncus turpis volutpat vel.
						</p>
					</li>
					
					<li data-id="id-3" data-type="nature thesea" class="two-columns">
						<div class="portfolio-label"><img src="images/portfolio_label_logo.png"/></div>
						<a href="portfolio/portfolio3.jpg" rel="prettyPhoto[portfolio]" class="portfolio-link">
						  <img src="portfolio/portfolio3_small.jpg" />
						  <span class="mouseon-portfolio"></span>
						</a>
						<p>
							<a href="#" class="portfolio-title">Nullam ac nunc in ipsum id at justo</a>
							Class aptent taciti sociosqu ad litora torquent per conbia nostra, per inceptos himenaeos. Nam rhoncus, felis sed aliquam tempus, ipsum sem consequat ligula.
						</p>
					</li>
					
					<li data-id="id-4" data-type="night nature thesea" class="two-columns">
						<div class="portfolio-label"><img src="images/portfolio_label_photo.png"/></div>
						<a href="portfolio/portfolio4.jpg" rel="prettyPhoto[portfolio]" class="portfolio-link">
						  <img src="portfolio/portfolio4_small.jpg"/>
						  <span class="mouseon-portfolio"></span>
						</a>
						<p>
							<a href="#" class="portfolio-title">Suspendisse potenti sit torquent</a>
							Nunc porta turpis vitae tellus pulvinar dapibus. Morbi ut leo sapien, vel vue orci. Class aptent taciti sociosqu ad litora torquent per conbia nostra, per inceptos himenaeos.
						</p>
					</li>
					
					<li data-id="id-5" data-type="nature" class="two-columns">
						<div class="portfolio-label"><img src="images/portfolio_label_vector.png"/></div>
						<a href="portfolio/portfolio5.jpg" rel="prettyPhoto[portfolio]" class="portfolio-link">
						  <img src="portfolio/portfolio5_small.jpg" />
						  <span class="mouseon-portfolio"></span>
						</a>
						<p>
							<a href="#" class="portfolio-title">Pellentesque habitant morbi tristique</a>
							Aliquam ac libero elit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nullam ac nunc in ipsum pellentesque facilisis id at justo.
						</p>
					</li>
					
					<li data-id="id-6" data-type="cities travel" class="two-columns">
						<div class="portfolio-label"><img src="images/portfolio_label_html.png"/></div>
						<a href="portfolio/portfolio6.jpg" rel="prettyPhoto[portfolio]" class="portfolio-link">
						  <img src="portfolio/portfolio6_small.jpg" />
						  <span class="mouseon-portfolio"></span>
						</a>
						<p>
							<a href="#" class="portfolio-title">Nam rhoncus, felis ipsum sem ligula</a>
							Class aptent taciti sociosqu ad litora torquent per conbia nostra, per inceptos himenaeos. Nam rhoncus, felis sed aliquam tempus, ipsum sem consequat ligula.
						</p>
					</li>
					
					<li data-id="id-7" data-type="flowers" class="two-columns">
						<div class="portfolio-label"><img src="images/portfolio_label_html.png"/></div>
						<a href="portfolio/portfolio7.jpg" rel="prettyPhoto[portfolio]" class="portfolio-link">
						  <img src="portfolio/portfolio7_small.jpg"/>
						  <span class="mouseon-portfolio"></span>
						</a>
						<p>
							<a href="#" class="portfolio-title">Proin mattis diam justo quis pretium</a>
							Nunc porta turpis vitae tellus pulvinar dapibus. Morbi ut leo sapien, vel vue orci. Class aptent taciti sociosqu ad litora torquent per conbia nostra, per inceptos himenaeos.
						</p>
					</li>
					
					<li data-id="id-8" data-type="night cities travel" class="two-columns">
						<div class="portfolio-label"><img src="images/portfolio_label_psd.png"/></div>
						<a href="portfolio/portfolio8.jpg" rel="prettyPhoto[portfolio]" class="portfolio-link">
						  <img src="portfolio/portfolio8_small.jpg" />
						  <span class="mouseon-portfolio"></span>
						</a>
						<p>
							<a href="#" class="portfolio-title">Ut ornare sollicitudin rhoncus turpis</a>
							Etiam pulvinar, arcu et fringilla convallis, ipsum lectus molestie lorem, non gravida turpis est sed velit. Duis rutrum, dolor sit amet dignissim aliquet, purus leo eleifend ligula.
						</p>
					</li>
					
					<li data-id="id-9" data-type="cities thesea travel" class="two-columns">
						<div class="portfolio-label"><img src="images/portfolio_label_vector.png"/></div>
						<a href="portfolio/portfolio9.jpg" rel="prettyPhoto[portfolio]" class="portfolio-link">
						  <img src="portfolio/portfolio9_small.jpg" />
						  <span class="mouseon-portfolio"></span>
						</a>
						<p>
							<a href="#" class="portfolio-title">Praesent neque felis sollicitudin quam</a>
							Lorem ipsum dolor sit amet, consectetur adip scing elit. In elementum condimentum euismod. Cras bibendum felis eget quam ultrices tempus. In hac platea dictumst. 
						</p>
					</li>
					
					<li data-id="id-10" data-type="nature travel" class="two-columns">
						<div class="portfolio-label"><img src="images/portfolio_label_logo.png"/></div>
						<a href="portfolio/portfolio10.jpg" rel="prettyPhoto[portfolio]" class="portfolio-link">
						  <img src="portfolio/portfolio10_small.jpg" />
						  <span class="mouseon-portfolio"></span>
						</a>
						<p>
							<a href="#" class="portfolio-title">Sed libero ipsum porta nec lectus</a>
							Aliquam erat volutpat. Fusce porttitor viverra rutrum. Vivamus justo sapien, varius sed pellentesque id, ornare eget mi. Donec justo, pretium eu scelerisque, tempus id est.
						</p>
					</li>
				</ul>
				
			</div>
			<!-- Main End -->
			
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