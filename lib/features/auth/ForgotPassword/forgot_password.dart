import 'package:cubit/features/auth/login/cubit/login_cubit.dart';
import 'package:cubit/features/auth/login/cubit/login_state.dart';
import 'package:cubit/widgets/custom_button.dart';
import 'package:cubit/widgets/custom_snackbar.dart';
import 'package:cubit/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
    static const Color kPrimary = Color(0xFF20B86B);

  final emailController = TextEditingController();

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
      } 
      return null;
    }

    @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit,LoginState>
    (
      
      listenWhen: (previous, current) => previous.loginstatus!=current.loginstatus,
      listener: (context, state) {
      if(state.loginstatus==LoginStatus.loaded){
        Appsnackbar.show(context, message: 'We sent a password reset link to your inbox',title: 'Check your email');
      }
      else if(state.loginstatus==LoginStatus.errormessage){
        Appsnackbar.show(context, message: state.errorMessage??'please try again',snacktype: SnackType.error);
      }
    },
    child:  Scaffold(
      body: Center(
child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
child: Column(
children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: kPrimary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.lock_reset_rounded,
                    color: kPrimary,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "No worries! Enter the email linked to your account and we'll send you a link to reset your password.",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 32),

                CustomTextfield(
                  validator: (value) =>checkValidator(value, 'Email') ,
                  textEditingController: emailController,
                  hintText: 'Email address',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.mail_outline_rounded),
                ),
                const SizedBox(height: 28),

            CustomButton(ontap: () {
              context.read<LoginCubit>().resetPassword(emailController.text.trim());
            }, buttonWidget: Text('Send Reset Link',  style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),)),

                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(foregroundColor:kPrimary ),
                    icon: const Icon(Icons.arrow_back_rounded, size: 18),
                    label: const Text(
                      'Back to Sign In',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),],),
),
      ),
    ),
    );
  }


}