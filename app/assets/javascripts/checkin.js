var Checkin = {
  selected_color: "#F58220",
  unselected_color: "#333",

  open:
    function(element) {
      $('.modal-header h3').text(element.attr('feat-name'));
      $('#d_checkin').modal('show');
      $('#d_checkin').on('show', function () {
          $('#d_checkin_pre').css('display','block');
      });

      $('input:hidden[id=checkin_feat_id]').val(element.attr('feat-id'));
      $('input:radio[id=checkin_epic_0]').attr('checked',true);
      $('input:radio[id=checkin_epic_0]').parent().css({color: this.selected_color});
      $('input:radio[id=checkin_epic_0]').parent().siblings().css({color: this.unselected_color});
      $('input:radio[id=checkin_privacy_3]').attr('checked',true);
      $('input:radio[id=checkin_privacy_3]').parent().css({color: this.selected_color});
      $('input:radio[id=checkin_privacy_3]').parent().siblings().css({color: this.unselected_color});

      $('input:radio').live('click', function(){
        $(this).parent().css({color: '#F58220'});
        $(this).parent().siblings().css({color: '#333'});
      });
    },

  close:
    function() {
      $('#d_checkin').modal('hide');
      $('#d_checkin').on('hidden', function () {
          $('#d_checkin_post').text('');
      })
    },

  test:
    function() {
      alert("this is javascript module!");
    }
};
