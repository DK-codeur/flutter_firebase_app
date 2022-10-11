import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_firebase_project/add_place_screen.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {

  final ref = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Places"
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPlaceScreen())
              ), 
            icon: const Icon(Icons.add_circle_outline)
          )
        ],
      ),

      body: FutureBuilder(
        future: ref.child("country").get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if(snapshot.connectionState == ConnectionState.done) {
            List countries = snapshot.data ?? [];
            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(countries[index]["country"]),
                  subtitle: Text(countries[index]["capital"]),
                );
              }
            );
          } else {
            return const Text("No data");
          }
        }
      ),
    );
  }
}