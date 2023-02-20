import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/services/authentication.dart';
import 'package:time_tracker_app_firebase/widgets/AuthenticationWidget.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback OnClickedSignUp;
  SignUpScreen({super.key, required this.OnClickedSignUp});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailtextController = TextEditingController();
  final _passwtextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("SignUp Screen")),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              controller: _emailtextController,
              decoration: InputDecoration(
                  labelText: "Write your Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: _passwtextController,
              decoration: InputDecoration(
                  labelText: "Write your Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                var object = Authentication(
                    email: _emailtextController.text,
                    password: _passwtextController.text);

                try {
                  var result = await object.sign_up();
                  if (result == "email-already-in-use" ||
                      result == "invalid-email") {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content:
                              Text("email-already-in-use or invalid email"),
                          title: Text("SignUp error")
                         ,actions: [
                            ElevatedButton(
                                
                                onPressed: (() {
                                  Navigator.pop(context); //AlertDialog mesajını kapatacak
                                }),
                                child: Text("Close this message"))
                          ],
                        );
                      },
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  print(e);
                }
              },
              icon: Icon(Icons.forward_sharp),
              label: Text("Sign Up"),
            )
          ],
        ),
      )),
    );
  }
}