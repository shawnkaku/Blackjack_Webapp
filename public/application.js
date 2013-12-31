$(document).ready(function(){
  player_hits();
  player_stay();
  dealer_hits();
});

function player_hits(){
  $(document).on("click", "form#player_hit_form input", function(){
    $.ajax({
      type: "POST",
      url: "/game/player/hit"
    }).done(function(msg){
      $("#game").replaceWith(msg)
    });
    return false;
  });
}
function player_stay(){
  $(document).on("click", "form#player_stay_form input", function(){
    $.ajax({
      type: "POST",
      url: "/game/player/stay"
    }).done(function(msg){
      $("#game").replaceWith(msg)
    });
    return false;
  });
}
function dealer_hits(){
  $(document).on("click", "form#dealer_hit_form input", function(){
    $.ajax({
      type: "POST",
      url: "/game/dealer/hit"
    }).done(function(msg){
      $("#game").replaceWith(msg)
    });
    return false;
  });
}

