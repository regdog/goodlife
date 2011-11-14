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

  // sign up modal dialog
  $('.sign_up').click(function(e) {
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form">Loading form...</div>').dialog({
      autoOpen: false,
      width: 520,
      modal: true,
      position: ['center', 120],
      open: function() {
        return $(this).load(url + ' #sign_up_content');
      }
    });
    dialog_form.dialog('open');
    e.preventDefault();

    $(window).resize(function(){
      dialog_form.dialog( 'option', 'position', 'center' );
    });

    // Hide the title bar
    //$('.ui-dialog-titlebar-close').hide();

    // Modal Dialog Close on Overlay Click
    $(".ui-widget-overlay").live('click', function () {
      dialog_form.dialog( "close" );
	});

  });

  // sign in modal dialog
  $('.sign_in').click(function(e) {
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form">Loading form...</div>').dialog({
      autoOpen: false,
      width: 520,
      modal: true,
      position: ['center', 120],
      open: function() {
        return $(this).load(url + ' #sign_in_content');
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
    $(".ui-widget-overlay").live('click', function () {
      dialog_form.dialog( "close" );
	});

  });

  // check in modal dialog
  $('.featcheckin').click(function(e) {
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form">Loading form...</div>').dialog({
      autoOpen: false,
      width: 520,
      modal: true,
      position: ['center', 120],
      open: function() {
        return $(this).load(url + ' #checkin');
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
    $(".ui-widget-overlay").live('click', function () {
      dialog_form.dialog( "close" );
	});

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
    $('#challenge_feat_tokens').tokenInput('/admin/feats/feat_tokens.json', {
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
      prePopulate: $('#feat_tag_tokens').data('pre'),
      theme: 'facebook'
    });
  }
  if ($('#reward_tag_tokens').length > 0){
    $('#reward_tag_tokens').tokenInput('/admin/tags/reward_tag_tokens.json', {
      crossDomain: false,
      preventDuplicates: true,
      prePopulate: $('#reward_tag_tokens').data('pre'),
      theme: 'facebook'
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


});

