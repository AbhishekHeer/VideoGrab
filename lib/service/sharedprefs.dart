import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_video_downloader/models/videodetialmodel.dart';

class Sharedprefs {
  static const _key = "videodata";

  static Future<bool> savevideo(VideoDetailsModel videomodel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> videodetails = preferences.getStringList(_key) ?? [];
    videodetails.add(json.encode(videomodel));
    log(videodetails.toString());
    final result = await preferences.setStringList(_key, videodetails);
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<VideoDetailsModel>> getvideo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> videodetails = preferences.getStringList(_key) ?? [];
    log(videodetails.toString());
    return videodetails
        .map((e) => VideoDetailsModel.fromJson(json.decode(e)))
        .toList();
  }

  static Future<void> removevideo(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> videodetails = preferences.getStringList(_key) ?? [];
    videodetails.removeAt(index);
    await preferences.setStringList(_key, videodetails);
  }

  static Future<bool> checkvideoexists(String videoid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> videodetails = preferences.getStringList(_key) ?? [];
    final videodata = jsonEncode(videodetails);
    log(videodata.toString());
    if (videodata.contains(videoid)) {
      return true;
    } else {
      return false;
    }
  }
}
