import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:social_media_integration_app/Signup/constants.dart';
import 'package:social_media_integration_app/Signup/signup_screen.dart';
import 'package:social_media_integration_app/screens/home_screen.dart';

class FacebookScreen extends StatelessWidget {
  const FacebookScreen({
    required this.isUserSignedIn,
    required this.userObj,
  });

  final bool isUserSignedIn;
  final Map userObj;

  static String id = 'fb_screen';

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
                      backgroundImage:
                          NetworkImage(userObj["picture"]["data"]["url"]),
                      radius: 50,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  userObj["name"],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  userObj["email"],
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
        onPressed: () {
          FacebookAuth.instance.logOut().then((value) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          });
        },
      ),
    );
  }
}
