import 'package:flutter/material.dart';
import 'package:fungji/controller/random_controller.dart';
import 'package:fungji/helperFunctions/sharedpref_helper.dart';
import 'package:fungji/services/database.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShuffleSongPage extends StatefulWidget {
  @override
  _ShuffleSongPageState createState() => _ShuffleSongPageState();
}

class _ShuffleSongPageState extends State<ShuffleSongPage> {
  final randomController = Get.find<RandomController>();

  DocumentReference linkRef;
  bool showItem = false;
  int randNum = 1;
  String username;
  Stream musicsStream;
  Map musicData;
  bool isAdd = false;

  List<String> videoID = [
    "https://youtu.be/MeGaR_2EQao",
    "https://www.youtube.com/watch?v=lY__VKI0Vs8",
    "https://www.youtube.com/watch?v=0krQNAz7kbw",
  ];

  getAllMusic() async {
    musicsStream = await DatabaseMethods().getMusicList();
    username = await SharedPreferenceHelper().getUserName();
    setState(() {});
  }

  addMusicToMyPlayList(musicInfo) {
    DatabaseMethods().addMusicToMyPlayList(musicInfo);
  }

  @override
  void initState() {
    getAllMusic();
    super.initState();
  }

  final utube =
      RegExp(r"^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -5,
        backgroundColor: Colors.white,
        title: Text('fungji',
            style:
                GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black))),
        actions: <Widget>[
          IconButton(
            icon: Image.asset("assets/images/logout.png"),
            onPressed: () {
              print('Click for logout');
            },
          ),
        ],
        leading: IconButton(
          icon: Image.asset("assets/images/logo.png"),
          onPressed: () {
            // print('Click start');
          },
        ),
      ),
      body: Center(
        child: Container(
            child: StreamBuilder(
          stream: musicsStream,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              randomController.setListItemCount(snapshot.data.docs.length);
              Map<String, dynamic> newMusicData = {
                "image": snapshot
                    .data.docs[randomController.randomSongIndex.value]['image'],
                "title": snapshot
                    .data.docs[randomController.randomSongIndex.value]['title'],
                "channelName":
                    snapshot.data.docs[randomController.randomSongIndex.value]
                        ['channelName'],
                "videoID": snapshot.data
                    .docs[randomController.randomSongIndex.value]['videoID'],
                "username": username
              };

              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('เพลงที่ fungji สุ่มให้คุณ',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.kanit(fontSize: 22))),
                  Padding(
                      padding: EdgeInsets.zero,
                      child: Text('ในวันนี้ก็คือ . . .',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.kanit(
                              fontSize: 25, fontWeight: FontWeight.bold))),
                  Obx(() {
                    return Flexible(
                        child: Container(
                      margin: EdgeInsets.all(8),
                      child: YoutubePlayer(
                        controller: YoutubePlayerController(
                            initialVideoId: YoutubePlayer.convertUrlToId(
                                snapshot.data.docs[randomController
                                    .randomSongIndex.value]['videoID']),
                            flags: YoutubePlayerFlags(
                              autoPlay: false,
                              enableCaption: true,
                            )),
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.blue,
                        progressColors: ProgressBarColors(
                            playedColor: Colors.blue,
                            handleColor: Colors.blueAccent),
                      ),
                    ));
                  }),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                        snapshot.data
                                .docs[randomController.randomSongIndex.value]
                            ['title'],
                        style: GoogleFonts.kanit(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  // SizedBox(
                  //   height: 45,
                  //   width: 230,
                  //   child: OutlineButton(
                  //     color: Colors.black,
                  //     child: new Text(
                  //       'RANDOM AGAIN',
                  //       style: GoogleFonts.kanit(
                  //           textStyle: TextStyle(
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //               fontWeight: FontWeight.bold)),
                  //     ),
                  //     borderSide: BorderSide(color: Colors.black),
                  //     onPressed: () {
                  //       // randomController.randomNumber();
                  //       randomController.randomNumber();
                  //       Get.offAndToNamed('/shuffleSongScreen2');
                  //       print('Click for Random again');
                  //     },
                  //     shape: new RoundedRectangleBorder(
                  //         borderRadius: new BorderRadius.circular(20.0)),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {
                        // randomController.randomNumber();
                        randomController.randomNumber();
                        Get.offAndToNamed('/shuffleSongScreen2');
                        print('Click for Random again');
                      },
                      child: Text(
                        'RANDOM AGAIN',
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      minWidth: 230,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      height: 50,
                      color: Colors.deepPurple[300],
                      textColor: Colors.white,
                    ),
                  ),
                  !isAdd
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            onPressed: () {
                              addMusicToMyPlayList(newMusicData);
                              Get.snackbar('Success', 'add to play list');
                              setState(() {
                                isAdd = true;
                              });
                            },
                            child: Text(
                              'ADD TO MY PLAYLIST',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            minWidth: 230,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            height: 50,
                            color: Colors.green[400],
                            textColor: Colors.white,
                          ),
                        )
                      : Container()
                ],
              );
            } else {
              return Container();
            }
          },
        )),
      ),
    );
  }
}
