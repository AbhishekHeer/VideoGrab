import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_video_downloader/Ui/widgets/channelview.dart';
import 'package:youtube_video_downloader/Ui/widgets/downloadstart.dart';
import 'package:youtube_video_downloader/Ui/widgets/likeshareloopicon.dart';
import 'package:youtube_video_downloader/Ui/widgets/listviewpage.dart';

// ignore: must_be_immutable
class Playvideo extends StatefulWidget {
  final String title;
  final String channelname;
  final String videoID;
  final Duration duration;
  bool isliked;
  Playvideo(
      {super.key,
      required this.title,
      required this.videoID,
      required this.isliked,
      required this.channelname,
      required this.duration});

  @override
  State<Playvideo> createState() => _PlayvideoState();
}

bool downloadstart = false;
int length = 0;

class _PlayvideoState extends State<Playvideo> {
  @override
  Widget build(BuildContext context) {
    var controller = YoutubePlayerController(initialVideoId: widget.videoID);
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
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: YoutubePlayer(
                      controller: controller,
                      onReady: () {
                        controller.addListener(() {
                          setState(() {});
                        });
                      },
                      showVideoProgressIndicator: true,
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
                child: Likeshareloopicon.icons(
                    context,
                    widget.isliked,
                    length,
                    widget.videoID,
                    widget.title,
                    widget.channelname,
                    widget.duration,
                    MediaQuery.of(context).size.height,
                    width),
              ),
              Channelview.channelview(height, width, widget.channelname),
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
                  : Downloadstart.downloadstart(
                      context, height, width, downloadstart, widget.videoID),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * .02),
                child: const Divider(),
              ),
              const Listviewpage()
            ],
          ),
        ));
  }
}
