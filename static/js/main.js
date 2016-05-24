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
    var messageId = $(this).parent().data('messageId');
    $('.edit-modal form').attr('action',"/message/" + messageId + "/edit");
    var text = $(this).parent().siblings('.comment').html();
    $('.edit-modal textarea').val(text);
  });

  $('.command-box .delete').click(function(){
    $('.delete-modal').fadeIn(200);
    $('.overlay').fadeIn(200);
    var messageId = $(this).parent().data('messageId');
    $('.delete-modal form').attr('action',"/message/" + messageId + "/delete");
    var text = $(this).parent().siblings('.comment').html();
    $('.delete-modal .feed-desc').html(text);
  });

  $('.post-box textarea').bind('keydown keyup keypress change', function(){
    if( $(this).val().length >= 1 ){
      $(this).next().removeClass('is-disabled');
      $(this).next().prop("disabled", false);
    } else {
      $(this).next().addClass('is-disabled');
      $(this).next().prop("disabled", true);
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
