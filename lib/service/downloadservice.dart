import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_video_downloader/models/videodetialmodel.dart';
import 'package:youtube_video_downloader/service/mergeservice.dart';

class Downloadservice {
  static Future<String> getaudio(String videoID) async {
    var yt = YoutubeExplode();
    try {
      var mainfest = await yt.videos.streamsClient.getManifest(videoID);

      var audio = mainfest.audioOnly.withHighestBitrate();
      return audio.url.toString();
    } catch (e) {
      throw Exception("Error");
    } finally {
      yt.close();
    }
  }

  static Future<String?> getvideoID(String url, BuildContext context) async {
    if (url.contains("https://youtu.be/")) {
      return url.split("https://youtu.be/")[1].substring(0, 11);
    } else if (url.contains("https://www.youtube.com/watch?v=")) {
      return url.split("https://www.youtube.com/watch?v=")[1].substring(0, 11);
    } else {
      return null;
    }
  }

  static Future<VideoDetailsModel> getvideodetails(String videoID) async {
    var yt = YoutubeExplode();
    try {
      var v = await yt.videos.get(videoID);
      v.duration;
      var video = await yt.videos.get(videoID);
      return VideoDetailsModel(
          videoID: videoID,
          author: video.author,
          title: video.title,
          description: video.description,
          channelId: video.channelId.value,
          duration: video.duration!,
          isliked: true);
    } catch (e) {
      throw Exception("Error");
    }
  }

  static Future<bool> downloadvideo(String videoID, String outputPath) async {
    var yt = YoutubeExplode();
    try {
      var video = await yt.videos.get(videoID);
      var manifest = await yt.videos.streamsClient.getManifest(video.id);
      var audiourl = manifest.audioOnly.withHighestBitrate().url.toString();
      var videourl = manifest.videoOnly.withHighestBitrate().url.toString();
      return Mergeservice.merge(videourl, audiourl, outputPath);
    } catch (e) {
      throw Exception("Error");
    }
  }
}
