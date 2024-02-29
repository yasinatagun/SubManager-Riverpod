import 'dart:developer';

class GreetingService {
  String getGreeting() {
    final hour = DateTime.now().hour;
    log("Hourr ${hour.toString()}");
    if ((hour >=21 && hour <= 0) || (hour>=0 && hour <4)) {
      return 'Good Night';
    } else if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}
