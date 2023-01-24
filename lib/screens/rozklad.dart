import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache/flutter_cache.dart' as cache;
import 'package:transport/screens/mapa.dart';

class Rozklad extends StatefulWidget {
  final int przystanek;
  final int id;
  final int numer;
  Rozklad(this.przystanek, this.id, this.numer);


  @override
  State<Rozklad> createState() => _RozkladState();
}

class _RozkladState extends State<Rozklad> {
  List _rozklad = [];

  Future<void> readJsonFile() async {

    var rozData = await cache.remember('json', () async {
      var url = 'https://api.npoint.io/102608878c0a16e1c13e';
      var res = await http.get(Uri.parse(url));
      return json.decode(res.body);
    }, 300);

    if (!mounted) return;
    setState(() {
      _rozklad = rozData['data'][widget.id]['linie'][widget.numer]['przystanki'][widget.przystanek]['rozklad'];
    });

  }

  @override
  Widget build(BuildContext context) {
    readJsonFile();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rozkład jazdy'
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context,index)  {
                return const Card(
                  child:
                  ListTile(
                      title: Text('Minuty',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),

                      leading: Text('Godziny',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xff30c000), fontSize: 22, fontWeight: FontWeight.bold))
                  ),
                );
              })
          ),
          Expanded(
            flex: 10,
            child:ListView.builder(
              itemCount: _rozklad.length,
              itemBuilder: (BuildContext context,index)  {
                return Card(
                  child:
                  ListTile(
                      title: Text(_rozklad[index]["minuty"],
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.white, fontSize: 20)),
                      dense: true,
                      visualDensity: const VisualDensity(vertical: 4),
                      leading: Text(_rozklad[index]["godzina"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Color(0xff30c000), fontSize: 24, fontWeight: FontWeight.bold))
                  ),
                );
              }),
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Mapa(widget.przystanek, widget.id, widget.numer)));},
              child: _Button(),
            ),),
        ],
      ),
    );
  }
  Widget  _Button() {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 8, 5, 8),
      height: 60,
      width: 500,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff30c000),
              Color(0xffeceff3),
            ],
          )),
      child: const Center(
        child: Text(
          'Pokaż przystanek na mapie',
          style: TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    );
  }
}