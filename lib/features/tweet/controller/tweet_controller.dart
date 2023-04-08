import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/notification_api.dart';
import 'package:twitter_clone/apis/storage_api.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';

import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/user_model.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  return TweetController(
    ref: ref,
    tweetAPI: ref.watch(tweetAPIProvider),
    storageAPI: ref.watch(storageAPIProvider),
    notificationAPI: ref.watch(),
  );
});

final getTweetsProvider = FutureProvider((ref) {
  final tweetController = ref.watch(tweetControllerProvider.notifier);
  return tweetController.getTweets();
});

final getReplieToTweetsProvider = FutureProvider.family((ref, Tweet tweet) {
  final tweetController = ref.watch(tweetControllerProvider.notifier);
  return tweetController.getRepliesToTweet(tweet);
});

final getTweetByIdProvider = FutureProvider.family((ref, String id) {
  final tweetController = ref.watch(tweetControllerProvider.notifier);
  return tweetController.getTweetById(id);
});

final getLatestTweetProvider = StreamProvider((ref) {
  final tweetAPI = ref.watch(tweetAPIProvider);
  return tweetAPI.getLatestTweet();
});

class TweetController extends StateNotifier<bool> {
  final NotificationAPI _notificationAPI;
  final StorageAPI _storageAPI;
  final TweetAPI _tweetAPI;
  final Ref _ref;

  TweetController({
    required Ref ref,
    required TweetAPI tweetAPI,
    required StorageAPI storageAPI,
    required NotificationAPI notificationAPI,
  })  : _ref = ref,
        _tweetAPI = tweetAPI,
        _storageAPI = storageAPI,
        _notificationAPI = notificationAPI,
        super(false);

  Future<List<Tweet>> getTweets() async {
    final tweetList = await _tweetAPI.getTweets();
    return tweetList.map((tweet) => Tweet.fromMap(tweet.data)).toList();
  }

  Future<Tweet> getTweetById(String id) async {
    final tweet = await _tweetAPI.getTweetById(id);
    return Tweet.fromMap(tweet.data);
  }

  void likeTweet(Tweet tweet, UserModel user) async {
    List<String> likes = tweet.likes;

    if (tweet.likes.contains(user.uid)) {
      likes.remove(user.uid);
    } else {
      likes.add(user.uid);
    }

    tweet = tweet.copyWith(likes: likes);
    final res = await _tweetAPI.likeTweet(tweet);

    res.fold((l) => null, (r) {
      _notificationAPI.createNotification();
    });
  }

  void reShareTweet(
    Tweet tweet,
    UserModel currentUser,
    BuildContext context,
  ) async {
    tweet = tweet.copyWith(
      reTweetedBy: currentUser.name,
      likes: [],
      commentIds: [],
      reShareCount: tweet.reShareCount + 1,
    );
    final res = await _tweetAPI.updateReShareCount(tweet);

    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) async {
        tweet = tweet.copyWith(
          id: ID.unique(),
          reShareCount: 0,
          tweetedAt: DateTime.now(),
        );
        final res2 = await _tweetAPI.shareTweet(tweet);

        res2.fold(
          (l) => showSnackBar(context, l.message),
          (r) => showSnackBar(context, "ReTweeted!"),
        );
      },
    );
  }

  void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
    required String repliedTo,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, "Please, Enter Something!");
    }

    if (images.isNotEmpty) {
      _shareImageTweet(
        images: images,
        text: text,
        context: context,
        repliedTo: repliedTo,
      );
    } else {
      _shareTextTweet(
        text: text,
        context: context,
        repliedTo: repliedTo,
      );
    }
  }

  Future<List<Tweet>> getRepliesToTweet(Tweet tweet) async {
    final docs = await _tweetAPI.getRepliesToTweet(tweet);
    return docs.map((tweet) => Tweet.fromMap(tweet.data)).toList();
  }

  void _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
    required String repliedTo,
  }) async {
    state = true;
    final hashTags = _getHashTagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    final imageLinks = await _storageAPI.uploadImages(images);

    Tweet tweet = Tweet(
      id: '',
      text: text,
      hashTags: hashTags,
      link: link,
      imageLinks: imageLinks,
      uid: user.uid,
      tweetType: TweetType.image,
      tweetedAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      reShareCount: 0,
      reTweetedBy: '',
      repliedTo: repliedTo,
    );

    final res = await _tweetAPI.shareTweet(tweet);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void _shareTextTweet({
    required String text,
    required BuildContext context,
    required String repliedTo,
  }) async {
    state = true;
    final hashTags = _getHashTagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;

    Tweet tweet = Tweet(
      id: '',
      text: text,
      hashTags: hashTags,
      link: link,
      imageLinks: const [],
      uid: user.uid,
      tweetType: TweetType.text,
      tweetedAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      reShareCount: 0,
      reTweetedBy: '',
      repliedTo: repliedTo,
    );

    final res = await _tweetAPI.shareTweet(tweet);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
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
