import 'package:cubit/features/auth/login/view/login.dart';
import 'package:cubit/features/auth/signup/cubit/signup_cubit.dart';
import 'package:cubit/features/auth/signup/cubit/signup_state.dart';
import 'package:cubit/features/Home/view/screen_home.dart';
import 'package:cubit/widgets/bottom_navigation.dart';
import 'package:cubit/widgets/custom_button.dart';
import 'package:cubit/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    TextEditingController rePasswordcontroller = TextEditingController();
    final formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
  
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

                   CustomTextfield(
                    prefixIcon:  const Icon(Icons.mail_outline_rounded),
                      textEditingController: emailcontroller,
                      hintText: 'Enter you Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => checkValidator(value, 'Email'),
                    ),
                    SizedBox(height: 10,),

                    CustomTextfield(
                    
                      textEditingController: passwordcontroller,
                      hintText: 'Enter you Password',
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.text,
                      validator: (value) => checkValidator(value, 'Password'),
                                      prefixIcon:  Icon(Icons.lock_outline_rounded),
                                      suffixIcon: IconButton(onPressed: (){
                                        setState(() {
                                          _obscurePassword=!_obscurePassword;
                                        });
                                      }, icon: Icon(_obscurePassword?Icons.visibility_off_outlined:Icons.visibility)),
                    ),
SizedBox(height: 10,),

                    CustomTextfield(
                      textEditingController: rePasswordcontroller,
                      hintText: 'Re-Enter your Password',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      validator: (value) => checkValidator(value, 'Repassword'),
                                                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                                                          

                    ),
SizedBox(height: 10,),

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
                         
                          }
                        
            },)
          ),
        ),
      ),
    );
  }
}
