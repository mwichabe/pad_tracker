import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xFF310544),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('Forgot password',style: GoogleFonts.rubik(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold
              )
            ),),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Form(
                key:formKey,
                child: TextFormField(
                  controller: emailEditingController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter Your email',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),

                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return('Email field is required');
                    }
                    //regEx for email
                    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)){return("Please Enter a valid  email");}
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(onPressed: (){
                passwordReset();
              }, child: const Text('RESET PASSWORD'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(onPressed: (){
                Navigator.pushReplacementNamed(context, '/');
              }, child: const Text('BACK TO SIGN IN'),
              ),
            ),

          ],
        ),
      ),
    );
  }
  passwordReset() {
    if(formKey.currentState!.validate()){
      try {
        FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailEditingController.text.trim());
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('Password reset link sent check your email\n'
                    'In case of inconveniences check Spam mails.'),
              );
            });
        //Navigator.pushNamed(context, '/lg');
      } on FirebaseAuthException catch (e) {
        log('Error: $e');
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('An error occurred confirm your email.'),
              );
            });
      }
    }
  }
}
