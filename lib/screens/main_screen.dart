import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subscription_manager/constants/colors.dart';
import 'package:subscription_manager/screens/home_screen.dart';
import 'package:subscription_manager/screens/sub_list_screen.dart';
import 'package:subscription_manager/services/locator.dart';
import 'package:subscription_manager/services/shared_pref_service.dart';
import 'package:subscription_manager/services/user_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedTab = 0;
  void saveUserEmail() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && user.email != null) {
    await locator<SharedPreferencesService>().setString('userEmail', user.email!);
    locator<UserManager>().setUserEmail(user.email!);
  }
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveUserEmail();
  }

  void changeTab(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  final List tabPages = [
    HomeScreen(),
    SubListScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackground,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedTab,
        onTap: (index) => changeTab(index),
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions), label: "Subscriptions"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart_sharp), label: "Stats"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
      body: tabPages[selectedTab],
    );
  }
}
