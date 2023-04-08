import 'package:appwrite/appwrite.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/core.dart';

abstract class INotificationAPI {
  FutureEitherVoid createNotification();
}

class NotificationAPI implements INotificationAPI {
  final Databases _db;

  NotificationAPI({
    required Databases db,
  }) : _db = db;

  @override
  FutureEitherVoid createNotification() async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.notificationsCollection,
        documentId: userModel.uid,
        data: {
          'followers': userModel.followers,
        },
      );

      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(e.message ?? 'Unexpected Error Occured!', st),
      );
    } catch (e, st) {
      return left(
        Failure(e.toString(), st),
      );
    }
  }
}
