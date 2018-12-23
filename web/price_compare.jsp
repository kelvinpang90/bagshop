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
					<li><a href="#">Pages</a></li>
					<li class="last">Price Compare Table</li>
				</ul>
				<br class="clear"/>
			</div>
			
			<!-- Main Begin -->
			<div class="full-width-content">
				<h3>Product compare table</h3>
				<table cellpadding="0" cellspacing="0" class="compare">
					<tr class="table-head">
						<td class="first"></td>
						<td><img src="images/basic2.png"/></td>
						<td><img src="images/advanced2.png"/></td>
						<td><img src="images/premium2.png"/></td>
						<td><img src="images/ultimate2.png"/></td>
					</tr>
					<tr class="even">
						<td class="first">Lorem ipsum dolor sit amet</td>
						<td><img src="images/yes_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
					</tr>
					<tr>
						<td class="first">Nam mattis interdum</td>
						<td><img src="images/yes_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
					</tr>
					<tr class="even">
						<td class="first">Curabitur eleifend velit eu enim</td>
						<td><img src="images/no_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
					</tr>
					<tr>
						<td class="first">Nullam pretium arcu eget leo laoreet</td>
						<td><img src="images/no_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
					</tr>
					<tr class="even">
						<td class="first">Aenean pulvinar pulvinar dolor</td>
						<td><img src="images/no_icon.png"/></td>
						<td><img src="images/no_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
					</tr>
					<tr>
						<td class="first">Quisque in ultrices leo</td>
						<td><img src="images/no_icon.png"/></td>
						<td><img src="images/no_icon.png"/></td>
						<td><img src="images/no_icon.png"/></td>
						<td><img src="images/yes_icon.png"/></td>
					</tr>
					<tr class="even">
						<td class="first">Nunc porta turpis vitae tellus</td>
						<td><img src="images/no_icon.png"/></td>
						<td><img src="images/no_icon.png"/></td>
						<td>20</td>
						<td>40</td>
					</tr>
					<tr>
						<td class="first">Vestibulum ante ipsum in faucibus</td>
						<td><img src="images/no_icon.png"/></td>
						<td>1</td>
						<td>3</td>
						<td>5</td>
					</tr>
					<tr class="even">
						<td class="first">Morbi ut leo sapien, vel vulte orci</td>
						<td><img src="images/no_icon.png"/></td>
						<td>unlimited</td>
						<td>unlimited</td>
						<td>unlimited</td>
					</tr>
					<tr>
						<td class="first">Fusce sed nisi enim, et tincidunt nunc</td>
						<td><img src="images/no_icon.png"/></td>
						<td><img src="images/no_icon.png"/></td>
						<td>10</td>
						<td>unlimited</td>
					</tr>
					<tr class="last">
						<td class="first"></td>
						<td><a href="#" class="general-button-big cart-button"><span class="button-big">Select</span></a></td>
						<td><a href="#" class="general-button-big cart-button"><span class="button-big">Select</span></a></td>
						<td><a href="#" class="general-button-big cart-button"><span class="button-big">Select</span></a></td>
						<td><a href="#" class="general-button-big cart-button"><span class="button-big">Select</span></a></td>
					<tr>
				</table>
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