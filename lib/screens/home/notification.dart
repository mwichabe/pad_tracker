import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> notifications = [
      "New location added: Women's Shelter",
      "Reminder: Free sanitary pads distribution today at Community Center",
      "Update: NGO Support Center will be closed for maintenance",
      "Clinic Announcement: Free sanitary pads available for patients",
      "Library News: Restroom area now equipped with free sanitary pads",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacementNamed(context, 'home');
          }, icon: Icon(Icons.close))
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
            leading: const Icon(Icons.notifications),
          );
        },
      ),
    );
  }
}
