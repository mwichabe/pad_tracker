import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pad_tracker/screens/home/locationMapScreen.dart';
import 'package:pad_tracker/screens/home/notification.dart';
import 'package:pad_tracker/screens/home/places.dart';
import 'package:pad_tracker/screens/home/profile.dart';
import '../../models/userModel.dart';

class InnerHome extends StatefulWidget {
  const InnerHome({Key? key}) : super(key: key);

  @override
  State<InnerHome> createState() => _InnerHomeState();
}

class _InnerHomeState extends State<InnerHome> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModelOne loggedInUser = UserModelOne(uid: '');

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Profile()));
          },
          icon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Hello, ${loggedInUser.userName}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Places()));
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NotificationPage()));
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Cycle',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Go to profile to add your recent cycle',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${loggedInUser.recentCycle}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.pink, // Change this to the desired color
            height: 120,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Woman Hygiene',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
