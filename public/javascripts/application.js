// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

  // initialize active subnav menu
   $(".menu li span").find("#subnavActive").parent().show();

  // menu hover effect
  $(".menu li").hover(function() {
    $(this).parent().parent().find("#subnavActive").parent().hide();
    $(this).find("span").show();
    $(this).find("div").css({"border-color":"#CB4415"});
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


// Plan feats
  if ($('.plan_feat').length > 0 ) {
// hides the slickbox as soon as the DOM is ready
    $('.planoptions').hide();
// shows the slickbox on clicking the noted link
    $('a.planLink').click(function() {
      $(this).parent().hide();
      $(this).parent().next('.planoptions').show('slow');
      return false;
    });
    $('a.closeLink').click(function() {
      $(this).parent().hide('slow')
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
});

