import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/user_profile/widget/user_profile.dart';
import 'package:twitter_clone/models/user_model.dart';

class UserProfileView extends ConsumerWidget {
  static route(userModel) => MaterialPageRoute(
        builder: (context) => UserProfileView(
          userModel: userModel,
        ),
      );

  final UserModel userModel;

  const UserProfileView({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    return Scaffold(
      body: UserProfile(userModel: userModel),
    );
  }
}
