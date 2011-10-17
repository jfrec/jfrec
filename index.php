<!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>jfrec demo</title>
  <script type="text/javascript"
    src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script> 
  <script type="text/javascript"
    src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script> 
  <script type="text/javascript" src="./jfrec.js"></script>
  <script type="text/javascript">
$(document).ready(function() {
  loadTest();
  $('#mic_record').click(function() {
    call_start_recording();
  });
  $('#mic_save').click(function() {
    call_save_recording();
  });
  $('#mic_play').click(function() {
    call_play_recording();
  });
});
  </script>
</head>
<body>
  <div id="recorderHolderDIV">
    <input type="button" id="mic_record" value="record" />
    <input type="button" id="mic_save" value="save" />
    <input type="button" id="mic_play" value="play" />
  </div>
  <span id="jfrec">&nbsp;</span>
</body>
</html>
