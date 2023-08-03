// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:rest_api/models/user_models.dart';

class ComplexJson extends StatefulWidget {
  const ComplexJson({super.key});

  @override
  State<ComplexJson> createState() => _ComplexJsonState();
}

class _ComplexJsonState extends State<ComplexJson> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      userList.clear();
      for (Map<String, dynamic> i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          
          'Complex Json',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: Container(
                          decoration: BoxDecoration(
                            
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.yellowAccent,
                            
                          ),
                          child: Column(
                            children: [
                              Resusable(title: 'Name: ', value: snapshot.data![index].name.toString()),
                              Resusable(title: 'UserName: ', value: snapshot.data![index].username.toString()),
                              Resusable(title: 'Email: ', value: snapshot.data![index].email.toString()),
                              Resusable(title: 'Address', value: snapshot.data![index].address!.geo!.lat.toString()),
                            ],
                            
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator(
                    strokeWidth: 2,
                  );
                }
              },
            ),
          ),
        ],
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
