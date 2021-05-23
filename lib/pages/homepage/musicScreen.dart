import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  var data = Get.arguments;
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
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      data['title'],
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  FlatButton(
                    disabledColor: Colors.transparent,
                    onPressed: () {},
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                              onTap: () {
                                print('Click for add Playlist');
                              },
                              child: Image.asset(
                                "assets/images/add-playlist.png",
                                width: 65,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                        initialVideoId:
                            YoutubePlayer.convertUrlToId(data['videoID']),
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
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'เนื้อเพลง',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data['lyrics'].toString().split("*//").length,
                  itemBuilder: (ctx, index) {
                    var allText = data['lyrics'].toString().split("*//");
                    return Row(
                      children: [
                        Text(
                          allText[index],
                          style: GoogleFonts.kanit(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
