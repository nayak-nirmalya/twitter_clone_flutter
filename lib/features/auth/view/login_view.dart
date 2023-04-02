import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/common/rounded_small_button.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';
import 'package:twitter_clone/theme/theme.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // textfield1
                AuthField(controller: emailController, hintText: "E-Mail"),

                const SizedBox(
                  height: 25,
                ),

                // textfield2
                AuthField(
                  controller: passwordController,
                  hintText: "Password",
                ),

                const SizedBox(
                  height: 25,
                ),

                // button
                Align(
                  alignment: Alignment.topRight,
                  child: RoundedSmallButton(
                    onTab: () {},
                    label: "Done",
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // textspan
                RichText(
                    text: TextSpan(
                        text: "Don't Have An Account?",
                        style: const TextStyle(fontSize: 16),
                        children: [
                      TextSpan(
                          text: ' Sign Up.',
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: const TextStyle(
                              color: Pallete.blueColor, fontSize: 16))
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
