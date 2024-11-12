import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_video_downloader/service/downloadservice.dart';
import 'package:youtube_video_downloader/service/permission_handler.dart';
import 'package:youtube_video_downloader/service/snackbarservice.dart';

class Playvideo extends StatefulWidget {
  final String title;
  final String channelname;
  final String videoID;
  const Playvideo(
      {super.key,
      required this.title,
      required this.videoID,
      required this.channelname});

  @override
  State<Playvideo> createState() => _PlayvideoState();
}

bool isheart = false;

bool downloadstart = false;

class _PlayvideoState extends State<Playvideo> {
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller =
        YoutubePlayerController(initialVideoId: widget.videoID);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          widget.channelname,
          style: GoogleFonts.poppins(fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                  height: height * .3,
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: YoutubePlayer(
                    controller: controller,
                  )),
            ),
            SizedBox(width: 0.0, height: height * .02),
            Container(
              height: height * .1,
              padding: EdgeInsets.symmetric(
                horizontal: width * .03,
              ),
              width: width * .96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height * .02),
                color: Colors.white24,
              ),
              child: Center(
                  child: AutoSizeText(widget.title,
                      style: GoogleFonts.poppins(fontSize: 15))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * .05, vertical: height * .03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isheart = !isheart;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white30,
                      radius: width * .07,
                      child: Center(
                        child: Icon(
                          isheart
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final String url =
                          "https://www.youtube.com/watch?v=${widget.videoID}";
                      await Share.share(url);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white30,
                      radius: width * .07,
                      child: const Center(
                        child: Icon(
                          Icons.share,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: CircleAvatar(
                      backgroundColor: Colors.white30,
                      radius: width * .07,
                      child: const Center(
                        child: Icon(Icons.download),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: SizedBox(
                height: height * .07,
                width: width * .96,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AutoSizeText(
                        widget.channelname.length > 20
                            ? "${widget.channelname.substring(0, 20)}..."
                            : widget.channelname,
                        style: GoogleFonts.poppins(fontSize: width * .04),
                      ),
                      const Icon(
                        CupertinoIcons.chevron_right,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: height * .1,
              child: Center(
                child: Text(
                  "Download :",
                  style: GoogleFonts.poppins(
                      fontSize: width * .05, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            downloadstart
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          setState(() {
                            downloadstart = true;
                          });
                          try {
                            Future<bool> permssionstatus =
                                PermissionHandler().permission(context);
                            if (await permssionstatus == true) {
                              Directory dir = Directory(
                                  "/storage/emulated/0/Download/ytdownloader/MP4");
                              if (await dir.exists() == false) {
                                await dir.create(recursive: true);
                              }
                              await Downloadservice.downloadvideo(
                                      widget.videoID,
                                      "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4")
                                  .then((value) async {
                                Snackbarservice.showSnackBar(
                                    context, "Downloaded",
                                    color: Colors.green);
                                setState(() {
                                  downloadstart = false;
                                });
                              });
                            } else {
                              Snackbarservice.showSnackBar(
                                  context, "Permission Denied");
                            }
                          } catch (e) {
                            throw Exception(e);
                          }
                        },
                        child: Container(
                          height: height * .06,
                          width: width * .25,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.circular(height * .02)),
                          child: Center(
                            child: Text(
                              "mp4",
                              style: GoogleFonts.poppins(
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Downloadservice.getaudio(widget.videoID)
                              .then((url) async {
                            Directory dir = Directory(
                                '/storage/emulated/0/Download/ytdownloader/MP3');

                            if (await dir.exists() == false) {
                              dir.createSync(recursive: true);
                            }
                            Dio()
                                .download(url,
                                    "${dir.path}/${DateTime.now().microsecondsSinceEpoch}.mp3")
                                .then((downloaded) {
                              log("${dir.path}/${DateTime.now().microsecondsSinceEpoch}.mp3");
                              Snackbarservice.showSnackBar(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  "Downloaded Successfully");
                            });
                          });
                        },
                        child: Container(
                          height: height * .06,
                          width: width * .25,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.circular(height * .02)),
                          child: Center(
                            child: Text(
                              "mp3",
                              style: GoogleFonts.poppins(
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }

  inistialState() {
    super.initState();
  }
}
