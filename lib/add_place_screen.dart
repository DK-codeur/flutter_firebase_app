import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _capitalController = TextEditingController();

  bool _isLoading = false;

  Future<void> createCountry(String country, String capital) async {
    var uuid = const Uuid();
    DatabaseReference ref = FirebaseDatabase.instance.ref("Country/${uuid.v4()}");
    await ref.set({
      "country": country,
      "capital": capital
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Place")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(
                  label: Text("Country")
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a country";
                  }
                  return null;
                },
              ),
        
              const SizedBox(height: 10,),
        
              TextFormField(
                controller: _capitalController,
                decoration: const InputDecoration(
                  label: Text("Capital")
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a capital";
                  }
                  return null;
                },
              ),
        
              const SizedBox(height: 20,),
        
              TextButton(
                onPressed: _isLoading ? null : () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  setState(() {
                    _isLoading = true;
                  });
                  createCountry(_countryController.text, _capitalController.text).whenComplete(() {
                    setState(() {
                      _isLoading = false;
                    });
                    //todo:
                  });
                }, 
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue
                ),
                child: Text(_isLoading ? "Loading..." : "Add place"),
              )
            ],
          ),
        ),
      ),
    );
  }
}