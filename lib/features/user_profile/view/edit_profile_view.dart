import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class EditProfileView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const EditProfileView(),
      );
  const EditProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  final nameController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ref.watch(currentUserDetailsProvider).value;

    return userModel == null
        ? const Loader()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: userModel.bannerPic.isEmpty
                            ? Container(color: Pallete.blueColor)
                            : Image.network(userModel.bannerPic),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            userModel.profilePic,
                          ),
                          radius: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: "Edit Name",
                    contentPadding: EdgeInsets.all(18),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: bioController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: "Edit Bio",
                    contentPadding: EdgeInsets.all(18),
                  ),
                ),
              ],
            ),
          );
  }
}
