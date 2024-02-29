// Import get_it and your service classes
import 'package:get_it/get_it.dart';
import 'package:subscription_manager/services/shared_pref_service.dart';
import 'package:subscription_manager/services/user_service.dart';
import 'subscription_service.dart'; // Assuming this is your service for date calculations

// This is the GetIt instance, the service locator.
GetIt locator = GetIt.instance;

// Setup function to register all the services or models
void setupLocator() {
  locator
      .registerLazySingleton<SubscriptionService>(() => SubscriptionService());
  locator.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService());
  locator.registerLazySingleton<UserManager>(() => UserManager());

}
