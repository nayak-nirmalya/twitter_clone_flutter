import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';
import 'package:twitter_clone/features/user_profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/features/user_profile/view/edit_profile_view.dart';
import 'package:twitter_clone/features/user_profile/widget/follow_count.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/theme/pallete.dart';

class UserProfile extends ConsumerWidget {
  final UserModel userModel;

  const UserProfile({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return currentUser == null
        ? const Loader()
        : NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 150,
                  floating: true,
                  snap: true,
                  flexibleSpace: Stack(
                    children: [
                      Positioned.fill(
                        child: userModel.bannerPic.isEmpty
                            ? Container(color: Pallete.blueColor)
                            : Image.network(
                                AppwriteConstants.imageUrl(userModel.bannerPic),
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            AppwriteConstants.imageUrl(userModel.profilePic),
                          ),
                          radius: 45,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        margin: const EdgeInsets.all(20),
                        child: OutlinedButton(
                          onPressed: () {
                            if (currentUser.uid == userModel.uid) {
                              Navigator.push(context, EditProfileView.route());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            side: const BorderSide(
                              color: Pallete.whiteColor,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            currentUser.uid == userModel.uid
                                ? "Edit Profile"
                                : 'Follow',
                            style: const TextStyle(
                              color: Pallete.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          userModel.name,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '@${userModel.name}',
                          style: const TextStyle(
                            fontSize: 17,
                            color: Pallete.greyColor,
                          ),
                        ),
                        Text(
                          userModel.bio,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            FollowCount(
                              count: userModel.following.length,
                              text: "Following",
                            ),
                            const SizedBox(width: 15),
                            FollowCount(
                              count: userModel.followers.length,
                              text: "Followers",
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Divider(color: Pallete.greyColor),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: ref.watch(getUserTweetsProvider(userModel.uid)).when(
                  data: (tweets) {
                    return ref.watch(getLatestTweetProvider).when(
                          data: (data) {
                            final latestTweet = Tweet.fromMap(data.payload);

                            bool isTweetAlreadyPresent = false;
                            for (final tweetModel in tweets) {
                              if (tweetModel.id == latestTweet.id) {
                                isTweetAlreadyPresent = true;
                                break;
                              }
                            }

                            if (!isTweetAlreadyPresent) {
                              if (data.events.contains(
                                'databases.*.collections.${AppwriteConstants.tweetsCollection}.documents.*.create',
                              )) {
                                tweets.insert(0, Tweet.fromMap(data.payload));
                              } else if (data.events.contains(
                                'databases.*.collections.${AppwriteConstants.tweetsCollection}.documents.*.update',
                              )) {
                                final startingIndex =
                                    data.events[0].lastIndexOf('documents.');
                                final endIndex =
                                    data.events[0].lastIndexOf('.update');

                                final tweetId = data.events[0]
                                    .substring(startingIndex + 10, endIndex);

                                var tweet = tweets
                                    .where((element) => element.id == tweetId)
                                    .first;

                                final tweetIndex = tweets.indexOf(tweet);
                                tweets.removeWhere(
                                    (element) => element.id == tweetId);

                                tweet = Tweet.fromMap(data.payload);
                                tweets.insert(tweetIndex, tweet);
                              }
                            }

                            return Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: tweets.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final tweet = tweets[index];
                                      return TweetCard(tweet: tweet);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          error: (error, stackTrace) => ErrorText(
                            error: error.toString(),
                          ),
                          loading: () {
                            return Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: tweets.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final tweet = tweets[index];
                                      return TweetCard(tweet: tweet);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                  },
                  error: (error, st) => ErrorText(
                    error: error.toString(),
                  ),
                  loading: () => const Loader(),
                ),
          );
  }
}
