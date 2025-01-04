import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_video_downloader/Ui/player/playvideo.dart';
import 'package:youtube_video_downloader/service/sharedprefs.dart';

class Listviewpage extends StatefulWidget {
  const Listviewpage({super.key});

  @override
  State<Listviewpage> createState() => _ListviewpageState();
}

class _ListviewpageState extends State<Listviewpage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Sharedprefs.getvideo(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final items = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      title: AutoSizeText(items.title),
                      subtitle: Text(items.author),
                      trailing: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: IconButton(
                          icon: const Icon(CupertinoIcons.play),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Playvideo(
                                        isliked: items.isliked,
                                        duration: items.duration,
                                        title: items.title,
                                        videoID: items.videoID,
                                        channelname: items.author)));
                          },
                        ),
                      ),
                    ),
                  );
                });
          }

          return const Center(
            child: Text("No Next Video"),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      Sharedprefs.getvideo();
    });
  }
}
