import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_video_downloader/Ui/home/views/home_body_api.dart';
import 'package:youtube_video_downloader/Ui/home/views/home_body_offline.dart';
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

List<Widget> body = [
  const HomeBodyApi(),
  const HomeBodyOffline(),
];
int index = 0;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VideoGrab',
          style: GoogleFonts.poppins(fontSize: 15),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(CupertinoIcons.settings)),
          const SizedBox(width: 10, height: 0.0)
        ],
      ),
      body: body.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (value) => setState(() {
          index = value;
        }),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.link), label: 'Link Paste'),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    PermissionHandler().permission(context);
  }
}
