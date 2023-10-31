import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/provider.dart';
import 'package:movie_app/screens/login_screen.dart';
import 'package:movie_app/widgets/common_nav.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateProvider).when(
          data: (data) {
            Future.delayed(Duration.zero).then(
                (value) => ref.read(userDataProvider.notifier).state = data);
            return data == null ? const LoginPage() : const CommonNav();
          },
          error: (error, stackTrace) {
            return Center(child: Text(error.toString()));
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
