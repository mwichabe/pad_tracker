
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


import 'forgotPassword.dart';
class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  //firebase
  final _auth = FirebaseAuth.instance;
  bool passwordVisible = true;
  bool rememberMe = false;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF310544),
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Text(
            'Login Activity',
            style: GoogleFonts.rubik(
              textStyle: const TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Center(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.height/2,
                  height: MediaQuery.of(context).size.height/9,
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 40,
                      color: Colors.red,
                      child: Text('PAD \n '
                          'TRACKER',style: GoogleFonts.rubik(
                        textStyle: const TextStyle(fontWeight: FontWeight.bold)
                      ),),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/5.5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailEditingController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            hintText: 'Enter Email',
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
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        obscureText: passwordVisible,
                        controller: passwordEditingController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value)
                        {
                          RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!$@#&*~]).{6,}$');
                          if(value!.isEmpty)
                          {
                            return('Password field required');
                          }
                          //regEx for password field
                          if(!regex.hasMatch(value)){
                            return ('Password should: \n'
                                ' Have at least 6 characters\n '
                                'Have a symbol \n'
                                'Have an uppercase \n'
                                'Have a numeric number \n'
                                'eg. padTracker@1');
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
            ),
             const SizedBox(height: 5,),
            Row(
                children: [
                  Checkbox(
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    value: rememberMe,
                    onChanged: (newValue) {
                      // Add your logic here to handle the checkbox state change
                      setState(() {
                        rememberMe = newValue ?? false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.white)
                    ),
                  ),
                  const Text('Remember Me',style: TextStyle(color: Colors.white),),
                  GestureDetector(
                    //we will implement later on
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ForgotPassword()));
                      },
                      child: const Text('     Forgot Password ?', style: TextStyle(color: Colors.blue),))
                ]
            ),
             SizedBox(
              height:  MediaQuery.of(context).size.height/8,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  signIn(emailEditingController.text,passwordEditingController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  'LOG IN',
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Have no Account?  ',style: GoogleFonts.rubik(
                  textStyle: const TextStyle(color: Colors.white)
                ),),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, 'signUp');
                  },
                  child: Text('Sign Up',style: GoogleFonts.rubik(
                      textStyle: const TextStyle(color: Colors.blue)
                  ),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  void signIn(String email, String password) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        // Perform sign-in
        var userCredential = await _auth.signInWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text,
        );


        setState(() {
          isLoading = false;
        }
        );

        // Navigate to home screen
        Navigator.pushReplacementNamed(context, 'home');

        // Show success message
        Fluttertoast.showToast(
          msg: 'Login Successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          timeInSecForIosWeb: 1,
          fontSize: 16,
        );
      } catch (e) {
        log(e.toString());

        setState(() {
          isLoading = false;
        });

        String errorMessage = 'An error occurred during sign-in.';
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'invalid-email':
              errorMessage = 'Invalid email address.';
              break;
            case 'user-not-found':
              errorMessage = 'User not found. Please check your credentials.';
              break;
            case 'wrong-password':
              errorMessage = 'Invalid password. Please check your password and try again.';
              break;
          // Add more cases for other possible error codes
            default:
              errorMessage = 'An error occurred during sign-in. Please try again later.';
          }
        }

        // Show error message
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 1,
          fontSize: 16,
        );
      }
    }
  }
}
