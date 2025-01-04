import 'dart:convert';

class VideoDetailsModel {
  final String title;
  final String author;
  final String description;
  final String channelId;
  final Duration duration;
  final String videoID;
  final bool isliked;
  VideoDetailsModel({
    required this.title,
    required this.author,
    required this.description,
    required this.channelId,
    required this.videoID,
    required this.duration,
    required this.isliked,
  });

  VideoDetailsModel copyWith({
    String? title,
    String? author,
    String? description,
    String? channelId,
    String? videoID,
    Duration? duration,
    bool? isliked,
  }) =>
      VideoDetailsModel(
        videoID: videoID ?? this.videoID,
        title: title ?? this.title,
        author: author ?? this.author,
        description: description ?? this.description,
        channelId: channelId ?? this.channelId,
        duration: duration ?? this.duration,
        isliked: isliked ?? this.isliked,
      );

  factory VideoDetailsModel.fromRawJson(String str) =>
      VideoDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoDetailsModel.fromJson(Map<String, dynamic> json) =>
      VideoDetailsModel(
        videoID: json["videoID"],
        title: json["title"],
        author: json["author"],
        description: json["description"],
        channelId: json["channelId"],
        duration: json["duration"],
        isliked: json["isliked"],
      );

  Map<String, dynamic> toJson() => {
        "videoID": videoID,
        "title": title,
        "author": author,
        "description": description,
        "channelId": channelId,
        "duration": duration,
        "isliked": isliked,
      };
}
