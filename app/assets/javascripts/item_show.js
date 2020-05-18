$(document).on('turbolinks:load', function(){
  
  $('.main__showMain__topContent__itemBox__body__mainPic__subPic').hover(function(){
    $('#mainPic').attr('src', $(this).attr('src'));
    $(this).css('opacity', '1');
  }, function(){
    $(this).css('opacity', '0.5');
  });
});