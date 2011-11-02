function thisMovie(movieName) {
  if (navigator.appName.indexOf("Microsoft") != -1) {
    return window[movieName];
  } else {
    return document[movieName];
  }
}

function loadTest() {
  var flashvars = {};
  flashvars.server = "rtmp://192.168.1.106/videorecorder/";
  flashvars.filename = "recorded_video";
  flashvars.fps = 10;
  flashvars.noVideo = false;
  flashvars.showBar = true;
  flashvars.quality = 90;
  flashvars.keyFrame = 6;
  flashvars.width = 320;
  flashvars.height = 240;
  flashvars.fps = 15;
  flashvars.rate = 44;
 // flashvars.av_mode = "v"; // a-> Audio audio only | v-> Video only | Default value is audio and video


  var params = {};
  params.menu = "false";
  params.salign = "t";
  params.scale = "noscale";
  params.wmode = "transparent";
  params.allowScriptAccess = "always";
  params.noVideo = true;
  params.showBar = false;

  var attributes = {};
  attributes.id = "videorecorder";

  swfobject.embedSWF("videorecorder.swf", "videorecorder", "1", "1", "9.0.0", "", flashvars, params, attributes);
}
// function to manipualte red5 recorder

function startRecord() {
 thisMovie('videorecorder').startRecording();
// start the recording of the video
}
function stopRecord() {
 thisMovie('videorecorder').stopRecording();
// stop the recording of the video
}