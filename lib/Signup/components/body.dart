import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_integration_app/Signup/components/background.dart';
import 'package:social_media_integration_app/Signup/components/or_divider.dart';
import 'package:social_media_integration_app/Signup/components/social_icon.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "images/signup.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: 25,
            ),
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              elevation: 5.0,
              child: TextButton.icon(
                onPressed: () {
                  // onGoogleSignIn(context);
                },
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
                label: Text(
                  'Google Signin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                  iconSrc: "images/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "images/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "images/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
