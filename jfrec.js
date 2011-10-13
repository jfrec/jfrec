function thisMovie(movieName) {
  if (navigator.appName.indexOf("Microsoft") != -1) {
    return window[movieName];
  } else {
    return document[movieName];
  }
}

function call_start_recording() {
  thisMovie('jfrec').start_recording();
  if ($('#mic_record').val() == 'record') {
    $('#mic_record').val('stop');
  } else {
    $('#mic_record').val('record');
  }
}

function call_save_recording(){
  alert(thisMovie("jfrec").save_recording());
}

function call_play_recording(){
  thisMovie("jfrec").play_recording();
}

function loadTest() {
  var flashvars = {};
  flashvars.save_path = "save_wav.php";

  var params = {};
  params.menu = "false";
  params.salign = "t";
  params.scale = "noscale";
  params.wmode = "transparent";
  params.allowScriptAccess = "always";

  var attributes = {};
  attributes.id = "jfrec";

  swfobject.embedSWF("jfrec.swf", "jfrec", "1", "1", "9.0.0", "", flashvars, params, attributes);
}

