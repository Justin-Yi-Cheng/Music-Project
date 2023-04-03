import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

// Music Card
class MusicCard extends StatefulWidget {
  const MusicCard({
    super.key,
    required this.songName,
    required this.artist,
    required this.profile,
    required this.source,
  });

  final String songName;
  final String artist;
  final NetworkImage profile;
  final DeviceFileSource source;

  @override
  MusicCardState createState() => MusicCardState();
}

class MusicCardState extends State<MusicCard> {
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;

  Color color = Colors.white;
  bool showSnackBar = false;

  String formatTime(Duration duration) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds - (duration.inMinutes * 60))
        .toString()
        .padLeft(2, '0');

    return "$minutes:$seconds";
  }

  Future setAudio() async {
    await audioPlayer.setSource(widget.source);
  }

  @override
  void initState() {
    super.initState();
    setAudio();

    audioPlayer.onPlayerStateChanged.listen(
      (state) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      },
    );

    audioPlayer.onDurationChanged.listen(
      (newDuration) {
        setState(() {
          duration = newDuration;
        });
      },
    );

    audioPlayer.onPositionChanged.listen(
      (newPosition) {
        setState(() {
          position = newPosition;
          debugPrint("Hello");
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        elevation: 8.0,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: InkWell(
          onTap: () {
            if (showSnackBar == false) {
              showSnackBar = true;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 16.0,
                  duration: const Duration(days: 365),
                  backgroundColor: const Color(0xffeCeCeC),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => null,
                        splashRadius: 15,
                        iconSize: 20,
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Color(0xff5A5A5A),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () async {
                            if (isPlaying) {
                              await audioPlayer.pause();
                            } else {
                              if (duration.inSeconds > 0) {
                                await audioPlayer.resume();
                              } else {
                                await audioPlayer.play(widget.source);
                              }
                            }
                          },
                          splashRadius: 25,
                          iconSize: 15,
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: const Color(0xff5A5A5A),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => null,
                        splashRadius: 15,
                        iconSize: 20,
                        icon: const Icon(
                          Icons.skip_next,
                          color: Color(0xff5A5A5A),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formatTime(position),
                        style: GoogleFonts.lexend(
                          color: const Color(0xff5A5A5A),
                        ),
                        textScaleFactor: 0.9,
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                            thumbColor: Colors.orange,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 5)),
                        child: Slider(
                          min: 0,
                          max: duration.inSeconds.toDouble(),
                          value: position.inSeconds.toDouble(),
                          onChanged: (value) async {
                            final position = Duration(seconds: value.toInt());

                            await audioPlayer.seek(position);
                          },
                        ),
                      ),
                      Text(
                        formatTime(duration),
                        style: GoogleFonts.lexend(
                          color: const Color(0xff5A5A5A),
                        ),
                        textScaleFactor: 0.9,
                      ),
                      const SizedBox(width: 20.0),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: widget.profile,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.artist,
                            style: GoogleFonts.lexend(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                            textScaleFactor: 0.9,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            widget.songName,
                            style: GoogleFonts.lexend(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                            textScaleFactor: 0.9,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              showSnackBar = false;
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          },
          onHover: (value) =>
              value ? color = Colors.white : color = Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 1.0, 15.0, 1.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                          image: widget.profile, fit: BoxFit.contain),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.songName,
                      style: GoogleFonts.lexend(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.2,
                    ),
                    Text(
                      "By ${widget.artist}",
                      style: GoogleFonts.lexend(
                        color: const Color.fromRGBO(112, 128, 144, 1),
                      ),
                      textScaleFactor: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
