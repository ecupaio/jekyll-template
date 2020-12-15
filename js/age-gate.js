$(function(){
  if (Cookies.get('vl-age') !== 'over 21') {
    $('#age-gate,body,html').addClass('active');
  } 
  $('#age-gate .gate-btn').click(function() {
    if ($(this).hasClass('yes')) {
      Cookies.set('vl-age', 'over 21', { expires: 365 });
      $('#age-gate,body,html').removeClass('active');
    } else {
      window.location = "https://estreet.co";
    }
  });
});