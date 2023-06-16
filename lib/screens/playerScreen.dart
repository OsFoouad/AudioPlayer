// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o_music/consts/colors.dart';
import 'package:o_music/consts/test_style.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controller/player_controller.dart';

class Player extends StatelessWidget {
  const Player({super.key, required this.data});
  final List<SongModel> data;

  @override
  Widget build(BuildContext context) {
    var audioContoller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                  flex: 2,
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: QueryArtworkWidget(
                      id: data[audioContoller.playIndex.value].id,
                      type: ArtworkType.AUDIO,
                      artworkWidth: double.infinity,
                      artworkHeight: double.infinity,
                      nullArtworkWidget: Icon(
                        Icons.music_note,
                        size: 250,
                        color: whiteColor,
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(18),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(117, 161, 155, 194),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Obx(
                  () => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          data[audioContoller.playIndex.value].displayNameWOExt,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style:
                              tStyle(color: whiteColor, size: 20, family: Bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${data[audioContoller.playIndex.value].artist}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: tStyle(
                              color: whiteColor, size: 15, family: regular),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Obx(
                          () => Row(
                            children: [
                              Text(
                                audioContoller.position.value,
                                style: tStyle(color: whiteColor),
                              ),
                              Expanded(
                                  child: Slider(
                                      min: Duration(seconds: 0)
                                          .inSeconds
                                          .toDouble(),
                                      max: audioContoller.max.value,
                                      thumbColor: sliderColor,
                                      inactiveColor: bgColor,
                                      activeColor: sliderColor,
                                      value: audioContoller.value.value,
                                      onChanged: (newValue) {
                                        audioContoller.ChangeDurationToSeconds(
                                            newValue.toInt());
                                        newValue = newValue;
                                      })),
                              Text(
                                audioContoller.duration.value,
                                style: tStyle(color: whiteColor),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                audioContoller.PlayAudio(
                                    data[audioContoller.playIndex.value - 1]
                                        .uri,
                                    audioContoller.playIndex.value - 1);
                              },
                              icon: Icon(
                                Icons.skip_previous_rounded,
                                size: 50,
                                color: whiteColor,
                              ),
                            ),

                            // play button ...
                            Obx(
                              () => IconButton(
                                  onPressed: () {
                                    if (audioContoller.isPlaying.value) {
                                      audioContoller.audioPlayer.pause();
                                      audioContoller.isPlaying(false);
                                    } else {
                                      audioContoller.audioPlayer.play();
                                      audioContoller.isPlaying(true);
                                    }
                                  },
                                  icon: audioContoller.isPlaying.value
                                      ? Icon(
                                          Icons.pause_circle_rounded,
                                          size: 60,
                                          color: whiteColor,
                                        )
                                      : Icon(
                                          Icons.play_arrow_rounded,
                                          size: 60,
                                          color: whiteColor,
                                        )),
                            ),
                            // end of play button ...
                            IconButton(
                                onPressed: () {
                                  audioContoller.PlayAudio(
                                      data[audioContoller.playIndex.value + 1]
                                          .uri,
                                      audioContoller.playIndex.value + 1);
                                },
                                icon: Icon(
                                  Icons.skip_next_rounded,
                                  size: 50,
                                  color: whiteColor,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
