//GNB
function submenu_hide() {
    $("#hd").removeClass("hd_zindex");
    $(".gnb-bg").removeClass("gnb-bg-on");
    $("#gnb_container").removeClass("gnb-on");
    //$(".gnb_1dli").removeClass("gnb_1dli_over gnb_1dli_over2");
    //$(".gnb_2dli").removeClass("gnb_2dli_over gnb_2dli_over2");
}
function menu_rearrange(el) {
    var width = $("#gnb_1dul").width();
    var left = w1 = w2 = 0;
    var idx = $(".gnb_1dli").index(el);
    var max_menu_count = 0;
    var $gnb_1dli;

    for(i=0; i<=idx; i++) {
        $gnb_1dli = $(".gnb_1dli:eq("+i+")");
        w1 = $gnb_1dli.outerWidth();

        if($gnb_1dli.find(".gnb_2dul").length)
            w2 = $gnb_1dli.find(".gnb_2dli > a").outerWidth(true);
        else
            w2 = w1;

        if((left + w2) > width) {
            if(max_menu_count == 0)
                max_menu_count = i + 1;
        }

        if(max_menu_count > 0 && (idx + 1) % max_menu_count == 0) {
            el.removeClass("gnb_1dli_over").addClass("gnb_1dli_over2");
            left = 0;
        } else {
            left += w1;
        }
    }
}
$(function() {
    var hide_menu = false;
    var mouse_event = true;
    var oldX = oldY = 0;

    $(document).mousemove(function(e) {
        if(oldX == 0) {
            oldX = e.pageX;
            oldY = e.pageY;
        }

        if(oldX != e.pageX || oldY != e.pageY) {
            mouse_event = true;
        }
    });

    // 주메뉴
    var $gnb = $(".gnb_1dli > a");
    $gnb.on('mouseover focus', function() {
        if(mouse_event) {
            $("#hd").addClass("hd_zindex");
            $(".gnb-bg").addClass("gnb-bg-on");
            $("#gnb_container").addClass("gnb-on");
            //$(".gnb_1dli").removeClass("gnb_1dli_over gnb_1dli_over2");
            //$(".gnb_1dli").addClass("gnb_1dli_over");
            $(".gnb_1dli").addClass("gnb_1dli_on");
            menu_rearrange($(this).parent());
            hide_menu = false;
            
            //gnbNum = $(this).parent(".gnb_1dli").index();
        }
    });
    
    $gnb.mouseout(function() {
        hide_menu = true;
    });

    $(".gnb_1dli").mouseout(function() {
        gnbNum = $(this).index();
    	//$("#hd").removeClass("hd_zindex");
    	//$(".gnb_1dli").removeClass("gnb_1dli_on");
    });

    $(".gnb_2dli").mouseover(function() {
        hide_menu = false;
        //$(".gnb_2dli").removeClass("gnb_2dli_over");
        //$(this).addClass("gnb_2dli_over");
        //$(this).parent(".gnb_2dul").parent(".gnb_1dli").addClass("gnb_1dli_on");

    	$("#hd").addClass("hd_zindex");
    });

    $(".gnb_2dli").mouseout(function() {
        hide_menu = false;
        //$(".gnb_2dli").removeClass("gnb_2dli_over");
    });

    $gnb.focusin(function() {
   
    });

    $gnb.focusout(function() {
        hide_menu = false;
    });

    $(".gnb_2da").focusin(function() {
        hide_menu = false;
    });

    $(".gnb_2da").focusout(function() {
        hide_menu = false;
    });

    $(".gnb_3da").focusin(function() {
        hide_menu = false;
    });

    $(".gnb_3da").focusout(function() {
        hide_menu = true;
    });

    $('#gnb').on('mouseleave blur',function(){
        submenu_hide();
        $(".gnb_1dli").removeClass("gnb_1dli_on");
        
    });

    $(document).bind('click focusin',function(){
        if(hide_menu) {
            submenu_hide();
        }
    });

    /*
    $(".gnb_1dli").on('mouseover focus', function() {
        $(this).children(".gnb_1da").css({color:"#fff",});
        $(this).find(".gnb_2da").css({color:"#fff",});
    });
    $(".gnb_1dli").on('mouseout blur', function() {
        $(this).children(".gnb_1da").css({color:"#222",});
        $(this).find(".gnb_2da").css({color:"#222",});
    });
    */

    $(".gnb_1dli").on('mouseover focus', function() {
    	$("#hd").addClass("hd_zindex");
        $(this).addClass("gnb_1dli_on");
    });

    /*$(".gnb_1dli").on('mouseout blur', function() {
    	$("#hd").removeClass("hd_zindex");
        $(this).removeClass("gnb_1dli_on");
    });*/

    // a의 href에 id값 a[href*=\\#]
    $('[href^="#"]').on('click', function() {
        var $this = $(this),
            $that = $($this.attr('href'));

        try {
            if (!$this.is('.totop, .dropdown-item')) {
                // e.preventDefault();
                if ($that.offset()) {
                    $('html, body').stop().animate({
                        scrollTop : $that.offset().top
                    }, 500);
                }
                // return false;
            }
        } catch (e) {
        }
    });
});