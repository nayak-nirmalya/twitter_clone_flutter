import 'dart:io';

import 'package:flutter/material.dart';

import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/apis/storage_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/models/tweet_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileControllerProvider =
    StateNotifierProvider<UserProfileController, bool>((ref) {
  return UserProfileController(
    userAPI: ref.watch(userAPIProvider),
    tweetAPI: ref.watch(tweetAPIProvider),
    storageAPI: ref.watch(storageAPIProvider),
  );
});

final getUserTweetsProvider = FutureProvider.family((ref, String uid) async {
  final userProfileController =
      ref.watch(userProfileControllerProvider.notifier);

  return userProfileController.getUserTweets(uid);
});

class UserProfileController extends StateNotifier<bool> {
  final UserAPI _userAPI;
  final TweetAPI _tweetAPI;
  final StorageAPI _storageAPI;

  UserProfileController({
    required UserAPI userAPI,
    required TweetAPI tweetAPI,
    required StorageAPI storageAPI,
  })  : _userAPI = userAPI,
        _tweetAPI = tweetAPI,
        _storageAPI = storageAPI,
        super(false);

  Future<List<Tweet>> getUserTweets(String uid) async {
    final tweets = await _tweetAPI.getUserTweets(uid);
    return tweets.map((e) => Tweet.fromMap(e.data)).toList();
  }

  void updateUserData({
    required UserModel userModel,
    required BuildContext context,
    required File? bannerFile,
    required File? profileFile,
  }) async {
    state = true;

    if (bannerFile != null) {
      final bannerUrl = await _storageAPI.uploadImages([bannerFile]);
      userModel = userModel.copyWith(
        bannerPic: bannerUrl[0],
      );
    }

    if (profileFile != null) {
      final profileUrl = await _storageAPI.uploadImages([profileFile]);
      userModel = userModel.copyWith(
        profilePic: profileUrl[0],
      );
    }

    final res = await _userAPI.updateUserData(userModel);
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => Navigator.pop(context),
    );
  }
}
