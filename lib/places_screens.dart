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
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if(snapshot.connectionState == ConnectionState.done) {
           var countries = snapshot.data;
            debugPrint(countries.toString());
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  // title: Text(countries[index]["country"]),
                  // subtitle: Text(countries[index]["capital"]),
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

  Future<Object?> getData() async {
    await Firebase.initializeApp();
    var ref = FirebaseDatabase.instance.ref();
    final snp = ref.child("country").get().then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value); 
    });

    return snp;
    
  }
}