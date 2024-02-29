import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_manager/models/user.dart';
import 'package:subscription_manager/services/firestore_service.dart';

final userProvider = FutureProvider<AppUser>((ref) async {
  // Assuming FirebaseAuth.instance.currentUser is not null
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(userEmail).get();
  
  // Assuming you have a constructor in your AppUser model that accepts a Map
  return AppUser.fromFirestore(docSnapshot.data()!);
});

final firestoreServiceProvider = Provider((ref) => FirestoreService());
