import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_video_downloader/Ui/player/playvideo.dart';
import 'package:youtube_video_downloader/service/navigateservice.dart';

class Widgets {
  static Padding row(double width, double height, data, BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: width * .03, vertical: height * .02),
      child: Container(
          height: height * .4,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white38,
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: height * .25,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  image: DecorationImage(
                      image:
                          NetworkImage(data?.snippet.thumbnails.high.url ?? ''),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: height * .09,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * .02, vertical: height * .01),
                  child: AutoSizeText(
                    data!.snippet.title.length > 60
                        ? '${data.snippet.title.substring(0, 60)}...'
                        : data.snippet.title,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: width * .035),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * .03),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: width * .4,
                          height: height * .05,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * .01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(height * .01),
                            color: Colors.tealAccent[100],
                          ),
                          child: Center(
                            child: AutoSizeText(
                              data.snippet.channelTitle,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            Navigateservice.navigateTo(
                                context,
                                Playvideo(
                                    title: data.snippet.title,
                                    videoID: data.id.videoId,
                                    isliked: false,
                                    channelname: data.snippet.channelTitle,
                                    duration: Durations.medium1));
                          },
                          child: Icon(
                            CupertinoIcons.play_circle_fill,
                            color: Colors.redAccent,
                            size: height * .05,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
