import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/theme/theme.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';

class SignUpView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
                        text: "Already Have An Account?",
                        style: const TextStyle(fontSize: 16),
                        children: [
                      TextSpan(
                          text: ' Log In.',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, LoginView.route());
                            },
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
