(function($){

var radioInput, equalHeight, mainSlider, fonts, gmaps, gallerySlider, Util,
    widget_login, productCarousel, productSlider, switchMode, slideInMenu, 
    menuTouchScroll, $body;

$body = $('body');

/* ===================================================================
  Slide In Top Menu
=================================================================== */
slideInMenu = {
  $nav: undefined,
  $container: $('.boxed-container'),
  $btnToggle: $('.btn-navbar'),

  // Init
  init: function() {
    this.bindClick();
    this.cloneTopBar();
  },

  // Clone top bar section
  // ------------------------------
  cloneTopBar: function() {
    var html =  '<div class="side-nav">';
        html +=   '<nav class="top-nav">'+ $('.top-nav').html() +'</nav>';
        html +=   '<div class="topbar-text">'+ $('.topbar-text').html() +'</div>';
        html += '</div>';

    $(html).insertAfter($('.outer-container'));
  },

  // Trigger Click button on mobile
  // ------------------------------
  bindClick: function() {
    var that = this;

    if( !$('.outer-container').length )
      this.$container.wrap('<div class="outer-container"/>');

    this.$btnToggle.toggle(function(){
      that.showNavMobile();
    }, function(){
      that.hideNavMobile();
    });
  },
  showNavMobile: function() {
    $body.addClass('slide-in');

    if( !Util.checkSupport('transform') ) {
      this.$container.animate({ left: 240 }, 200);
    }
  },
  hideNavMobile: function() {
    $body.removeClass('slide-in');

    if( !Util.checkSupport('transform') ) {
      this.$container.animate({ left: 0 }, 200);
    }
  }
};


/* ===================================================================
  Bind click event to radio input
=================================================================== */
radioInput = function( $target ){
  return {
    setChecked: function() {
      $target.find('label').removeClass('checked');
      $target.find(':checked').parent().addClass('checked');
    },
    bindClick: function() {
      $target.on('click', 'label', this.setChecked);
    },
    init: function() {
      this.setChecked();
      this.bindClick();
    }
  }
};


/* ===================================================================
  Main Slider
=================================================================== */
mainSlider = function() {
  var $slider = $('.main-slider-block .slides'),
      $sliderWrap = $slider.parent(),
      nav = '',
      interval = (typeof slideInterval !== 'undefined') ? slideInterval : 4;

  if( typeof slideAutoplay !== 'undefined' && !slideAutoplay )
    interval = false;

  // Stop the function when no slider found
  if( !$slider.length )
    return;

  // Create navigation
  nav += '<nav class="entry-gallery-nav">';
  nav +=  '<a href="#" class="slide-prev slide-nav"><i class="icon-chevron-left"></i></a>';
  nav +=  '<a href="#" class="slide-next slide-nav"><i class="icon-chevron-right"></i></a>';
  nav += '</nav>';
  $(nav).appendTo( $sliderWrap );

  // Make sure all images loaded before fire the carousel function
  $slider.imagesLoaded(function(){
    $slider.carouFredSel({
      auto: {
        play: true,
        timeoutDuration: interval * 1000,
      },
      scroll: {
        pauseOnHover: true
      },
      responsive: true,
      infinite: false,
      prev: $sliderWrap.find('.slide-prev'),
      next: $sliderWrap.find('.slide-next'),
      items: {
        height: 'variables'  
      }
    });
  });
};


/* ===================================================================
  Product Carousel
=================================================================== */
productCarousel = function() {
  var $carouselWrapper = $('.products-carousel'),
      carouselOpts = {
        auto: false,
        infinite: false,
        circular: false,
        responsive: true,
        width: '100%',
        align: 'left',
        items: {
          width: 270,
          visible: {
            min: 1,
            max: 4
          },
          minimum: 4
        }
      };

  // Check if element exists
  if( !$carouselWrapper.length )
    return;

  // Function for build nav element
  function buildNav( target ) {
    var nav = '';

    // Build Navigation
    nav += '<nav class="products-carousel-nav">';
    nav +=  '<a href="#" class="nav-prev">Previous</a>';
    nav +=  '<span class="nav-sep">/</span>'
    nav +=  '<a href="#" class="nav-next">Next</a>';
    nav += '</nav>';
    $(nav).appendTo( target );
  }

  // Function to change configuration of the carousel
  function changeConfig() {
    var windowWidth = $(window).width(),
        carouselItemWidth;
    
    // If on widescreen desktop
    if( windowWidth >= 1200 ) {
      carouselOpts.items.width = 270;
    }

    // When on normal desktop
    else if( windowWidth < 1200 && windowWidth > 979 ) {
      carouselOpts.items.width = 300;
    }

    // For Tablet portrait
    else if( windowWidth <= 979 && windowWidth >= 768 ) {
      carouselOpts.items.width = 228;
    }

    // Mobile Landscape
    else if( windowWidth <= 767 && windowWidth >= 480 ) {
      carouselOpts.items.width = null;
      carouselOpts.items.visible = 2;
      carouselOpts.responsive = true;
    }

    // For mobile Phone
    else if ( windowWidth < 480 ) {
      carouselOpts.items.width = null;
      carouselOpts.items.visible = 1;
      carouselOpts.scroll = { fx: 'fade' };
      carouselOpts.responsive = true;
    }

    // Change carousel config
    $carouselWrapper.find('ul').trigger('configuration', carouselOpts, true);
  }

  // Loop every carousel
  $carouselWrapper.each(function(){
    var $el = $(this),
        $blockHeader = $el.find('.block-header');

    // Build nav
    buildNav( $blockHeader );

    // Make sure images is loaded before run carousel script
    $el.imagesLoaded(function(){
      carouselOpts.prev = $el.find('.nav-prev');
      carouselOpts.next = $el.find('.nav-next');
      $el.find('ul').carouFredSel( carouselOpts );
    });  
  });

  // Bind on load and on resize
  // $(window).bind('load resize', changeConfig);
};


/* ===================================================================
  Single Product Slider
=================================================================== */
productSlider = function( target ) {
  this.$productImage = ( typeof target !== "undefined" ) ? target : $('.product-image');
  this.$thumbnails = this.$productImage.find('.thumbnails');
  this.$bigImage = this.$productImage.find('.image-zoom');
  this.options = {
    auto: false,
    infinite: false,
    circular: false,
    width: '100%',
    next: '.product-image .slide-next',
    prev: '.product-image .slide-prev',
    items: {
      visible: {
        min: 2,
        max: 5
      }
    }
  };

  this.createCarouselNav = function( target ) {
    var nav = '<nav class="entry-gallery-nav">';
        nav +=  '<a href="#" class="slide-prev slide-nav"><i class="icon-chevron-left"></i></a>';
        nav +=  '<a href="#" class="slide-next slide-nav"><i class="icon-chevron-right"></i></a>';
        nav += '</nav>';

    $(nav).appendTo( target );
  };

  // Fire thumbnail carousel
  this.thumbCarousel = function() {
    var self = this;
    this.$thumbnails.imagesLoaded(function(){
      self.$thumbnails.carouFredSel( self.options );
    });
  };

  // Bind click to carousel
  this.clickEvent = function() {
    var self = this;

    this.$thumbnails.on('click', 'a', function(e){
      var $link = $(this),
          imageUrl = $link.attr('href'); 
      self.changeBigImage( imageUrl );
      $link.addClass('selected').siblings().removeClass('selected');
      e.preventDefault();
    });
  };

  // Change big image
  this.changeBigImage = function( imageUrl ) {
    var self = this,
        $oldImage = this.$bigImage.find('img'),
        oldImageUrl = $oldImage.attr('src');

    // If imageUrl equal with old image url, do nothing
    if( imageUrl == oldImageUrl )
      return;

    $oldImage.animate({ 'opacity': 0 });
    $('<img>',{ src: imageUrl }).css('opacity', 0).insertAfter( $oldImage );

    // When image loaded
    var imagesloaded = this.$bigImage.imagesLoaded();

    // When images finished loading
    imagesloaded.done(function(img){
      $oldImage.remove();
      self.$bigImage.find('img').animate({ 'opacity': 1 });
      self.$bigImage.find('a').attr('href', imageUrl);

      // Re initiate cloud zoom
      self.zoom('reinit');
    });

    // When image not found
    imagesloaded.fail(function( img, proper, broken ){
      $oldImage.animate({ 'opacity': 1 });
      $oldImage.next('img').remove();
    });
  };

  // Init cloud zoom
  this.zoom = function( reinit ) {
    // If re init
    if( reinit )
      this.$bigImage.find('a').data('zoom').destroy();

    this.$bigImage.find('a').CloudZoom({
      adjustX: 10, 
      adjustY:-4
    });
  };

  this.init = function() {
    this.$bigImage.find('a').addClass('cloud-zoom');

    this.clickEvent();
    this.createCarouselNav( '.thumbnails-wrapper' );
    this.thumbCarousel();
    this.zoom();
  };

  // Check if in single page
  if( !this.$productImage.length )
    return;

  // Run the function
  this.init();
};


/* ===================================================================
  Post Format Gallery Slider
=================================================================== */
gallerySlider = function( el ) {
  var $gallery = ( typeof el !== "undefined" ) ? $(el) : $('.entry-gallery');

  if( !$gallery.length )
    return;

  // Create Slider Nav
  // -----------------------
  function createNav( target ) {
    var nav = '<nav class="entry-gallery-nav">';
        nav +=  '<a href="#" class="slide-prev slide-nav"><i class="icon-chevron-left"></i></a>';
        nav +=  '<a href="#" class="slide-next slide-nav"><i class="icon-chevron-right"></i></a>';
        nav += '</nav>';

    $(nav).insertAfter( target );
  }

  $gallery.each(function(i){
    var $this = $(this);

    // first, create slider nav
    createNav( $this );

    // Make sure images is loaded before run the script
    $this.imagesLoaded(function(){
      $this.carouFredSel({
        circular: false,
        infinite: false,
        auto: false,
        responsive: true,
        prev: $this.next().find('.slide-prev'),
        next: $this.next().find('.slide-next'),
        visible: 1
      });
    });
  });
};


/* ===================================================================
  Equal Height Function
=================================================================== */
$.fn.equalHeight = function() {
  var $el = this,
      tallest = 0;

  // Find tallest column
  function findTallest() {
    tallest = 0;
    $el.height('auto');
    $el.each(function(){
      var colHeight = $(this).height();
      if( colHeight > tallest ) {
        tallest = colHeight;
      }
    });
  }

  // Set column height
  function setColumnHeight() {
    findTallest();
    $el.addClass('equalHeight').height( tallest );
  }

  // Run function when window loaded or resized
  $(window).bind('load resize', setColumnHeight);

  return this;
};


/* ===================================================================
  View Mode Switcher
=================================================================== */
switchMode = {
  $view_mode: undefined,
  $products: undefined,

  bindClick: function() {
    var self = this;

    // Bind click
    this.$view_mode.on('click', 'a', function(e){
      e.preventDefault();

      var $link = $(this),
          mode = $link.attr('href'),
          mode = mode.replace(/^#/, '');

      // Check if link is selected
      if( $link.hasClass('selected') )
        return;

      self.switchMode( mode );
    });
  },

  switchMode: function( mode ) {
    var self = this;

    // Add class selected
    this.$view_mode.find('a[href="#'+ mode +'"]').addClass('selected').siblings().removeClass('selected');
    
    // Add Cookie
    this.setCookie( mode );

    // Change mode
    this.$products.fadeOut(300, function(){
      if( mode == 'list' ) {
        self.$products.addClass('mode-list').fadeIn(300);
      } else {
        self.$products.removeClass('mode-list').fadeIn(300);
      }
    });
  },

  setCookie: function( name ) {
    $.cookie('shoppingo_view_mode', name);
  },

  getCookie: function() {
    return $.cookie('shoppingo_view_mode');
  },

  init: function() {
    this.$view_mode = $('.view-mode');
    this.$products = $('.products');
    this.bindClick();

    // Check page on load, if hase cookie, change the layout
    if( this.getCookie() !== null && this.$view_mode.length > 0 ) {
      this.switchMode( this.getCookie() );
    }
  }
};


/* ===================================================================
  Smooth Scroll
=================================================================== */
$body.on('click', '.scroll-to', function(e){
  e.preventDefault();
  var $el     = $(this),
      target  = $el.attr('href'),
      targetScroll;

  // Determine scroll target position
  if( $(target).length > 0 ) {
    targetScroll = $(target).position().top;
  } else {
    if( target == '#top' ) {
      targetScroll = 0;
    } else if( target == '#bottom' ) {
      targetScroll = $('body').height()
    }
  }

  // Animate Scroll
  $('body').animate({ scrollTop: targetScroll });
});


/* ===================================================================
  Product Tabs
=================================================================== */
$body.on('click', '.product-tab a', function(e){
  e.preventDefault();
  $(this).tab('show');
});


/* ===================================================================
  Google Fonts
=================================================================== */
fonts = {

  init: function() {
    this.loadScript();
  },

  addFont: function(font) {
    WebFontConfig = (typeof WebFontConfig !== "undefined" ) ? WebFontConfig : {google: { families: [] } };
    if( font !== '' ) {
      WebFontConfig.google.families.push(font);
    }
  },

  loadScript: function() {
    var wf = document.createElement('script');
    wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
      '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
    wf.type = 'text/javascript';
    wf.async = 'true';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(wf, s);
  }
};


/* ===================================================================
  Audio Player
=================================================================== */
var AudioPlayer = function( target ) {
  this.player = ( typeof target !== 'undefined' ) ? $(target) : $('.audio-player-container');

  // Player Template
  // -----------------------
  this.template = function( idPrefix, playerWrapperID, playerTitle ) {
    var html = [
    '<div id="'+ idPrefix +'" class="jp-jplayer"></div>',
    '<div id="'+ playerWrapperID +'" class="jp-audio">',
      '<div class="jp-type-single">',
        '<div class="jp-gui jp-interface">',
          '<div class="jp-gui-wrapper">',
            '<ul class="jp-controls">',
              '<li><a class="jp-play" href="javascript:;" tabindex="1">play</a></li>',
              '<li> <a class="jp-pause" href="javascript:;" tabindex="1" style="display: none; ">pause</a> </li>',
              '<li> <a class="jp-stop" href="javascript:;" tabindex="1">stop</a> </li>',
              '<li> <a class="jp-mute" href="javascript:;" tabindex="1" title="mute">mute</a> </li>',
              '<li> <a class="jp-unmute" href="javascript:;" tabindex="1" title="unmute" style="display: none; ">unmute</a> </li>',
              '<li> <a class="jp-volume-max" href="javascript:;" tabindex="1" title="max volume">max volume</a> </li>',
            '</ul>',
            '<div class="jp-gui-sep"></div>',
            '<div class="jp-progress">',
              '<div class="jp-seek-bar">',
                '<div class="jp-play-bar"></div>',
              '</div>',
            '</div>',
          '</div>',
          '<div class="jp-volume-bar"><div class="jp-volume-bar-value"></div></div>',
          '<div class="jp-current-time"></div>',
          '<div class="jp-duration"></div>',
          '<ul class="jp-toggles">',
            '<li> <a class="jp-repeat" href="javascript:;" tabindex="1" title="repeat">repeat</a> </li>',
            '<li> <a class="jp-repeat-off" href="javascript:;" tabindex="1" title="repeat off">repeat off</a> </li>',
          '</ul>',
        '</div><!-- .jp-interface -->',
        '<div class="jp-no-solution">',
          '<span>Update Required</span>',
          'To play the media you will need to either update your browser to a recent version or update your',
          '<a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>',
        '</div>',
      '</div><!-- .jp-type-single -->',
    '</div>'
    ];
    return html.join('');
  };

  // Create Player
  // -----------------------
  this.createPlayer = function() {
    var that = this;

    this.player.each(function(i){
      var $el             = $(this),
          idPrefix        = 'jquery_jplayer_'+ $el.data('id'),
          playerWrapperID = 'jp_container_'+ $el.data('id'),
          playerTitle     = $el.data('title'),
          playerSource    = $el.data('source'),
          playerTemplate  = that.template( idPrefix, playerWrapperID, playerTitle );

      $(playerTemplate).appendTo( $el );

      // Init jPlayer
      $('#' + idPrefix ).jPlayer({
        ready: function (event) {
          $(this).jPlayer("setMedia", {
            mp3: playerSource
          });
        },
        cssSelectorAncestor: '#' + playerWrapperID,
        swfPath: 'js/',
        supplied: "mp3",
        wmode: "window",
        solution: 'html, flash'
      });
    });
  };

  // Init
  // -----------------------
  this.init = function() {
    this.createPlayer();
  };

  return this.init();
}


/* ===================================================================
  Google Maps
=================================================================== */
gmaps = function( el ) {
  var maps = {
    $el: $(el),
    loadScript: function() {
      var script = document.createElement("script");
      script.type = "text/javascript";
      script.src = "http://maps.googleapis.com/maps/api/js?&sensor=true&callback=createMap";
      document.body.appendChild(script);
    },

    addMarker: function(map, opts) {
      var marker, geocoder;

      // Check if maps can use geocoder
      // ------------------------------
      if( opts.address !== '' ) {
        geocoder = new google.maps.Geocoder();
        geocoder.geocode({
          address: opts.address
        }, function(results, status){
          // Make sure geocoder status is OK
          if( status == "OK" ) {
            map.setCenter( results[0].geometry.location );

            // Set Marker
            marker = new google.maps.Marker({
              position: results[0].geometry.location,
              map: map
            });
          }
        });
      }

      // If can't use geocoder, use lat and lng data
      // -------------------------------------------
      else {
        marker = new google.maps.Marker({
          position: opts.center,
          map: map
        });
      }
    },

    createMap: function() {
      $(el).each(function(){
        var $this = $(this),
            lat = $this.data('latitude'),
            lng = $this.data('longitude'),
            addr= $this.data('address'),
            zoom= ($this.data('zoom')) ? $this.data('zoom') : 16,
            mapOptions = {
              zoom: zoom,
              address: addr,
              center: new google.maps.LatLng(lat, lng),
              mapTypeId: google.maps.MapTypeId.ROADMAP
            },
            map;

        map = new google.maps.Map( this, mapOptions);
        maps.addMarker(map, mapOptions);
      });
    },

    init: function() {
      if( this.$el.length == 0 )
        return;

      this.loadScript();
      window.createMap = this.createMap;
    }
  };

  return maps.init();
};


/* ===================================================================
  Widget Login Placeholder
=================================================================== */
widget_login = function() {
  var $widget_input = $('.widget_login input[type="text"]');

  if( !$widget_input.length )
    return;

  $widget_input.each(function(){
    var $el = $(this),
        label = $el.prev('label');

    $el.attr('placeholder', label.text());
  });
};


/* ===================================================================
  Nesia Javascript Utilities
=================================================================== */
Util = {
  addThis: function() {
    window.addthis_config = {
      
    };

    if( $('.addthis_toolbox').length > 0 || $('.facebook-share-like').length > 0 ) {
      var AT = document.createElement('script');
      AT.src = 'http://s7.addthis.com/js/300/addthis_widget.js';
      AT.type = 'text/javascript';
      var s = document.getElementsByTagName('script')[0];
      s.parentNode.insertBefore(AT, s);
    }
  },

  // Check CSS3 Support
  // -----------------------
  checkSupport : function( prop ) {
    var div = document.createElement('div'),
      vendors = 'Khtml Ms O Moz Webkit'.split(' '),
      len = vendors.length;
      
      if ( prop in div.style ) return true;

      prop = prop.replace(/^[a-z]/, function(val) {
        return val.toUpperCase();
      });

      while(len--) {
        if ( vendors[len] + prop in div.style ) {
          return true;
        }
      }
      return false;
  },

  matrixToArray: function(matrix) {
    return matrix.substr(7, matrix.length - 8).split(', ');
  },

  // Init
  // -----------------------
  init: function() {
    this.addThis();
  }
};


/* Make widget categories list clickable
------------------------------------------------------------------- */
$('.widget_categories li, .widget_product_categories li').click(function(e){
  window.location = $(this).find('a').attr('href');
});


/* ===================================================================
  Document Ready
=================================================================== */
$(document).ready(function(){

widget_login();                           // Widget login placeholder
$('input, textarea').placeholder();       // Placeholder polyfill
$('.footer-widgets-inner').equalHeight(); // Set equal height column
(radioInput( $('.search-sort') )).init(); // Set radio input
gmaps('.gmaps');                          // Init gmaps
mainSlider();                             // Main Slider Init
productCarousel();                        // Products carousel
productSlider();                          // Single Product Slider
gallerySlider();                          // Gallery Slider
AudioPlayer();                            // Post format audio
Util.init();                              // Utilities init
slideInMenu.init();                       // Side menu for mobile
// menuTouchScroll.init();                   // Side menu touch event
$('.side-nav .top-nav').touchscroll();

// Add google font
fonts.addFont('Kelly+Slab::latin');
fonts.init();

// Responsive video
$('.entry-post iframe, .entry-post object').parent().fitVids(); 

// Add class first for first paragraph in entry content
$('.single .entry-content > p:first').addClass('first');

 // Add class to comment button
$('#respond input[type="submit"]').addClass('btn btn-candygreen');

// Switch Mode
switchMode.init();

// Tooltip for quick view
$('.quick-view').tooltip();

// Responsive logo text
// $(".header-logo").fitText(0.6, { minFontSize: '20px', maxFontSize: '92px' })

/* Dropdown Menu
------------------------------------------------------------------- */
$('.primary-nav ul:first')
  .addClass('sf-menu')
  .superfish({
    dropShadows: false,
    onInit: function() {
      $(this).find('.sf-sub-indicator').html('<i class="icon-caret-down"></i>');
      $(this).find('ul .sf-sub-indicator').html('<i class="icon-caret-right"></i>');
    }
  })
  .mobileMenu();

});


})(jQuery);
