import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/models/tweet_model.dart';

final tweetAPIProvider = Provider((ref) {
  return TweetAPI(
    db: ref.watch(appwriteDatabaseProvider),
  );
});

abstract class ITweetAPI {
  FutureEither<Document> shareTweet(Tweet tweet);
  Future<List<Document>> getTweets();
}

class TweetAPI implements ITweetAPI {
  final Databases _db;
  TweetAPI({required Databases db}) : _db = db;

  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try {
      final doc = await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.tweetsCollection,
        documentId: ID.unique(),
        data: tweet.toMap(),
      );

      return right(doc);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Unexpected Error Occured!',
          st,
        ),
      );
    } catch (e, st) {
      return left(
        Failure(
          e.toString(),
          st,
        ),
      );
    }
  }

  @override
  Future<List<Document>> getTweets() async {
    final docs = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollection,
    );

    return docs.documents;
  }
}
