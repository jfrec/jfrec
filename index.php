<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>jfRec demo</title>
<script src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
   loadJfrec();
   //loadPermission();
});
function loadJfrec(){
	swfobject.embedSWF("jfrec.swf", "jfrec", "1", "1", "10.0.0", false);
}
function loadPermission(){
	swfobject.embedSWF("setPermissions.swf", "recorderDIV", "215", "138", "10.0.0", false);
}
</script>
<link rel="stylesheet" type="text/css" href="./jfrec.css" />
</head>
<body>
<div id="recorderHolderDIV">
  <div id="jfrec"></div>
  <div>Stream Duration: <span id="streamDuration">00:00</span></div>
  <div id="meterBorder">
    <div id="meter"></div>
  </div>
  <br>
  <span class="link"><img title="record" src="images/Player_Record.png"></span>
  <span class="link"><img title="stop" src="images/Player_Stop.png"></span>
  <span class="link"><img title="play" src="images/Player_Play.png"></span>
  <hr class="hrBlueLine" />
</div>
<span id="recorderDIV">&nbsp;</span>
</body>
</html>