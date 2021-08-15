import 'package:flutter/material.dart';
import 'package:social_media_integration_app/Signup/constants.dart';
import 'package:social_media_integration_app/Signup/widgets/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged onChanged;
  const RoundedPasswordField({
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
