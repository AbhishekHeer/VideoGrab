import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_video_downloader/Ui/player/playvideo.dart';
import 'package:youtube_video_downloader/service/downloadservice.dart';

class HomeBodyOffline extends StatefulWidget {
  const HomeBodyOffline({super.key});

  @override
  State<HomeBodyOffline> createState() => _HomeBodyOfflineState();
}

class _HomeBodyOfflineState extends State<HomeBodyOffline> {
  @override
  Widget build(BuildContext context) {
    TextEditingController linkcontroller = TextEditingController();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: width,
            height: height * .2,
            child: Center(
              child: Text(
                "Paste Link Here :",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.02,
            ),
            child: Center(
              child: SearchBar(
                onSubmitted: (value) async {
                  Downloadservice.getvideoID(linkcontroller.text, context)
                      .then((videoID) async {
                    if (videoID != null) {
                      Downloadservice.getvideodetails(videoID)
                          .then((videodetails) async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Playvideo(
                                    duration: videodetails.duration,
                                    isliked: true,
                                    title: videodetails.title,
                                    videoID: videoID,
                                    channelname: videodetails.author)));
                      });
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Invalid URL"),
                      ));
                    }
                  });
                },
                controller: linkcontroller,
                hintText: "Paste Link Here",
                hintStyle:
                    WidgetStatePropertyAll(GoogleFonts.poppins(fontSize: 15)),
                leading: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * .03,
                  ),
                  child: const Icon(CupertinoIcons.search),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
