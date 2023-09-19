import 'package:flutter/material.dart';
import 'package:pad_tracker/models/places.dart';
import 'package:pad_tracker/screens/home/locationMapScreen.dart';
class Places extends StatefulWidget {
  const Places({Key? key}) : super(key: key);

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  List<PlacesForSanitaryTowels> mockLocations = [
    PlacesForSanitaryTowels(
      name: "Women's Shelter",
      address: "123 Main St, City",
      phoneNumber: "123-456-7890",
      additionalInfo: "Open 9 AM - 5 PM",
    ),
    PlacesForSanitaryTowels(
      name: "Community Center",
      address: "456 Park Ave, Town",
      phoneNumber: "987-654-3210",
      additionalInfo: "Free distribution on Saturdays",
    ),
    PlacesForSanitaryTowels(
      name: "Health Clinic",
      address: "789 Elm St, Village",
      phoneNumber: "567-890-1234",
      additionalInfo: "Available during clinic hours",
    ),
    PlacesForSanitaryTowels(
      name: "Local Church",
      address: "567 Oak Rd, Suburb",
      phoneNumber: "345-678-9012",
      additionalInfo: "Contact for distribution schedule",
    ),
    PlacesForSanitaryTowels(
      name: "Community Center",
      address: "678 Maple Ave, Borough",
      phoneNumber: "456-789-0123",
      additionalInfo: "Free distribution on Wednesdays",
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Places that offer sanitary towels'),
      ),
      body: ListView.builder(
        itemCount: mockLocations.length,
        itemBuilder: (context, index) {
          final location = mockLocations[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationMapScreen(text: location.address)));
              },
              child: Card(
                color: Colors.grey.shade100,
                elevation: 4,
                child: ListTile(
                  title: Text(location.name,style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(location.address),
                      Text(location.phoneNumber),
                      Text(location.additionalInfo),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
