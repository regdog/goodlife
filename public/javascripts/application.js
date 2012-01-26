// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


$(document).ready(function() {

  // initialize active subnav menu
   $(".menu li span").find("#subnavActive").parent().show();

  // menu hover effect
  $(".menu li").hover(function() {
    $(this).parent().parent().find("#subnavActive").parent().hide();
    $(this).find("span").show();
    $(this).find("div").css({"border-color":"#F58220"});
  }, function() {
    $(this).find("span").hide();
    $(this).find("div").css({"border-color":"#828584"});
  });

  // restoring the active subnav menu
  $(".menu").hover(function() {
    //
  }, function() {
    $(this).find("#subnavActive").parent().show();
  });

  // menu hover effect
  $(".menu li").hover(function() {
      $(this).css({"border-color":"#F58220"});
      $(this).find("ul").show();
  }, function() {
    $(this).css({"border-color":"#828584"});
    $(this).find("ul").hide();
  });



  // sign up modal form
  $('.sign_up').live('click', function(e) {
//    if ($('#dialog-form').length > 0 ) {$('#dialog-form').remove();}
    $('#dialog-form').remove();
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form"><img id="img-loader" src="/images/spinner_squares_circle.gif" alt="Loading"/></div>').dialog({
      autoOpen: false,
      width: 470,
//      height: 560,
      modal: true,
      position: ['center', 120],
      closeText: "X",
      open: function() {
        return $(this).load(url + ' #d_signup');

      }
    });
    e.preventDefault();
    dialog_form.dialog('open');

    $(window).resize(function(){
      dialog_form.dialog( 'option', 'position', 'center' );
    });

    // Hide the close button
    //jQuery('.ui-dialog-titlebar-close').hide();

    // Modal Dialog Close on Overlay Click
//    $(".ui-widget-overlay").live('click', function () {
//      dialog_form.dialog( "close" );
//	});
  });

  // sign in modal dialog
  $('.sign_in').live('click', function(e) {
    $('#dialog-form').remove();
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form"><img class="center" id="img-loader" src="/images/spinner_squares_circle.gif" alt="Loading"/></div>').dialog({
      autoOpen: false,
      width: 460,
      height: 380,
      modal: true,
      closeText: "X",
      open: function() {
        return $(this).load(url + ' #d_signin');
      }
    });
    e.preventDefault();
    dialog_form.dialog('open');

    $(window).resize(function(){
      dialog_form.dialog( 'option', 'position', 'center' );
    });
  });

  // forget password modal dialog
  $('.reset_password').live('click', function(e) {
    $('#dialog-form').remove();
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form"><img class="center" id="img-loader" src="/images/spinner_squares_circle.gif" alt="Loading"/></div>').dialog({
      autoOpen: false,
      width: 460,
      height: 280,
      modal: true,
      closeText: "X",
      open: function() {
        return $(this).load(url + ' #d_reset_password');
      }
    });
    e.preventDefault();
    dialog_form.dialog('open');

    $(window).resize(function(){
      dialog_form.dialog( 'option', 'position', 'center' );
    });
  });

  // resend confirmation modal dialog
  $('.resend_confirmation').live('click', function(e) {
    $('#dialog-form').remove();
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form"><img class="center" id="img-loader" src="/images/spinner_squares_circle.gif" alt="Loading"/></div>').dialog({
      autoOpen: false,
      width: 460,
      height: 280,
      modal: true,
      closeText: "X",
      open: function() {
        return $(this).load(url + ' #d_resend_confirmation');
      }
    });
    e.preventDefault();
    dialog_form.dialog('open');

    $(window).resize(function(){
      dialog_form.dialog( 'option', 'position', 'center' );
    });
  });

  // resend unlock modal dialog
  $('.resend_unlocks').live('click', function(e) {
    $('#dialog-form').remove();
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form"><img class="center" id="img-loader" src="/images/spinner_squares_circle.gif" alt="Loading"/></div>').dialog({
      autoOpen: false,
      width: 460,
      height: 280,
      modal: true,
      closeText: "X",
      open: function() {
        return $(this).load(url + ' #d_resend_unlocks');
      }
    });
    e.preventDefault();
    dialog_form.dialog('open');

    $(window).resize(function(){
      dialog_form.dialog( 'option', 'position', 'center' );
    });
  });

  // check in modal dialog form
  $('.featcheckin').live('click', function(e) {
    $('#dialog-form').remove();
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form"><img id="img-loader" src="/images/spinner_squares_circle.gif" alt="Loading"/></div>').dialog({
      autoOpen: false,
      width: 420,
      height: 260,
      closeText: "X",
      modal: true,
//      overlay: {
//          backgroundColor: '#000',
//          opacity: 0.5
//      },
//      buttons:{ "Shutup": function() { $(this).dialog("close"); } },
      position: ['center', 120],
      open: function() {
        return $(this).load(url + ' #d_checkin');
      }
    });
    e.preventDefault();
    dialog_form.dialog('open');

    $(window).resize(function(){
//        $('#new_checkin').validationEngine('hide');
        dialog_form.dialog( 'option', 'position', 'center' );
    });
  });

    $('.epic > div').live('click', function () {
        $('#checkin_epic').val( $(this).attr('epic') );
        $(this).css({'color': '#F58220'});
        $(this).siblings().css({'color': '#828584'});
        $('.textblock').find('.text').text( $(this).attr('text') );
        if ($(this).attr('epic') == 'true'){
            $('.message > textarea').removeClass('validate[required]');
            $('.message > textarea').addClass('validate[required,minSize[60]]');
        }else{
           $('.message > textarea').removeClass('validate[required,minSize[60]]');
           $('.message > textarea').addClass('validate[required] text-input');
        }
        $('#new_checkin').validationEngine('hide');
    });

    $('.privacy > div').live('click', function () {
        $('#checkin_privacy').val( $(this).attr('privacy') );
        $(this).css({'color': '#F58220'});
        $(this).siblings().css({'color': '#828584'});
    });

    $('.location > span > sup').live('click', function () {
        $('.location').html('');
        $('#checkin_location').val('');
    });

    $('#submit_button').live('click',function(e){
        if ($('#new_checkin').validationEngine('validate')) {
            var box = new ajaxLoader($('#d_checkin'), {classOveride: 'blue-loader'});
            return true;
        }else{
            return false;
        }
    //        $("#new_checkin").validationEngine({
    //            onSuccess: function(){
    //            },
    //            onFailure: function(){
    //            }
    //        });
    });


