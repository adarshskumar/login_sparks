import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_integration_app/Signup/constants.dart';
import 'package:social_media_integration_app/Signup/signup_screen.dart';
import 'package:social_media_integration_app/screens/home_screen.dart';
import 'package:social_media_integration_app/login_services/google_login_services.dart';

class GoogleScreen extends StatefulWidget {
  static String id = 'google_screen';

  @override
  _GoogleScreenState createState() => _GoogleScreenState();
}

class _GoogleScreenState extends State<GoogleScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          elevation: 5.0,
          child: Container(
            height: MediaQuery.of(context).size.width * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to Sparks Foundation",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Positioned(
                  top: 100,
                  left: 130,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user!.photoURL!),
                      radius: 50,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  user!.displayName!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  user!.email!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        backgroundColor: kPrimaryColor,
        onPressed: () async {
          GoogleFirebaseService service = new GoogleFirebaseService();
          await service.signOutFromGoogle();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          );
        },
      ),
    );
  }
}
