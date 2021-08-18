$(function() {
  //fb share link
  $('.share-btn.fbook').click(function (e) {
    e.preventDefault();
    var link = $(this).attr('href');
    FB.ui({
      method: 'share',
      href: link    
    }, function(response){});
  });
  //copy link
  $('.share-btn.copy').click(function(e) {
    e.preventDefault();
    var copyText = $(this).find('.copy-link');
    copyText.focus();
    copyText.select();
    copyText[0].setSelectionRange(0, 99999); 
    document.execCommand("copy");
    $('.share-btn.copy').addClass('active');
    setTimeout(function(){
      $('.share-btn.copy').removeClass('active');  
    },1000);
  });
  
});