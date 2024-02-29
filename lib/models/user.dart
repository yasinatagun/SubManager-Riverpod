class AppUser {
  AppUser({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  factory AppUser.fromFirestore(Map<String, dynamic> firestoreData) {
    return AppUser(
      name: firestoreData['name'],
      email: firestoreData['email'],
      // Initialize other fields if necessary
    );
  }
}
