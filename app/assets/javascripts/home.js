$('.example').live('click', function(e){
    Checkin.open($(this));
});

$('.btn-close').live('click', function(e){
    Checkin.close();
});