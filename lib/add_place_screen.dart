import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Place")),
      body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Country")
            ),
          ),

          const SizedBox(height: 20,),

          TextFormField(
            decoration: const InputDecoration(
              label: Text("Capital")
            ),
          ),

          TextButton(
            onPressed: () {}, 
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue
            ),
            child: const Text("Add"),
          )
        ],
      ),
    );
  }
}