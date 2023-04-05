import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';

import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';

class TweetController extends StateNotifier<bool> {
  final Ref _ref;
  TweetController({required Ref ref})
      : _ref = ref,
        super(false);

  void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, "Please, Enter Something!");
    }

    if (images.isNotEmpty) {
      _shareImageTweet(
        images: images,
        text: text,
        context: context,
      );
    } else {
      _shareTextTweet(
        text: text,
        context: context,
      );
    }
  }

  void _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {}

  void _shareTextTweet({
    required String text,
    required BuildContext context,
  }) {
    state = true;
    final hashTags = _getHashTagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;

    Tweet tweet = Tweet(
      id: '',
      text: text,
      hashTags: hashTags,
      link: link,
      imageLinks: [],
      uid: user.uid,
      tweetType: TweetType.text,
      tweetedAt: DateTime.now(),
      likes: [],
      commentIds: [],
      reShareCount: 0,
    );
  }

  String _getLinkFromText(String text) {
    List<String> wordsInSentence = text.split(' ');
    String link = '';

    for (String word in wordsInSentence) {
      if (word.startsWith('https://') || word.startsWith('www')) {
        link = word;
      }
    }

    return link;
  }

  List<String> _getHashTagsFromText(String text) {
    List<String> wordsInSentence = text.split(' ');
    List<String> hashTags = [];

    for (String word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashTags.add(word);
      }
    }

    return hashTags;
  }
}
