import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/core/utils.dart';
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

  File? bannerFile;
  File? profileFile;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bioController.dispose();
  }

  void selectBannerImage() async {
    final baner = await pickImage();

    if (baner != null) {
      setState(() {
        bannerFile = baner;
      });
    }
  }

  void selectProfileImage() async {
    final profileImage = await pickImage();

    if (profileImage != null) {
      setState(() {
        profileFile = profileImage;
      });
    }
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
                      GestureDetector(
                        onTap: selectBannerImage,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: bannerFile != null
                              ? Image.file(
                                  bannerFile!,
                                  fit: BoxFit.fitWidth,
                                )
                              : userModel.bannerPic.isEmpty
                                  ? Container(color: Pallete.blueColor)
                                  : Image.network(
                                      userModel.bannerPic,
                                      fit: BoxFit.fitWidth,
                                    ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: GestureDetector(
                          onTap: selectProfileImage,
                          child: profileFile != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(profileFile!),
                                  radius: 40,
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    userModel.profilePic,
                                  ),
                                  radius: 40,
                                ),
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
