// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var playIndex = 0.obs;
  var isPlaying = false.obs;

  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;



  @override
  void onInit() {
    super.onInit();
    CheckPermission();
  }

  UpdatePosition () {
    audioPlayer.durationStream.listen((d) { 
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((d) { 
      position.value = d.toString().split(".")[0];
      value.value = d.inSeconds.toDouble();
    });

  }

  ChangeDurationToSeconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);

  }

  PlayAudio(String? uri ,  index) {
playIndex.value = index;
    try {
  audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
  audioPlayer.play();
  isPlaying(true);
  UpdatePosition();
} on Exception catch (e) {
  print(e.toString());
}
  }

  CheckPermission() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
    } else {
      CheckPermission();
    }
  }
}
