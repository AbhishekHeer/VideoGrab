import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_video_downloader/models/videodetialmodel.dart';
import 'package:youtube_video_downloader/service/sharedprefs.dart';
import 'package:youtube_video_downloader/service/snackbarservice.dart';

class Likeshareicon extends StatefulWidget {
  bool isliked;
  int length;
  String videoID;
  String title;
  String channelname;
  Duration duration;
  Likeshareicon(
      {super.key,
      required this.isliked,
      required this.length,
      required this.videoID,
      required this.title,
      required this.channelname,
      required this.duration});

  @override
  State<Likeshareicon> createState() => _LikeshareiconState();
}

class _LikeshareiconState extends State<Likeshareicon> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            setState(() {
              if (widget.isliked) {
                widget.isliked = false;
                Sharedprefs.removevideo(widget.length);
              } else {
                VideoDetailsModel model = VideoDetailsModel(
                  isliked: true,
                  videoID: widget.videoID,
                  title: widget.title,
                  author: widget.channelname,
                  description: "",
                  channelId: "",
                  duration: widget.duration,
                );
                Sharedprefs.savevideo(model).then((val) {
                  if (val) {
                    log(val.toString());
                    Snackbarservice.showSnackBar(context,
                        message: "Added to Watch Later");
                  } else {
                    Snackbarservice.showSnackBar(context,
                        message: "Failed to add to Watch Later");
                  }
                });
                widget.isliked = true;
              }
            });
          },
          child: CircleAvatar(
            backgroundColor: Colors.white30,
            radius: width * .07,
            child: Center(
              child: Icon(
                widget.isliked
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart,
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
