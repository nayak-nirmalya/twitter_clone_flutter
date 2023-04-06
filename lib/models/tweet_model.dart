import 'package:flutter/foundation.dart';

import 'package:twitter_clone/core/enums/tweet_type_enum.dart';

@immutable
class Tweet {
  final String id;
  final String text;
  final List<String> hashTags;
  final String link;
  final List<String> imageLinks;
  final String uid;
  final TweetType tweetType;
  final DateTime tweetedAt;
  final List<String> likes;
  final List<String> commentIds;
  final int reShareCount;
  final String reTweetedBy;
  const Tweet({
    required this.id,
    required this.text,
    required this.hashTags,
    required this.link,
    required this.imageLinks,
    required this.uid,
    required this.tweetType,
    required this.tweetedAt,
    required this.likes,
    required this.commentIds,
    required this.reShareCount,
    required this.reTweetedBy,
  });

  Tweet copyWith({
    String? id,
    String? text,
    List<String>? hashTags,
    String? link,
    List<String>? imageLinks,
    String? uid,
    TweetType? tweetType,
    DateTime? tweetedAt,
    List<String>? likes,
    List<String>? commentIds,
    int? reShareCount,
    String? reTweetedBy,
  }) {
    return Tweet(
      id: id ?? this.id,
      text: text ?? this.text,
      hashTags: hashTags ?? this.hashTags,
      link: link ?? this.link,
      imageLinks: imageLinks ?? this.imageLinks,
      uid: uid ?? this.uid,
      tweetType: tweetType ?? this.tweetType,
      tweetedAt: tweetedAt ?? this.tweetedAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      reShareCount: reShareCount ?? this.reShareCount,
      reTweetedBy: reTweetedBy ?? this.reTweetedBy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});
    result.addAll({'hashTags': hashTags});
    result.addAll({'link': link});
    result.addAll({'imageLinks': imageLinks});
    result.addAll({'uid': uid});
    result.addAll({'tweetType': tweetType.type});
    result.addAll({'tweetedAt': tweetedAt.millisecondsSinceEpoch});
    result.addAll({'likes': likes});
    result.addAll({'commentIds': commentIds});
    result.addAll({'reShareCount': reShareCount});
    result.addAll({'reTweetedBy': reTweetedBy});

    return result;
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      id: map['\$id'] ?? '',
      text: map['text'] ?? '',
      hashTags: List<String>.from(map['hashTags']),
      link: map['link'] ?? '',
      imageLinks: List<String>.from(map['imageLinks']),
      uid: map['uid'] ?? '',
      tweetType: (map['tweetType'] as String).toTweetTypeEnum(),
      tweetedAt: DateTime.fromMillisecondsSinceEpoch(map['tweetedAt']),
      likes: List<String>.from(map['likes']),
      commentIds: List<String>.from(map['commentIds']),
      reShareCount: map['reShareCount']?.toInt() ?? 0,
      reTweetedBy: map['reTweetedBy'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Tweet(id: $id, text: $text, hashTags: $hashTags, link: $link, imageLinks: $imageLinks, uid: $uid, tweetType: $tweetType, tweetedAt: $tweetedAt, likes: $likes, commentIds: $commentIds, reShareCount: $reShareCount, reTweetedBy: $reTweetedBy,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tweet &&
        other.id == id &&
        other.text == text &&
        listEquals(other.hashTags, hashTags) &&
        other.link == link &&
        listEquals(other.imageLinks, imageLinks) &&
        other.uid == uid &&
        other.tweetType == tweetType &&
        other.tweetedAt == tweetedAt &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentIds, commentIds) &&
        other.reShareCount == reShareCount &&
        other.reTweetedBy == reTweetedBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        hashTags.hashCode ^
        link.hashCode ^
        imageLinks.hashCode ^
        uid.hashCode ^
        tweetType.hashCode ^
        tweetedAt.hashCode ^
        likes.hashCode ^
        commentIds.hashCode ^
        reShareCount.hashCode ^
        reTweetedBy.hashCode;
  }
}
