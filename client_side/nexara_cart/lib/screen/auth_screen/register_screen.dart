import 'package:flutter/material.dart';
import 'package:nexara_cart/screen/auth_screen/login_screen.dart';
import 'package:nexara_cart/utility/extensions.dart';

import '../../utility/functions.dart';
import '../../utility/snack_bar_helper.dart';
import 'components/login_button.dart';
import 'components/login_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  signUserUp() async {
    showLoadingDialog(context);

    await context.userProvider.register().then((result) {
      Navigator.pop(context);

      if (result == null) {
        context.userProvider.emailController.clear();
        context.userProvider.passwordController.clear();
        context.userProvider.passwordController2.clear();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        SnackBarHelper.showErrorSnackBar(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              const Icon(
                Icons.ac_unit_rounded,
                size: 100,
                color: Colors.black87,
              ),

              const SizedBox(height: 25),

              // welcome back, you've been missed!
              Text(
                'Let\'s join nexara family!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 50),

              // username textfield
              LoginTextField(
                controller: context.userProvider.emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              LoginTextField(
                controller: context.userProvider.passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // confirm password textfield
              LoginTextField(
                controller: context.userProvider.passwordController2,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              // sign in button
              LoginButton(
                onTap: signUserUp,
                buttonText: 'Sign Up',
              ),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
