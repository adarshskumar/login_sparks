import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_integration_app/Signup/components/background.dart';
import 'package:social_media_integration_app/Signup/components/or_divider.dart';
import 'package:social_media_integration_app/Signup/components/social_icon.dart';
import 'package:social_media_integration_app/Signup/constants.dart';
import 'package:social_media_integration_app/Signup/signup_screen.dart';
import 'package:social_media_integration_app/Signup/widgets/rounded_button.dart';
import 'package:social_media_integration_app/screens/facebook_home_screen.dart';
import 'package:social_media_integration_app/screens/google_home_screen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  late FirebaseAuth _auth;
  bool isUserSignedIn = false;
  Map userObj = {};

  @override
  void initState() {
    super.initState();

    initApp();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });
  }

  Future<User?> _handleSignIn() async {
    User user;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  void onGoogleSignIn(BuildContext context) async {
    User? user = await _handleSignIn();
    var userSignedIn = Navigator.push(
        context, MaterialPageRoute(builder: (context) => GoogleScreen()));

    setState(() {
      isUserSignedIn = userSignedIn == null ? true : false;
    });
  }

  void onFacebookSignIn(BuildContext context) async {
    FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) {
        setState(() {
          isUserSignedIn = true;
          userObj = userData;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FacebookScreen(
                      isUserSignedIn: isUserSignedIn,
                      userObj: userObj,
                    )));
      });
    });
  }

  @override
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
              height: 55,
            ),
            Material(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              elevation: 5.0,
              child: TextButton.icon(
                onPressed: () {
                  onGoogleSignIn(context);
                },
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
                label: Text(
                  'SignIn with GOOGLE\ \ \ \ \ ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              elevation: 5.0,
              child: TextButton.icon(
                onPressed: () {
                  onFacebookSignIn(context);
                },
                icon: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                ),
                label: Text(
                  'SignIn with FACEBOOK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
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
