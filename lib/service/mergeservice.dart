import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/session_state.dart';

class Mergeservice {
  static Future<bool> merge(
      String videourl, String audiourl, String outputPath) async {
    String command =
        "-i $videourl -i $audiourl -c:v copy -c:a aac -strict experimental -shortest $outputPath";
    final result = await FFmpegKit.execute(command).then((session) async {
      final code = await session.getState();
      if (code == SessionState.completed) {
        return true;
      } else {
        return false;
      }
    });

    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
