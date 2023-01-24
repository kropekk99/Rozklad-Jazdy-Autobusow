import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache/flutter_cache.dart' as cache;
import 'package:transport/screens/przystanki.dart';

class Autobusy extends StatefulWidget {
  final int id;
  Autobusy(this.id);

  @override
  State<Autobusy> createState() => _AutobusyState();
}

class _AutobusyState extends State<Autobusy> {
  List _autobusy = [];


  Future<void> readJsonFile() async {

    var autData = await cache.remember('json', () async {
      var url = 'https://api.npoint.io/102608878c0a16e1c13e';
      var res = await http.get(Uri.parse(url));
      return json.decode(res.body);
    }, 300);

    setState(() {
      _autobusy = autData['data'][widget.id]['linie'];
    });
  }

  @override
  Widget build(BuildContext context) {
    readJsonFile();
    return Scaffold(
      appBar: AppBar(
          title: const Text("Lista Linii:"),
        centerTitle: true,
        automaticallyImplyLeading: false),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(10.0),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _autobusy.length,
              itemBuilder: (BuildContext context,index)  {
                return Card(
                  child: ListTile(
                      title: Text(_autobusy[index]["numer"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Color(0xff30c000), fontSize: 24, fontWeight: FontWeight.bold)),
                      dense: true,
                      visualDensity: const VisualDensity(vertical: 4),
                      leading: const Icon(Icons.directions_bus,
                          color: Color(0xff30c000),
                          size: 40),
                      trailing: const Icon(Icons.arrow_forward_rounded,
                          color: Color(0xff30c000),
                          size: 40),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Przystanki(index, widget.id)));
                      }
                  ),
                );
              },),
          ),
        ],),
    );
  }
}