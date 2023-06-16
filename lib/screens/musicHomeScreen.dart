// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o_music/consts/colors.dart';
import 'package:o_music/controller/player_controller.dart';
import 'package:o_music/screens/playerScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/test_style.dart';

class OMusicHomePage extends StatelessWidget {
  const OMusicHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.transparent,
          ),
        ],
        leading: Icon(
          Icons.sort_rounded,
          color: Colors.transparent,
        ),
        title: Text("Tracks",
            style: tStyle(size: 18, family: Bold, color: whiteColor)),
      ),

      body: FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
            ignoreCase: true,
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
          ),
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                "No Audio Files",
                style: TextStyle(
                  fontSize: 20,
                  color: whiteColor,
                ),
              ));
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Obx(
                        () => ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          tileColor: Color.fromARGB(108, 74, 61, 90),
                          title: Text(snapshot.data![index].displayNameWOExt,
                              style: tStyle(family: regular, size: 15)),
                          subtitle: Text(
                            "${snapshot.data![index].artist}",
                            style: tStyle(
                              color: Color.fromARGB(255, 134, 122, 122),
                            ),
                          ),
                          leading: QueryArtworkWidget(
                            id: snapshot.data![index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Icon(
                              Icons.music_note,
                              size: 35,
                              color: whiteColor,
                            ),
                          ),
                          trailing: controller.playIndex.value == index && controller.isPlaying.value
                          ? Icon(
                            Icons.play_arrow,
                            color: whiteColor,
                            size: 30,
                          ):null,
                          onTap: () {
                            Get.to(()=> Player(data: snapshot.data!,));
                            controller.PlayAudio(snapshot.data![index].uri, index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
