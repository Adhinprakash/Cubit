import 'package:cubit/features/auth/login/view/login.dart';
import 'package:cubit/features/auth/signup/cubit/signup_cubit.dart';
import 'package:cubit/features/auth/signup/cubit/signup_state.dart';
import 'package:cubit/features/Home/view/screen_home.dart';
import 'package:cubit/widgets/custom_button.dart';
import 'package:cubit/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    TextEditingController rePasswordcontroller = TextEditingController();
    final formkey = GlobalKey<FormState>();

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formkey,
            child: BlocConsumer<SignupCubit,SignupState>(
              
              
              builder: (context, state) {
         return     Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Center(child: Text('Sign Up', style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold))),

                    textWidget('Enter you Email', emailcontroller),
                    CustomTextfield(
                      textEditingController: emailcontroller,
                      hintText: '',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => checkValidator(value, 'Email'),
                    ),
                    textWidget('Enter you Password', emailcontroller),
                    CustomTextfield(
                      textEditingController: passwordcontroller,
                      hintText: '',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      validator: (value) => checkValidator(value, 'Password'),
                    ),

                    textWidget('Re enter your Password', rePasswordcontroller),

                    CustomTextfield(
                      textEditingController: rePasswordcontroller,
                      hintText: '',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => checkValidator(value, 'Repassword'),
                    ),

                    CustomButton(
                      ontap: () {
                       if(formkey.currentState!.validate()){
                         context.read<SignupCubit>().signUp(
                              email: emailcontroller.text,
                              password: passwordcontroller.text,
                            );
                       }
                      },
                      buttonWidget: state is SignUpLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have and account"),
                        TextButton(child: Text('SignIn'), onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                        }),
                      ],
                    ),
                  ],
                );
            }, listener: (context, state) {
                          if (state is SignUpError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          }

                          if (state is SignUpLoaded) {
                           
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Sign up successfull')),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ScreenHome(),
                              ),
                            );
                          }
                        
            },)
          ),
        ),
      ),
    );
  }

  Widget textWidget(String text, TextEditingController texteditingcontrolller) {
    return Text(text, style: TextStyle(color: Colors.grey, fontSize: 11));
  }
}
