import 'package:cubit/features/auth/ForgotPassword/forgot_password.dart';
import 'package:cubit/features/auth/login/cubit/login_cubit.dart';
import 'package:cubit/features/auth/login/cubit/login_state.dart';

import 'package:cubit/features/auth/signup/view/sign_up.dart';
import 'package:cubit/widgets/custom_button.dart';
import 'package:cubit/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    final formkey = GlobalKey<FormState>();
bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
         Color kPrimary = Color(0xFF20B86B);


    String? checkValidator(String? value, String type) {
      final emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$');

      if (type == 'Email') {
        if (value == null || value.isEmpty) {
          return 'Email cannot be empty';
        } else if (!emailRegex.hasMatch(value)) {
          return 'Enter a valid email';

        }
        return null;
      } else if (type == 'Password') {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty';
        } else if (value.length < 8) {
          return 'The password must be alteast 8 charecters';
        }
      } else if (type == 'Repassword') {
        if (value == null || value.isEmpty) {
          return 'Repassword cannot be empty';
        } else if (value != passwordcontroller.text) {
          return 'Password does not match';
        }
      }
      return null;
    }

    return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: formkey,
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.loginstatus == LoginStatus.errormessage) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      content: Text(state.errorMessage ?? 'Sign in failed'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state.loginstatus == LoginStatus.loading;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: kPrimary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child:  Icon(Icons.lock_outline_rounded,
                          color:kPrimary , size: 28),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Welcome back 👋',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Sign in to continue',
                      style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 32),

                    CustomTextfield(
                      textEditingController: emailcontroller,
                      hintText: 'Email address',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.mail_outline_rounded),
                      validator: (value) => checkValidator(value, 'Email'),
                    ),
                    const SizedBox(height: 16),

                    CustomTextfield(
                      textEditingController: passwordcontroller,
                      hintText: 'Password',
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
setState(() {
  _obscurePassword = !_obscurePassword;

});
                        }
                      ),
                      validator: (value) => checkValidator(value, 'Password'),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                        },
                        style: TextButton.styleFrom(foregroundColor: kPrimary),
                        child: const Text('Forgot password?',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 8),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (formkey.currentState!.validate()) {
                                  context.read<LoginCubit>().login(
                                        emailcontroller.text,
                                        passwordcontroller.text,
                                      );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimary,
                          disabledBackgroundColor: kPrimary.withOpacity(0.6),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text('OR',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),
                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton(
                        onPressed: () {
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/google-plus-png-logo-3704.png', height: 24, width: 24),
                            const SizedBox(width: 12),
                            const Text(
                              'Continue with Google',
                              style: TextStyle(
                                color: Color(0xFF1A1A1A),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style: TextStyle(color: Colors.grey.shade600)),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: kPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: const Text('Sign Up',
                              style: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
  }

  Widget textWidget(String text, TextEditingController texteditingcontrolller) {
    return Text(text, style: TextStyle(color: Colors.grey, fontSize: 11));
  }
}
