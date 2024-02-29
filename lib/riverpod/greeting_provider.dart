
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_manager/services/greeting_service.dart';

final greetingProvider = Provider<String>((ref) {
  final greetingService = GreetingService();
  return greetingService.getGreeting();
});