// Plan feats
  if ($('.featplan').length > 0 ) {
    // hides the slickbox as soon as the DOM is ready
    $('.planoptions').hide();

    // shows the slickbox on clicking the noted link
    $('a.planLink').click(function() {
      $(this).parent().hide();
      $(this).parent().parent().prev('.middle').hide();
      $(this).parent().next('.planoptions').show('slow');
      return false;
    });
    // restore feat grid when closing the planoptions
    $('a.closeLink').click(function() {
      $(this).parent().hide();
      $(this).parent().parent().prev('.middle').show('slow');
      $(this).parent().prev('.plannote').show('slow');
      return false;
    });
  }


// Tokeninputs
//  if ($('#challenge_feat_tokens').length > 0){
//    $('#challenge_feat_tokens').tokenInput('/view/feats/feat_tokens.json', {
//      hintText: "输入名称进行检索",
//      searchingText: "检索中...",
//      noResultsText: "无匹配结果",
//      crossDomain: false,
//      preventDuplicates: true,
//      prePopulate: $('#challenge_feat_tokens').data('pre')
//    });
//  }


  // feat checkin tabs
    $(function () {
        var tabContainers = $('div.tabs > div');

        $('div.tabs ul.tabnav a').click(function () {
            tabContainers.hide().filter(this.hash).show();

            $('div.tabs ul.tabnav a').removeClass('selected');
            $(this).addClass('selected');

            return false;
        }).filter(':first').click();
    });

  //remove all validation prompts when the dialog form is closed
  $('#dialog-form').live('dialogclose', function(){
      $('#new_checkin').validationEngine('hide');
  });

});