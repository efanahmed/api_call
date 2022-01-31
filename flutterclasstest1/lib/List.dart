import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserInfoList extends StatelessWidget {
  const UserInfoList({Key? key}) : super(key: key);

  Future<List<dynamic>> getUserInfo() async {
    var response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("User Info"),
        backgroundColor: Colors.red,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: getUserInfo(),
          builder: (BuildContextcontext, AsyncSnapshot AsyncSnapshot) {
            if (AsyncSnapshot.hasData) {
              return ListView.builder(
                  itemCount: AsyncSnapshot.data.length,
                  itemBuilder: (context, int position) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          child: Text(
                            AsyncSnapshot.data[position]["id"].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        title: Text(
                          AsyncSnapshot.data[position]["name"].toString(),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          AsyncSnapshot.data[position]["body"].toString(),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
