import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexWoModel extends StatefulWidget {
  const ComplexWoModel({Key? key}) : super(key: key);

  @override
  State<ComplexWoModel> createState() => _ComplexWoModelState();
}

class _ComplexWoModelState extends State<ComplexWoModel> {
  List<dynamic> data = []; // Initialize the list with an empty list.

  Future<void> getUserApi() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );
      if (response.statusCode == 200) {
        setState(() {
          data = jsonDecode(response.body);
        });
      } else {
        // Handle API error here.
        print("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle other errors here.
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Json WO Model'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: data.isEmpty // Check if data is empty before building the list.
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                      ),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final user = data[index];
                        final address = user['address'];
                        final geo = address['geo'];

                        return Container(
                          child: Column(
                            children: [
                              Resusable(title: 'Name : ', value: user['name']),
                              Resusable(title: 'UserName : ', value: user['username']),
                              Resusable(title: 'Phone : ', value: user['phone']),
                              Resusable(title: 'Address: ', value: address['street'] + ', ' + address['city']),
                              Resusable(title: 'Lat: ', value: geo['lat']),
                              Resusable(title: 'Log: ', value: geo['lng']),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Resusable extends StatelessWidget {
  String title;
  String value;

  Resusable({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(title), Text(value)],
    );
  }
}
