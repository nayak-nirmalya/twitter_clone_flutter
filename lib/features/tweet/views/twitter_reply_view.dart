import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';
import 'package:twitter_clone/models/tweet_model.dart';

class TwitterReplyScreen extends ConsumerWidget {
  final Tweet tweet;
  const TwitterReplyScreen({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tweet"),
      ),
      body: Column(
        children: [
          TweetCard(tweet: tweet),
        ],
      ),
    );
  }
}
