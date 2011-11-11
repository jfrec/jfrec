//include "red5recorder.as";
import flash.media.*;
import flash.events.*;
import flash.utils.ByteArray;
import flash.net.FileReference;
import flash.external.*;


var start_record = ExternalInterface.addCallback("startRecording", recordStart);
var save_record = ExternalInterface.addCallback("stopRecording", recordStop);

var server = getSwfParam('server', "rtmp://terbox.net/videorecorder");
var filename = getSwfParam('filename', "video");
var width_param = getSwfParam('width', "320");
var height_param = getSwfParam('height', "240");
var fps = getSwfParam('fps', "15");
var rate = getSwfParam('rate', "44");
var av_mode = getSwfParam('av_mode', "");

var nc:NetConnection;
var ns:NetStream;
nc = new NetConnection();

nc.connect(server);

if(av_mode == '' || av_mode == 'v'){
  var camera:Camera;
  camera = Camera.getCamera();
  camera.setMode(width_param,height_param, fps);
}
if(av_mode == '' || av_mode == 'a'){
  var myMic:Microphone;
  myMic = Microphone.getMicrophone();
  myMic.rate= rate;
}

// start recording
function recordStart():void {
    ns = new NetStream(nc);
	if(av_mode == '' || av_mode == 'v'){
      ns.attachCamera(camera);
	}
	if(av_mode == '' || av_mode == 'a'){
	  ns.attachAudio(myMic);
	}
    ns.publish(filename, "record");
	/*nc.onStatus = function(info){ 
		if (info.code == "NetConnection.Connect.Success"){
			ExternalInterface.call("streaming_started()");
		}
	};*/
	ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
}

// stop recording
function recordStop():void {
    ns.play(false); // flushes the recording buffer
    ns.close();
}

function getSwfParam(name:String,defaultValue:String):String
{
  var paramObj:Object = LoaderInfo(stage.loaderInfo).parameters;
  if (paramObj[name] != null && paramObj[name] != "")
  {
    return paramObj[name];
  }
  else
  {
    return defaultValue;
  }
}

function netStatusHandler(event:NetStatusEvent):void {
	ExternalInterface.call("streaming_started('"+ event.info.code +"')");
	switch (event.info.code) {
		case "NetConnection.Connect.Success":
			ExternalInterface.call("streaming_started()");
			break;
		case "NetStream.Play.StreamNotFound":
			trace("Unable to locate video: ");
			break;
	}
}