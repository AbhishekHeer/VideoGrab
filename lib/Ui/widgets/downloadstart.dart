import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_video_downloader/service/downloadservice.dart';
import 'package:youtube_video_downloader/service/permission_handler.dart';
import 'package:youtube_video_downloader/service/snackbarservice.dart';

class Downloadstart {
  static Widget downloadstart(BuildContext context, double height, double width,
      bool downloadstart, String videoID) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          onTap: () async {
            downloadstart = true;

            try {
              Future<bool> permssionstatus =
                  PermissionHandler().permission(context);
              if (await permssionstatus == true) {
                Directory dir =
                    Directory("/storage/emulated/0/Download/ytdownloader/MP4");
                if (await dir.exists() == false) {
                  await dir.create(recursive: true);
                }
                await Downloadservice.downloadvideo(videoID,
                        "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4")
                    .then((value) async {
                  Snackbarservice.showSnackBar(context, "Downloaded",
                      color: Colors.green);
                  downloadstart = false;
                });
              } else {
                Snackbarservice.showSnackBar(context, "Permission Denied");
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
            Downloadservice.getaudio(videoID).then((url) async {
              Directory dir =
                  Directory('/storage/emulated/0/Download/ytdownloader/MP3');

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
