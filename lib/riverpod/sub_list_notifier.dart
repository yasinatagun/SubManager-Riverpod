import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_manager/models/subscription.dart';
import 'package:subscription_manager/services/locator.dart';
import 'package:subscription_manager/services/user_service.dart';

class SubscriptionListNotifier extends StateNotifier<List<Subscription>> {
  SubscriptionListNotifier() : super([]);

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Asynchronous initialization method
  Future<void> initAndFetchSubscriptions() async {
    await _ensureEmailAvailable(); 
    await fetchSubscriptions(); 
  }

  Future<void> _ensureEmailAvailable() async {
    while (locator<UserManager>().getUserEmail().isEmpty) {
      await Future.delayed(const Duration(milliseconds: 100)); 
    }
  }

  Future<void> fetchSubscriptions() async {
    String userEmail = locator<UserManager>().getUserEmail();
    log(userEmail);
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userEmail)
          .collection('subscriptions') 
          .get();
      final subscriptions = snapshot.docs
          .map((doc) => Subscription.fromMap(doc.data()))
          .toList();
      state = subscriptions;
      log(subscriptions.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addSubscription(String email, Subscription subscription) async {
    state = [...state, subscription];

    try {
      await _db
          .collection('users')
          .doc(email)
          .collection('subscriptions')
          .add(subscription.toMap());
          log(subscription.toString());
    } catch (e) {
      log("Error adding subscription: $e");
    }
  }

  void removeSubscription(Subscription subscription) {
    state = state.where((item) => item.id != subscription.id).toList();
  }

}

final subscriptionListProvider = StateNotifierProvider<SubscriptionListNotifier, List<Subscription>>((ref) {
  var notifier = SubscriptionListNotifier();
  notifier.initAndFetchSubscriptions(); 
  return notifier;
});