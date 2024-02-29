import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_manager/constants/colors.dart'; // Adjust the import based on your project structure
import 'package:subscription_manager/riverpod/user_provider.dart'; // Adjust the import based on your project structure
import 'package:subscription_manager/models/user.dart'; // Adjust the import based on your project structure

class UserNameDisplay extends ConsumerWidget {
  const UserNameDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userProvider).when(
      data: (AppUser user) => Text(
        user.name, // Assuming 'name' is a field in your User model
        style: const TextStyle(
          letterSpacing: 1,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: blackMain, // Make sure blackMain is defined or import it from your constants
        ),
      ),
      loading: () => const Text(
        "Loading...",
        style: TextStyle(
          letterSpacing: 1,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: blackMain, // Make sure blackMain is defined or import it from your constants
        ),
      ),
      error: (e, _) => const Text(
        "Error loading name",
        style: TextStyle(
          letterSpacing: 1,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: blackMain, // Make sure blackMain is defined or import it from your constants
        ),
      ),
    );
  }
}
