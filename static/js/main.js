$(function(){

  $('.cog-btn').click(function(){
    $('.cog-menu').fadeToggle(200);
    $('.overlay-trans').toggle();
  });

  $('.post-btn').click(function(){
    $('.post-modal').fadeIn(200);
    $('.post-modal textarea').focus();
    $('.overlay').fadeIn(200);
  });

  $('.command-box .edit').click(function(){
    $('.edit-modal').fadeIn(200);
    $('.edit-modal textarea').focus();
    $('.overlay').fadeIn(200);
    var messageId = $(this).parent().data('messageId');
    $('.edit-modal form').attr('action',"/message/" + messageId + "/edit");
    var text = $(this).parent().siblings('.comment').html();
    $('.edit-modal textarea').val(text);
    var img = $(this).parent().siblings('.main-img').html();
    if(img){
      $('.edit-modal .main-img').append(img);
    }
    $('.edit-modal button').removeClass('is-disabled');
    $('.edit-modal button').prop("disabled", false);
  });

  $('.command-box .delete').click(function(){
    $('.delete-modal').fadeIn(200);
    $('.delete-modal button').focus();
    $('.overlay').fadeIn(200);
    var messageId = $(this).parent().data('messageId');
    $('.delete-modal form').attr('action',"/message/" + messageId + "/delete");
    var text = $(this).parent().siblings('.comment').html();
    $('.delete-modal .feed-desc').html(text);
    var img = $(this).parent().siblings('.main-img').html();
    if(img){
      $('.delete-modal .main-img').append(img);
    }
  });

  $('.post-box textarea').bind('keydown keyup keypress change', function(){
    if( $(this).val().length >= 1 ){
      $(this).siblings('button').removeClass('is-disabled');
      $(this).siblings('button').prop("disabled", false);
    } else {
      $(this).siblings('button').addClass('is-disabled');
      $(this).siblings('button').prop("disabled", true);
    }
  });

  $('.overlay').click(function(){
    $(this).fadeOut(200);
    $('.modal-body').fadeOut(200);
    setTimeout(function(){
      $('.post-box textarea').val('');
      $('.post-box .main-img').empty();
    },200);
    $('.post-box button').addClass('is-disabled');
  });

  $('.overlay-trans').click(function(){
    $(this).hide();
    $('.cog-menu').fadeToggle(200);
  });

  $('.close').click(function(){
    $('.overlay').fadeOut(200);
    $('.modal-body').fadeOut(200);
    setTimeout(function(){
      $('.post-box textarea').val('');
      $('.post-box .main-img').empty();
    },200);
    $('.post-box button').addClass('is-disabled');
  });

  $('.prof-icon').hover(
      function(){
        $(this).find('.image-message').show();
      },
      function(){
        $(this).find('.image-message').hide();
      }
  );

  $('form [name=screen_name]').focus();

  $('.input-image.prof').change(function(){
    var selectedFile = this.files[0] ;
    var fileReader = new FileReader() ;
    fileReader.onload = function(event) {
      var dataUri = event.target.result ;
      $('.prof-icon .output-image').attr('src',dataUri);
    };
    fileReader.readAsDataURL( selectedFile ) ;
  });

  $('.post-modal .input-image').change(function(){
    var selectedFile = this.files[0] ;
    var fileReader = new FileReader() ;
    fileReader.onload = function(event) {
      var dataUri = event.target.result ;
      $('.post-modal .output-image').attr('src',dataUri);
      $('.post-modal .output-image-box').show();
    };
    fileReader.readAsDataURL( selectedFile ) ;
  });

  $('.edit-modal .input-image').change(function(){
    var selectedFile = this.files[0] ;
    var fileReader = new FileReader() ;
    fileReader.onload = function(event) {
      var dataUri = event.target.result ;
      $('.edit-modal .output-image').attr('src',dataUri);
    };
    fileReader.readAsDataURL( selectedFile ) ;
  });

  $('.side-column .input-image').change(function(){
    var selectedFile = this.files[0] ;
    var fileReader = new FileReader() ;
    fileReader.onload = function(event) {
      var dataUri = event.target.result ;
      $('.side-column .output-image').attr('src',dataUri);
      $('.side-column .output-image-box').show();
    };
    fileReader.readAsDataURL( selectedFile ) ;
  });
});
