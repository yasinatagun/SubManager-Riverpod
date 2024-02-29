import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_manager/riverpod/greeting_provider.dart';

// Assuming GreetingService and greetingProvider are defined elsewhere in your project
class GreetingWidget extends ConsumerWidget {
  const GreetingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the greetingProvider to get the current greeting
    final greeting = ref.watch(greetingProvider);

    return Text(
      greeting,
      style: TextStyle(
        fontSize: 18.0,
        color: Color.fromARGB(255, 156, 140, 140),
      ),
    );
  }
}
