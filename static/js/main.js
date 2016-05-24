$(function(){

  $('.cog-btn').click(function(){
    $('.cog-menu').fadeToggle(200);
    $('.overlay-trans').toggle();
  });

  $('.post-btn').click(function(){
    $('.post-modal').fadeIn(200);
    $('.overlay').fadeIn(200);
  });

  $('.command-box .edit').click(function(){
    $('.edit-modal').fadeIn(200);
    $('.overlay').fadeIn(200);
  });

  $('.command-box .delete').click(function(){
    $('.delete-modal').fadeIn(200);
    $('.overlay').fadeIn(200);
  });

  $('.post-box textarea').bind('keydown keyup keypress change', function(){
    if( $(this).val().length >= 1 ){
      $(this).next().removeClass('is-disabled');
    } else {
      $(this).next().addClass('is-disabled');
    }
  });

  $('.overlay').click(function(){
    $(this).fadeOut(200);
    $('.modal-body').fadeOut(200);
    $('.post-box textarea').val('');
    $('.post-box button').addClass('is-disabled');
  });

  $('.overlay-trans').click(function(){
    $(this).hide();
    $('.cog-menu').fadeToggle(200);
  });

  $('.close').click(function(){
    $('.overlay').fadeOut(200);
    $('.modal-body').fadeOut(200);
    $('.post-box textarea').val('');
    $('.post-box button').addClass('is-disabled');
  });
});
