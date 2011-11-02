function thisMovie(movieName) {
  if (navigator.appName.indexOf("Microsoft") != -1) {
    return window[movieName];
  } else {
    return document[movieName];
  }
}

function loadTest() {
  var flashvars = {};
  flashvars.server = "rtmp://192.168.1.106/red5recorder/";
  flashvars.filename = "recorded_audio";
  flashvars.fps = 10;
  flashvars.noVideo = false;
  flashvars.showBar = true;
  flashvars.quality = 90;
  flashvars.keyFrame = 6;


  var params = {};
  params.menu = "false";
  params.salign = "t";
  params.scale = "noscale";
  params.wmode = "transparent";
  params.allowScriptAccess = "always";
  params.noVideo = true;
  params.showBar = false;

  var attributes = {};
  attributes.id = "red5recorder";

  swfobject.embedSWF("red5recorder.swf", "red5recorder", "1", "1", "9.0.0", "", flashvars, params, attributes);
}
// function to manipualte red5 recorder

function startRecord() {
 thisMovie('red5recorder').startRecording();
// start the recording of the video
}
function stopRecord() {
 thisMovie('red5recorder').stopRecording();
// stop the recording of the video
}