import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getData() async {
  var result =
      await http.get(Uri.parse("http://192.168.43.161:8082/api/user/getAll"));
  print(result.body);
  return result;
}

// Future<http.Response> postData() async {
//   Map<String, dynamic> data = {
//     "nama": "jhon doe",
//     "email": "postmethod@test.com"
//   };
//   var result = await http.post(
//       Uri.parse("http://192.168.43.161:8082/api/user/insert"),
//       headers: <String, String>{
//         "Content-Type": "application/json; charset=UTF-8"
//       },
//       body: json.encode(data));
//   print(result.statusCode);
//   return result;
// }

Future<http.Response> updateData(int id, Map<String, String> data) async {
  // Map<String, dynamic> data = {
  //   "nama": "jhon doe",
  //   "email": "postmethod@test.com"
  // };
  var result = await http.put(
      Uri.parse("http://127.0.0.1:8082/api/user/update/${id}"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: json.encode(data));
  print(result.statusCode);
  return result;
}

Future<http.Response> deleteData(int id) async {
  var result = await http.delete(
    Uri.parse("http://192.168.43.161:8082/api/user/delete/${id}"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8"
    },
  );
  print(result.statusCode);
  return result;
}

class NetworkHome extends StatelessWidget {
  const NetworkHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NetworkinghttpApp(),
    );
  }
}

class NetworkinghttpApp extends StatefulWidget {
  NetworkinghttpApp({super.key});

  @override
  State<NetworkinghttpApp> createState() => _NetworkinghttpAppState();
}

class _NetworkinghttpAppState extends State<NetworkinghttpApp> {
  final add1 = TextEditingController();
  final add2 = TextEditingController();
  final add3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<http.Response> inputData(Map<String, String> data) async {
      var result = await http.post(
          Uri.parse("http://127.0.0.1:8082/api/user/insert"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(data));
      print(result.statusCode);
      return result;
    }

    var data = getData();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text("CRUD")),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.black,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    scrollable: true,
                    title: Text('Tambah'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: ' nama',
                                icon: Icon(Icons.people),
                              ),
                              controller: add1,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'email',
                                icon: Icon(Icons.email),
                              ),
                              controller: add2,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'gender',
                                icon: Icon(Icons.family_restroom),
                              ),
                              controller: add3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          child: Icon(Icons.add),
                          onPressed: () async {
                            await inputData(
                              {
                                "nama": add1.text,
                                "email": add2.text,
                                "gender": add3.text
                              },
                            );
                            add1.clear();
                            add2.clear();
                            add3.clear();
                            setState(() {});
                            Navigator.pop(context);
                          })
                    ]);
              });
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<http.Response>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> json = jsonDecode(snapshot.data!.body);
            return ListView.builder(
              itemCount: json.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(json[index]["nama"] ?? ''),
                  subtitle: Text(json[index]["email"] ?? ''),
                  onTap: () {},
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            add1.text = json[index]["nama"];
                            add2.text = json[index]["email"];
                            add3.text = json[index]["gender"];
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      scrollable: true,
                                      title: Text('Tambah'),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Form(
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: ' nama',
                                                  icon: Icon(Icons.people),
                                                ),
                                                controller: add1,
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'email',
                                                  icon: Icon(Icons.email),
                                                ),
                                                controller: add2,
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'gender',
                                                  icon: Icon(
                                                      Icons.family_restroom),
                                                ),
                                                controller: add3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            child: Text("Update"),
                                            onPressed: () async {
                                              await updateData(
                                                json[index]["id"],
                                                {
                                                  "nama": add1.text,
                                                  "email": add2.text,
                                                  "gender": add3.text
                                                },
                                              );
                                              add1.clear();
                                              add2.clear();
                                              add3.clear();
                                              setState(() {});
                                              Navigator.pop(context);
                                            })
                                      ]);
                                });
                            setState(() {});
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            await deleteData(json[index]["id"]);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
