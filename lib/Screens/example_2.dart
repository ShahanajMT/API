import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photoList = [];

  Future<List<Photos>> getPhoto() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      //photoList.clear();
      for (Map<String, dynamic> i in data) {
        Photos photos = Photos(url: i['url'], title: i['title'], id: i['id']);
        photoList.add(photos);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('REST API Call'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhoto(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                return ListView.builder(
                  itemCount: photoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      subtitle: Text('Note Id: ${snapshot.data![index].id.toString()}'),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                      ),
                      title: Text(snapshot.data![index].title.toString()),
                    );
                  },
                );
              }
            ),
          )
        ],
      ),
    );
  }
}

class Photos {
  String? url;
  String? title;
  int id;

  Photos({required this.url, required this.title, required this.id});
}
