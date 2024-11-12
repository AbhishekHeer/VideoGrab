import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_video_downloader/Ui/playvideo.dart';
import 'package:youtube_video_downloader/service/apiservice.dart';
import 'package:youtube_video_downloader/service/downloadservice.dart';
import 'package:youtube_video_downloader/service/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

TextEditingController serchController = TextEditingController();
bool isseaching = false;
bool showseach = true;
TextEditingController linkcontroller = TextEditingController();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Youtube Video Downloader',
            style: GoogleFonts.poppins(fontSize: 15),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.settings)),
            const SizedBox(width: 10, height: 0.0)
          ],
        ),
        body: showseach
            ? Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03, vertical: height * 0.02),
                    child: Center(
                      child: SearchBar(
                        onSubmitted: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              isseaching = false;
                            });
                          } else {
                            setState(() {
                              isseaching = true;
                            });
                          }
                        },
                        controller: serchController,
                        hintText: "Search",
                        hintStyle: WidgetStatePropertyAll(
                            GoogleFonts.poppins(fontSize: 15)),
                        leading: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * .03,
                          ),
                          child: const Icon(CupertinoIcons.search),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: FutureBuilder(
                          future: isseaching
                              ? Apiservice.seachvideo(
                                  serchController.text.toString())
                              : Apiservice.getVideo(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data?.items.length,
                                  itemBuilder: (context, index) {
                                    final data = snapshot.data?.items[index];
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * .03,
                                          vertical: height * .02),
                                      child: Container(
                                          height: height * .4,
                                          width: width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white38,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                height: height * .25,
                                                width: width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(data
                                                              ?.snippet
                                                              .thumbnails
                                                              .high
                                                              .url ??
                                                          ''),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * .02,
                                                    vertical: height * .01),
                                                child: Text(
                                                  data!.snippet.title.length >
                                                          60
                                                      ? '${data.snippet.title.substring(0, 60)}...'
                                                      : data.snippet.title,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * .035),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: width * .03),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Container(
                                                        width: width * .4,
                                                        height: height * .05,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        .01),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      height *
                                                                          .01),
                                                          color: Colors
                                                              .tealAccent[100],
                                                        ),
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            data.snippet
                                                                .channelTitle,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Playvideo(
                                                                      title: data
                                                                          .snippet
                                                                          .title,
                                                                      videoID: data
                                                                          .id
                                                                          .videoId,
                                                                      channelname: data
                                                                          .snippet
                                                                          .channelTitle)));
                                                        },
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .play_circle_fill,
                                                          color:
                                                              Colors.redAccent,
                                                          size: height * .05,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[],
                                              )
                                            ],
                                          )),
                                    );
                                  });
                            }
                            return Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showseach = false;
                                  });
                                },
                                child: const Text(
                                    'Click for Link to Youtube video'),
                              ),
                            );
                          }))
                ],
              )
            : SingleChildScrollView(
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
                            Downloadservice.getvideoID(
                                    linkcontroller.text, context)
                                .then((videoID) async {
                              if (videoID != null) {
                                Downloadservice.getvideodetails(videoID)
                                    .then((videodetails) async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Playvideo(
                                              title: videodetails.title,
                                              videoID: videoID,
                                              channelname:
                                                  videodetails.author)));
                                });
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Invalid URL"),
                                ));
                              }
                            });
                          },
                          controller: linkcontroller,
                          hintText: "Paste Link Here",
                          hintStyle: WidgetStatePropertyAll(
                              GoogleFonts.poppins(fontSize: 15)),
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
              ));
  }

  @override
  void initState() {
    super.initState();
    PermissionHandler().permission(context);
  }
}
