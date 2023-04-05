class AppwriteConstants {
  static const String localhost = "192.168.174.224";

  static const String databaseId = "64297f926fe94e928c3a";
  static const String projectId = "642911e0eebb79e25ce2";
  static const String endPoint = "http://$localhost:80/v1";
  // static const String endPoint = "http://localhost:80/v1";

  static const String usersCollection = "642bcd918108cf817bf8";
  static const String tweetsCollection = "642d0d2216217ea6b753";

  static const String imagesBucket = "642d18a59355a7af11d5";

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
