import 'package:flutter/material.dart';

import '../../models/products.dart';
class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SanitaryPadLocation> mockLocations = [
      SanitaryPadLocation(
        name: "Menstrual Pads",
        address: "Regular Pads",
        phoneNumber: "Pantyliners",
        additionalInfo: "Maxi Pads",
      ),
      SanitaryPadLocation(
        name: "Tampons",
        address: "Regular Tampons",
        phoneNumber: "Super Tampons",
        additionalInfo: "Applicator Tampons",
      ),
      SanitaryPadLocation(
        name: "Menstrual Cups",
        address: "Silicone Menstrual Cups",
        phoneNumber: "Rubber Menstrual Cups",
        additionalInfo: "",
      ),
      SanitaryPadLocation(
        name: "Period Underwear",
        address: "Absorbent Underwear",
        phoneNumber: "Leak-Proof Panties",
        additionalInfo: "",
      ),
      SanitaryPadLocation(
        name: "Feminine Wipes",
        address: "Flushable Wipes",
        phoneNumber: "Biodegradable Wipes",
        additionalInfo: " ",
      ),
      SanitaryPadLocation(
        name: "Disposable Under-pads",
        address: "Sanitary Disposal Bags",
        phoneNumber: " ",
        additionalInfo: " ",
      ),

    ];

    return   Scaffold(
      appBar: AppBar(
        title: const Text('Pad Tracker'),
      ),
      body: ListView.builder(
        itemCount: mockLocations.length,
        itemBuilder: (context, index) {
          final location = mockLocations[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Card(
              color: Colors.pink,
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
          );
        },
      ),
    );
  }
}
