// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Tokeninput
$(function () {
  $('#challenge_feat_tokens').tokenInput('/admin/feats/feat_tokens.json', {
      crossDomain: false,
      preventDuplicates: true,
      prePopulate: $('#challenge_feat_tokens').data('pre')
//      theme: 'facebook'
  });
});

