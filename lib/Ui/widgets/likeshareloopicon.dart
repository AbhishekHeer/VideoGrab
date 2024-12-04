import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_video_downloader/models/videodetialmodel.dart';
import 'package:youtube_video_downloader/service/sharedprefs.dart';
import 'package:youtube_video_downloader/service/snackbarservice.dart';

class Likeshareloopicon {
  static Widget icons(
      BuildContext context,
      bool isliked,
      int length,
      String videoID,
      String title,
      String channelname,
      Duration duration,
      double height,
      double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            if (isliked) {
              isliked = false;
              Sharedprefs.removevideo(length);
            } else {
              VideoDetailsModel model = VideoDetailsModel(
                isliked: true,
                videoID: videoID,
                title: title,
                author: channelname,
                description: "",
                channelId: "",
                duration: duration,
              );
              Sharedprefs.savevideo(model).then((val) {
                if (val) {
                  log(val.toString());
                  Snackbarservice.showSnackBar(context, "Added to Watch Later");
                } else {
                  Snackbarservice.showSnackBar(
                      context, "Failed to add to Watch Later");
                }
              });
              isliked = true;
            }
          },
          child: CircleAvatar(
            backgroundColor: Colors.white30,
            radius: width * .07,
            child: Center(
              child: Icon(
                isliked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: Colors.red,
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
              child: Icon(Icons.loop),
            ),
          ),
        ),
      ],
    );
  }
}
