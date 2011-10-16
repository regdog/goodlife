// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Tokeninputs
$(function () {
  $('#challenge_feat_tokens').tokenInput('/admin/feats/feat_tokens.json', {
      crossDomain: false,
      preventDuplicates: true,
      prePopulate: $('#challenge_feat_tokens').data('pre')
//      theme: 'facebook'
  });

  $('#feat_tag_tokens').tokenInput('/admin/tags/feat_tag_tokens.json', {
      crossDomain: false,
      preventDuplicates: true,
      prePopulate: $('#feat_tag_tokens').data('pre'),
      theme: 'facebook'
  });

  $('#reward_tag_tokens').tokenInput('/admin/tags/reward_tag_tokens.json', {
      crossDomain: false,
      preventDuplicates: true,
      prePopulate: $('#reward_tag_tokens').data('pre'),
      theme: 'facebook'
  });
});

