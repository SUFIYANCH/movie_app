import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/providers/provider.dart';
import 'package:movie_app/service/storage_service.dart';
import 'package:movie_app/utils/responsive.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: R.rh(100, context),
          ),
          Center(
            child: SizedBox(
              height: R.rh(280, context),
              child: Column(
                children: [
                  ref.watch(imageUrlProvider) == null
                      ? Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(
                                  ref.watch(userDataProvider)!.photoURL!,
                                )),
                            CircleAvatar(
                                child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                          title:
                                              const Text('Choose image from'),
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CircleAvatar(
                                                  radius: 24,
                                                  backgroundColor: Colors.black,
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        try {
                                                          final fileimg =
                                                              await ImagePicker()
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .camera);

                                                          if (fileimg != null) {
                                                            ref
                                                                    .read(imageUrlProvider
                                                                        .notifier)
                                                                    .state =
                                                                await Storage
                                                                    .linkConverting(
                                                                        File(fileimg
                                                                            .path));

                                                            ref.read(authServiceProvider).updateUser(
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .displayName
                                                                    .toString(),
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .email
                                                                    .toString(),
                                                                ref.watch(
                                                                    imageUrlProvider)!,
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .uid
                                                                    .toString());
                                                          } else {
                                                            log("No Image selected");
                                                          }
                                                        } on Exception catch (e) {
                                                          log(e.toString());
                                                        }
                                                        if (context.mounted) {
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      icon: const Icon(Icons
                                                          .camera_alt_outlined)),
                                                ),
                                                CircleAvatar(
                                                  radius: 24,
                                                  backgroundColor: Colors.black,
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        try {
                                                          final fileimg =
                                                              await ImagePicker()
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .gallery);

                                                          if (fileimg != null) {
                                                            ref
                                                                    .read(imageUrlProvider
                                                                        .notifier)
                                                                    .state =
                                                                await Storage
                                                                    .linkConverting(
                                                                        File(fileimg
                                                                            .path));

                                                            ref.read(authServiceProvider).updateUser(
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .displayName
                                                                    .toString(),
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .email
                                                                    .toString(),
                                                                ref.watch(
                                                                    imageUrlProvider)!,
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .uid
                                                                    .toString());
                                                          } else {
                                                            log("No Image selected");
                                                          }
                                                        } on Exception catch (e) {
                                                          log(e.toString());
                                                        }
                                                        if (context.mounted) {
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.photo)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit)))
                          ],
                        )
                      : Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                                radius: 70,
                                backgroundImage:
                                    NetworkImage(ref.watch(imageUrlProvider)!)),
                            CircleAvatar(
                                child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                          title:
                                              const Text('Choose image from'),
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CircleAvatar(
                                                  radius: 24,
                                                  backgroundColor: Colors.black,
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        try {
                                                          final fileimg =
                                                              await ImagePicker()
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .camera);

                                                          if (fileimg != null) {
                                                            ref
                                                                    .read(imageUrlProvider
                                                                        .notifier)
                                                                    .state =
                                                                await Storage
                                                                    .linkConverting(
                                                                        File(fileimg
                                                                            .path));

                                                            ref.read(authServiceProvider).updateUser(
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .displayName
                                                                    .toString(),
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .email
                                                                    .toString(),
                                                                ref.watch(
                                                                    imageUrlProvider)!,
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .uid
                                                                    .toString());
                                                          } else {
                                                            log("No Image selected");
                                                          }
                                                        } on Exception catch (e) {
                                                          log(e.toString());
                                                        }
                                                        if (context.mounted) {
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      icon: const Icon(Icons
                                                          .camera_alt_outlined)),
                                                ),
                                                CircleAvatar(
                                                  radius: 24,
                                                  backgroundColor: Colors.black,
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        try {
                                                          final fileimg =
                                                              await ImagePicker()
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .gallery);

                                                          if (fileimg != null) {
                                                            ref
                                                                    .read(imageUrlProvider
                                                                        .notifier)
                                                                    .state =
                                                                await Storage
                                                                    .linkConverting(
                                                                        File(fileimg
                                                                            .path));

                                                            ref.read(authServiceProvider).updateUser(
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .displayName
                                                                    .toString(),
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .email
                                                                    .toString(),
                                                                ref.watch(
                                                                    imageUrlProvider)!,
                                                                ref
                                                                    .watch(
                                                                        userDataProvider)!
                                                                    .uid
                                                                    .toString());
                                                          } else {
                                                            log("No Image selected");
                                                          }
                                                        } on Exception catch (e) {
                                                          log(e.toString());
                                                        }
                                                        if (context.mounted) {
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.photo)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit)))
                          ],
                        ),
                  SizedBox(
                    height: R.rh(30, context),
                  ),
                  Text(
                    ref.watch(userDataProvider) == null
                        ? "UserName"
                        : ref.watch(userDataProvider)!.displayName.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: R.rw(24, context)),
                  ),
                  SizedBox(
                    height: R.rh(10, context),
                  ),
                  Text(
                    ref.watch(userDataProvider) == null
                        ? "user@gmail.com"
                        : ref.watch(userDataProvider)!.email.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: R.rw(20, context)),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(R.rw(100, context), R.rh(40, context))),
              onPressed: () {
                ref.read(authServiceProvider).logout();
                GoogleSignIn().signOut();
              },
              child: Text(
                'Logout',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: R.rw(18, context)),
              ))
        ],
      ),
    );
  }
}
