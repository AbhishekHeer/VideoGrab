import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_video_downloader/Ui/widgets/widgets.dart';
import 'package:youtube_video_downloader/service/apiservice.dart';

class HomeBodyApi extends StatefulWidget {
  const HomeBodyApi({
    super.key,
  });

  @override
  State<HomeBodyApi> createState() => _HomeBodyApiState();
}

class _HomeBodyApiState extends State<HomeBodyApi> {
  TextEditingController serchController = TextEditingController();
  bool isseaching = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
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
        Expanded(
            child: FutureBuilder(
                future: isseaching
                    ? Apiservice.seachvideo(serchController.text.toString())
                    : Apiservice.getVideo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.items.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data?.items[index];

                          return Widgets.row(width, height, data, context);
                        });
                  }

                  return Container();
                }))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Apiservice.getVideo();
  }
}
