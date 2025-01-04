import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_video_downloader/service/downloadservice.dart';
import 'package:youtube_video_downloader/service/permission_handler.dart';
import 'package:youtube_video_downloader/service/snackbarservice.dart';

class Downloadstart extends StatefulWidget {
  String videoID;
  Downloadstart({super.key, required this.videoID});

  @override
  State<Downloadstart> createState() => _DownloadstartState();
}

class _DownloadstartState extends State<Downloadstart> {
  bool downloadstart = false;
  double progess = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return downloadstart
        ? SizedBox(
            height: height * .1,
            width: width * .8,
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progess / 100.0,
                    backgroundColor: Colors.black,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                    '${progess.toString().length < 3 ? progess.toString() : progess.toString().substring(0, 4)}%'),
              ],
            ),
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
                      await Downloadservice.downloadvideo(widget.videoID,
                              "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4")
                          .then((value) async {
                        downloadstart = false;
                      });
                    } else {
                      // ignore: use_build_context_synchronously
                      Snackbarservice.showSnackBar(context,
                          message: "Permission Denied");
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
                      borderRadius: BorderRadius.circular(height * .02)),
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
                  setState(() {
                    downloadstart = true;
                  });

                  Downloadservice.getaudio(widget.videoID).then((url) async {
                    Directory dir = Directory(
                        '/storage/emulated/0/Download/ytdownloader/MP3');

                    if (await dir.exists() == false) {
                      dir.createSync(recursive: true);
                    }
                    Dio().download(url, "${dir.path}/${DateTime.now().microsecondsSinceEpoch}.mp3").then(
                        (downloaded) {
                      log("${dir.path}/${DateTime.now().microsecondsSinceEpoch}.mp3");
                    }).then((val) {});
                  });
                },
                child: Container(
                  height: height * .06,
                  width: width * .25,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(height * .02)),
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
              ),
            ],
          );
  }
}
