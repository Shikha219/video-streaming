// ignore_for_file: unused_local_variable, sort_child_properties_last, prefer_const_declarations, deprecated_member_use, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String link = "";
  String final_response = "";
  final _formkey = GlobalKey<FormState>();

  Future<void> _savingData() async {
    final validation = _formkey.currentState!.validate();

    if (!validation) {
      return;
    }

    _formkey.currentState!.save();
  }

  OutlineInputBorder _inputformdeco() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide:
          BorderSide(width: 1.0, color: Colors.blue, style: BorderStyle.solid),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            Container(
              width: 350,
              child: Form(
                  key: _formkey,
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Enter Rtsp Link: ',
                        enabledBorder: _inputformdeco(),
                        focusedBorder: _inputformdeco()),
                    onSaved: (value) {
                      link = value!;
                    },
                  )),
            ),
            FlatButton(
              onPressed: () async {
                _savingData();

                final url = 'http://10.0.2.2:5000/link';

                final response = await http.post(Uri.parse(url),
                    body: jsonEncode({'link': link}));
              },
              child: Text('Send'),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () async {
                final url = 'http://10.0.2.2:5000/link';

                final response = await http.get(Uri.parse(url));
                final decoded =
                    json.decode(response.body) as Map<String, dynamic>;

                setState(() {
                  final_response = decoded['link'];
                });
              },
              child: Text('Get'),
              color: Colors.lightBlue,
            ),
            Text(
              final_response,
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
