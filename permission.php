<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Allow Recorder</title>
<script src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	loadSWF();
});

function loadSWF(){
	swfobject.embedSWF("setPermissions.swf", "recorderDIV", "215", "138", "10.0.0", false);
}
</script>
</head>
<body>
<span id="recorderDIV">recorder here</span>
</body>
</html>
