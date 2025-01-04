import 'package:dio/dio.dart';
import 'package:youtube_video_downloader/models/youtubedatamodel.dart';
import 'package:youtube_video_downloader/strings.dart';

class Apiservice {
  static const String BASE_URL = "https://www.googleapis.com/youtube/v3/";

  static const String SEARCH = "search";
  static Dio dio = Dio();

  static Future<Youtubedatamodel?> getVideo({required String query}) async {
    var url =
        "$BASE_URL$SEARCH?part=snippet&maxResults=10&type=video&key=$api_key1&language=en&regionCode=IN&q=$query";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      return Youtubedatamodel.fromJson(response.data);
    }
    return null;
  }

  static Future<Youtubedatamodel?> seachvideo(String q) async {
    var url =
        "$BASE_URL$SEARCH?part=snippet&maxResults=10&type=video&key=$api_key&language=en&regionCode=IN&q=$q";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      return Youtubedatamodel.fromJson(response.data);
    }
    return null;
  }
}
