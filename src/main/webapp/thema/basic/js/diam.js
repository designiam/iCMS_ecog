// diam
function diam() {
    return;
}

function shareSns(sns){
	$('.share_box input[type="url"]').attr('disabled', false);
	$('.share_box input[type="url"]').select();
	var copyURL = $('.share_box input[type="url"]').val();
	$('.share_box input[type="url"]').attr('disabled', true);

    var snsTitle = document.title;
    var snsItems = new Array();
    var winOpt = new Array();
    var snsUrl = copyURL;

    snsItems['facebook'] = "http://www.facebook.com/share.php?t="+encodeURIComponent(snsTitle) + "&u=" + encodeURIComponent(snsUrl);
    snsItems['blog'] = "https://share.naver.com/web/shareView?url=" + encodeURIComponent(snsUrl) + "&title=" + encodeURIComponent(snsTitle);
	snsItems['twitter'] = "https://twitter.com/intent/tweet?url=" + encodeURIComponent(snsUrl) + "&text=" + encodeURIComponent(snsTitle);

    winOpt['facebook'] = "width=400, height=300, resizable=yes";
    winOpt['blog'] = "width=500, height=500, resizable=yes";
	winOpt['twitter'] = "width=500, height=500, resizable=yes";

    var win = window.open(snsItems[sns], sns, winOpt[sns]);
    if (win) {
        win.focus();
    }
}

$(function() {

});
