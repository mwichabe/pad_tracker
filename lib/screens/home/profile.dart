import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/userModel.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading=false;
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModelOne loggedInUser = UserModelOne(uid: '');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModelOne.fromMap(value.data());
      setState(() {});
    });
  }
  //
  final TextEditingController recentCycleEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold
      (
        body: SingleChildScrollView
                (
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 60, 20, 40,),
                  child: Column
                    (
                    children:
                    [
                      Center(
                        child: Container
                          (
                          width: 200,
                          decoration: const BoxDecoration
                            (
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: const Padding(
                            padding:  EdgeInsets.fromLTRB(2, 2,10,2),
                            child: Row
                              (
                              children:
                              [
                                Icon(Icons.person,color: Colors.white,),
                                SizedBox(width: 5,),
                                Text('Profile',style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row
                        (
                        children:
                        [
                          const Icon(Icons.person_2_outlined, color: Colors.black,),
                          const SizedBox(width: 3,),
                          Text('${loggedInUser.userName}',style: const TextStyle(color: Colors.black),),
                        ],
                      ),
                      const Divider(color: Colors.grey,),
                      const SizedBox(height: 10,),
                      const Divider(color: Colors.grey,),
                      const SizedBox(height: 10,),
                      Form(
                          key: _formKey,
                          child: Column
                            (
                            children:
                            [
                              TextFormField
                                (
                                style: const TextStyle(color: Colors.black),
                                controller: recentCycleEditingController,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return 'Field required';
                                  }
                                  return null;
                                },
                                decoration:  InputDecoration
                                  (
                                    helperText: "27/07/2029",
                                    helperStyle: const TextStyle(color: Colors.black),
                                    enabledBorder: const UnderlineInputBorder
                                      (
                                        borderSide: BorderSide
                                          (
                                            color: Colors.grey
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder
                                      (
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    hoverColor: Colors.white,
                                    hintText: '27/08/2023',
                                    label: const Text('Recent Cycle Date',style: TextStyle(color: Colors.black),),
                                    prefixIcon: const Icon(Icons.calendar_month_outlined,color: Colors.black,)

                                ),
                              ),
                              SizedBox(height: 10,),
                              TextFormField
                                (
                                style: const TextStyle(color: Colors.black),
                                controller: phoneEditingController,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return 'Field required';
                                  }
                                  return null;
                                },
                                decoration:  InputDecoration
                                  (
                                    hintText: "Enter your phone number",
                                    hintStyle: const TextStyle(color: Colors.black),
                                    enabledBorder: const UnderlineInputBorder
                                      (
                                        borderSide: BorderSide
                                          (
                                            color: Colors.grey
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder
                                      (
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    hoverColor: Colors.white,
                                    label: const Text('Phone Number',style: TextStyle(color: Colors.black),),
                                    prefixIcon: const Icon(Icons.phone,color: Colors.black,)

                                ),
                              ),
                              const SizedBox(height: 25,),
                            ],
                          )
                      ),
                      Stack
                        (
                        alignment: Alignment.center,
                        children:
                        [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading=true ;
                                });
                                try {
                                  loggedInUser.recentCycle=recentCycleEditingController.text;
                                  loggedInUser.phoneNumber=phoneEditingController.text;
                                  await FirebaseFirestore.instance.collection('users')
                                      .doc(user!.uid)
                                      .update(loggedInUser.toMap());
                                  Navigator.pushReplacementNamed(context, 'home');
                                } catch (err) {
                                  Fluttertoast.showToast(msg: 'No image selected, please update your profile photo.');
                                }
                              }
                              setState(() {
                                isLoading=false;
                              });
                            },
                            style: ElevatedButton.styleFrom
                              (
                              //backgroundColor: buttonColor,
                            ),


                            child: const Text('SAVE'),),
                          if (isLoading)
                            const CircularProgressIndicator(),
                        ],
                      ),
                      ElevatedButton(onPressed: (){
                        Navigator.pushReplacementNamed(context, 'home');
                      },
                          child: Text('Back Home')
                      )
                    ],
                  ),
                ),
              ));


  }
}
