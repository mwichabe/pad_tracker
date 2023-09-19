import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/userModel.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  //loading
  bool isLoading = false;
  //firebase
  final _auth = FirebaseAuth.instance;
  bool passwordVisible = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF310544),
      appBar: AppBar(
          title: Text(
            'PAD TRACKER',
            style: GoogleFonts.rubik(
              textStyle: const TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0, // You can adjust the border width
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: const Color(0xFFd1e7e4),
                  radius: 40,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0, // You can adjust the border width
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color(0xFFd1e7e4),
                          radius: 20,
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('SIGN UP',
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24),
                    )),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameEditingController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            hintText: 'name',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            )),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value)
                        {
                          if(value!.isEmpty){
                            return ("Required");
                          }
                          if(!RegExp("^[A-Za-z]{3,}").hasMatch(value))
                          {
                            return("Name cannot be less than 3 characters.");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: userNameEditingController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            hintText: 'Enter username',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            )),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value)
                        {
                          if(value!.isEmpty){
                            return ("Required");
                          }
                          if(!RegExp("^[A-Za-z]{3,}").hasMatch(value))
                          {
                            return("Name cannot be less than 3 characters.");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
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
                            )),
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  register(emailEditingController.text, passwordEditingController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  'SIGN UP',
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  postDetailsToFirestore()async
  {
    // calling firestore
    FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
    User? user= _auth.currentUser;
    //calling usermodel
    UserModelOne userModel=UserModelOne(uid: '');
    // sending content
    userModel.email=user!.email;
    userModel.uid=user.uid;
    userModel.userName=userNameEditingController.text;
    userModel.fullName= nameEditingController.text;
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Navigator.pushReplacementNamed(
        (context), 'home');
    Fluttertoast.showToast(msg: 'Account created successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      timeInSecForIosWeb: 1,
      fontSize: 16,);
  }
  void register(String email,String password) async
  {
    if (formKey.currentState!.validate())
    {
      setState(() {
        isLoading=true;
      }
      );
      await _auth.createUserWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text)
          .then((value) => {
        postDetailsToFirestore()
      }).catchError((e)
      {log(e!.message);
      Fluttertoast.showToast(msg:'Registration failed. Check your Credentials and try again later.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 1,
        fontSize: 16,);
      });

    }
    setState(() {
      isLoading=false;
    });
  }
}
