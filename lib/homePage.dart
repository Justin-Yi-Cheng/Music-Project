// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_info.dart';
import 'widgets.dart';

final GlobalKey<MusicCardState> musicCardKey = GlobalKey<MusicCardState>();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isPlaying = false;

  late Future firebaseInfo;

  @override
  void initState() {
    super.initState();
    firebaseInfo = getFirebaseInfo();
  }

  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(
        future: firebaseInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Loading...",
                    style: GoogleFonts.lexend(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaleFactor: 3,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 8,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: appWidth,
                        height: 200,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color.fromRGBO(77, 0, 175, 1),
                              Color(0xff9D00FF),
                            ],
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 8.0, 16.0, 8.0),
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        userData["Playlist-Profile"]),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome",
                                  style: GoogleFonts.lexend(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textScaleFactor: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 0, 8.0, 16.0),
                                  child: Text(
                                    userData["Name"],
                                    style: GoogleFonts.lexend(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textScaleFactor: 4,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Playlist",
                    style: GoogleFonts.lexend(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaleFactor: 2,
                  ),
                ),
                StreamBuilder(
                  stream: firebaseInfo.asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(
                            strokeWidth: 8,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      key: musicCardKey,
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                      scrollDirection: Axis.vertical,
                      itemCount: userData["Music-List"].length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> music =
                            userData["Music-List"][index];
                        return MusicCard(
                          songName: music["Music-Name"],
                          artist: music["Music-Artist"],
                          profile: NetworkImage(music["Music-Profile"]),
                          source:
                              DeviceFileSource(music["Music-Device-Source"]),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
