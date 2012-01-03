// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
     /*shows the loading div every time we have an Ajax call*/
//    $("#loading").bind("ajaxSend", function(){
//           $(this).show();
//     }).bind("ajaxComplete", function(){
//           $(this).hide();
//     });

    $('#submit_button').live('click',function(){
        var box = new ajaxLoader($('#d_checkin'), {classOveride: 'blue-loader'});
    });

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

  // sign up modal dialog
  $('.sign_up').click(function(e) {
    var url = $(this).attr('href');
    $.easy.popup('#popup_dialog');
    var dialog_form = $('<div id="dialog-form"><img id="img-loader" src="/images/spinner_squares_circle.gif" alt="Loading"/></div>').dialog({
      autoOpen: false,
      width: 470,
      modal: true,
      closeText: "X",
      position: ['center', 120],
      open: function() {
        return $(this).load(url + ' #d_signup');
      }
    });
    dialog_form.dialog('open');
    e.preventDefault();

    $(window).resize(function(){
      dialog_form.dialog( 'option', 'position', 'center' );
    });
  });

  // sign in modal dialog
  $('.sign_in').click(function(e) {

    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form"><img class="center" id="img-loader" src="/images/spinner_squares_circle.gif" alt="Loading"/></div>').dialog({
      autoOpen: false,
      width: 460,
      modal: true,
      closeText: "X",
      position: ['center', 120],
      open: function() {
        return $(this).load(url + ' #d_signin');
      }
    });
    dialog_form.dialog('open');
    e.preventDefault();

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

  // check in modal dialog
  $('.featcheckin').click(function(e) {
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form"><img id="img-loader" src="/images/spinner_squares_circle.gif" alt="Loading"/></div>').dialog({
      autoOpen: false,
      width: 420,
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
    dialog_form.dialog('open');
    e.preventDefault();

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
  if ($('#challenge_feat_tokens').length > 0){
    $('#challenge_feat_tokens').tokenInput('/view/feats/feat_tokens.json', {
      hintText: "输入名称进行检索",
      searchingText: "检索中...",
      noResultsText: "无匹配结果",
      crossDomain: false,
      preventDuplicates: true,
      prePopulate: $('#challenge_feat_tokens').data('pre')
//      theme: 'facebook'
    });
  }
  if ($('#feat_tag_tokens').length > 0){
    $('#feat_tag_tokens').tokenInput('/admin/tags/feat_tag_tokens.json', {
      crossDomain: false,
      preventDuplicates: true,
      prePopulate: $('#feat_tag_tokens').data('pre')
//      theme: 'facebook'
    });
  }
  if ($('#reward_tag_tokens').length > 0){
    $('#reward_tag_tokens').tokenInput('/admin/tags/reward_tag_tokens.json', {
      crossDomain: false,
      preventDuplicates: true,
      prePopulate: $('#reward_tag_tokens').data('pre')
//      theme: 'facebook'
    });
  }

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


  // auto expand textarea
  $('textarea').focus( function () {
    $(this).animate({ height: "40px" });
    $(this).next('.giveprop').show();
    return false;
  });
//  $('textarea').focus( function () {
//    $(this).animate({ height: "40px" });
//    return false;
//  }).blur(function (){
//    $(this).animate({ height: "20px" });
//  });

    // checkin dialog form
     $('.epic > div').live('click', function () {
        $('#checkin_epic').val( $(this).attr('epic') );
        $(this).css({'color': '#F58220'});
        $(this).siblings().css({'color': '#828584'});
        $('.textblock').find('.text').text( $(this).attr('text') );
    })

    $('.privacy > div').live('click', function () {
        $('#checkin_privacy').val( $(this).attr('privacy') );
        $(this).css({'color': '#F58220'});
        $(this).siblings().css({'color': '#828584'});
    })


});

