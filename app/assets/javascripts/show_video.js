jQuery(function($){
  $("#watch_now_buttom").click(function() {
      $("#video_large_cover").hide();
      $("#video_youtube_url").show();
      $("#video_youtube_url")[0].click();
      return false;
    }
  );
});
