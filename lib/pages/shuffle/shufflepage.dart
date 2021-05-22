import 'package:flutter/material.dart';
import 'package:fungji/controller/random_controller.dart';
import 'package:fungji/pages/shuffle/askShuffleSong.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'shufflesong1.dart';

class ShufflePage extends StatefulWidget {
  @override
  _ShufflePageState createState() => _ShufflePageState();
}

class _ShufflePageState extends State<ShufflePage> {
  final randomController = Get.find<RandomController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('ไม่รู้จะฟังเพลงอะไรใช่มั้ย ?',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.kanit(fontSize: 22))),
            Padding(
                padding: EdgeInsets.zero,
                child: Text('ให้ fungji ช่วยสิ',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.kanit(
                        fontSize: 25, fontWeight: FontWeight.bold))),
            (Image.asset(
              "assets/images/random.png",
              width: 320,
              alignment: Alignment.center,
            )),
            FlatButton(
              onPressed: () {
                // randomController.changeIsTapRandom(true);
                Get.toNamed('/shuffleSongScreen1');
              },
              child: Text(
                'TAP TO RANDOM',
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
              color: Colors.indigo[400],
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
