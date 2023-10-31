import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/providers/provider.dart';
import 'package:movie_app/service/firebase_service.dart';
import 'package:movie_app/utils/responsive.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseService.auth.signInWithCredential(credential);
    } catch (e) {
      Text("signingoogle error: ${e.toString()}");
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/login.png",
              height: R.rh(406, context),
            ),
            SizedBox(
              height: R.rh(60, context),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(R.rw(200, context), R.rh(45, context)),
                  shape: const StadiumBorder(),
                  elevation: 1),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                signInWithGoogle().then((value) {
                  ref.read(authServiceProvider).addUser(
                      value!.user!.displayName.toString(),
                      value.user!.email.toString(),
                      value.user!.photoURL.toString(),
                      value.user!.uid.toString());
                  Navigator.pop(context);
                });
              },
              icon: Image.asset(
                "assets/googlelogo.png",
                height: R.rh(28, context),
              ),
              label: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontSize: R.rw(20, context), color: Colors.black),
                      children: const [
                    TextSpan(
                      text: "Login with ",
                    ),
                    TextSpan(
                        text: "Google",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        )),
                  ])),
            )
          ],
        ));
  }
}
