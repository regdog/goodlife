// toggle checkin expanded content

$('.open-checkin').live('click', function () {
    $(this).closest('.stream-checkin').attr('expanded') == 0 ? $(this).closest('.stream-checkin').attr('expanded',1) : $(this).closest('.stream-checkin').attr('expanded',0);
    if ($(this).closest('.stream-checkin').attr('expanded') == 0){
        $(this).find('a').text('展开');
//        $(this).find('.time').html("<span class='open-checkin'><a href='javascript:void(0);'>收起</a>");
//        $(this).find('.actions').toggle();
    }else {
//        $(this).closest('.stream-checkin').find('.time').html("<span class='open-checkin'><a href='javascript:void(0);'>收起</a>");
        $(this).find('a').text('收起');
    }
    if ($(this).closest('.stream-checkin').is($('.stream-checkin').last())) {
        $('.checkinslist:last-child').css('border-bottom', 0);
        $('.stream-checkin').last().css('border-bottom', '1px solid #E8E8E8');
    }
    if ($(this).closest('.stream-checkin').is($('.stream-checkin').first())) {
        $(this).closest('.stream-checkin').css('margin-top', 0);
    }
    if ($(this).closest('.stream-checkin').prev().attr('expanded') == 1){
        $(this).closest('.stream-checkin').prev().css('border-bottom', 0);
    }else{
        if ($(this).closest('.stream-checkin').attr('expanded') == 0){
            $(this).closest('.stream-checkin').prev().css('border-bottom', 0);
        }else{
            $(this).closest('.stream-checkin').prev().css('border-bottom', '1px solid #E8E8E8');
        }
    }
    if ($(this).closest('.stream-checkin').next().attr('expanded') == 1){
        $(this).closest('.stream-checkin').css('border-bottom', '1px solid #E8E8E8');
    }

    $(this).closest('.stream-checkin').find('.expanded-content').toggle();
    $(this).closest('.stream-checkin').find('.replies').toggle();
    $(this).closest('.stream-checkin').toggleClass("stream-item-shadow");
});

$('.comment').live('click', function(){
    $('#comment').modal('show');
    $('input:hidden[id=comment_checkin_id]').val($(this).attr('checkin'));
    var checkin_element = $('#'+$(this).attr('checkin')) ;
    $('.modal-header').html('');
    checkin_element.find('img').first().clone().appendTo($('.modal-header'));
    checkin_element.find('.checkin-title').clone().appendTo($('.modal-header'));
    checkin_element.find('.checkin-text').clone().appendTo($('.modal-header'));
});