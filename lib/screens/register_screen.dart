import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subscription_manager/constants/colors.dart';
import 'package:subscription_manager/models/user.dart';
import 'package:subscription_manager/screens/main_screen.dart';
import 'package:subscription_manager/widgets/button_widget.dart';
import 'package:subscription_manager/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  var _isEmailValid = false;
   var db = FirebaseFirestore.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validateEmail(String email) {
    _isEmailValid = EmailValidator.validate(email);
  }

  Future signUp() async {
    validateEmail(emailController.text);
    if (_isEmailValid && nameController.text.isNotEmpty) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((value) {
            var user = AppUser(
                name: nameController.text, email: emailController.text);
            saveToDatabase( user.name, user.email);
          })
          .then((value) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainScreen())))
          .then((value) => Navigator.pop(context));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 32, 3, 114),
        content: Text("Not Correct Email Adress"),
      ));
    }
  }

  Future<void> saveToDatabase(String name, String email) async {
    var userMap = {
      "name": name,
      "email": email,
    };
    db.collection("users").doc(email).set(userMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.deepPurple,
                  child: Image.asset("assets/images/logo.png",),
                ),
                SizedBox(height: 20,),
              const Text(
                "REGISTER",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: nameController,
                  hintText: "Email address",
                  inputType: TextInputType.name,
                  title: "Your name"),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: emailController,
                  hintText: "Email address",
                  inputType: TextInputType.emailAddress,
                  title: "Email"),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                hintText: "Password",
                inputType: TextInputType.visiblePassword,
                title: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ButtonWidget(
                onPressed: () {
                  signUp();
                },
                buttonText: "Register",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
