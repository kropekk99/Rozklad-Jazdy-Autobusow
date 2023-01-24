import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache/flutter_cache.dart' as cache;
import 'package:transport/screens/autobusy.dart';


class Miasta extends StatefulWidget {
  @override
  State<Miasta> createState() => _MiastaState();
}

class _MiastaState extends State<Miasta> {
  List _miasta = [];

  Future<void> readJsonFile() async {

    var miaData = await cache.remember('json', () async {
      var url = 'https://api.npoint.io/102608878c0a16e1c13e';
      var res = await http.get(Uri.parse(url));
      return json.decode(res.body);
    }, 300);
    setState(() {
      _miasta = miaData['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    readJsonFile();
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              'Wybierz miasto'
          ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(10.0),
          child: Text("Lista dostępnych miast:"),
          ),
        Expanded(
            child: ListView.builder(
              itemCount: _miasta.length,
              itemBuilder: (BuildContext context,index)  {
                return Card(
                  child: ListTile(
                      title: Text(_miasta[index]["miasto"],
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xff30c000), fontSize: 24, fontWeight: FontWeight.bold)),
                      dense: true,
                      visualDensity: VisualDensity(vertical: 4),
                      leading: Icon(Icons.apartment,
                          color: Color(0xff30c000),
                          size: 40),
                      trailing: Icon(Icons.arrow_forward_rounded,
                          color: Color(0xff30c000),
                          size: 40),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Autobusy(index)));
                      }
                  ),
                );
              },),
        ),
        ],),);
  }}
