import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache/flutter_cache.dart' as cache;
import 'package:transport/screens/rozklad.dart';

class Przystanki extends StatefulWidget {
  final int numer;
  final int id;
  Przystanki(this.numer, this.id);

  @override
  State<Przystanki> createState() => _PrzystankiState();
}

class _PrzystankiState extends State<Przystanki> {
  List _przystanki = [];

  Future<void> readJsonFile() async {
    var przData = await cache.remember('json', () async {
      var url = 'https://api.npoint.io/102608878c0a16e1c13e';
      var res = await http.get(Uri.parse(url));
      return await json.decode(res.body);
    }, 300);

      setState(() {
        _przystanki = przData['data'][widget.id]['linie'][widget.numer]['przystanki'];
      });
    }

        @override
        Widget build(BuildContext context) {
      readJsonFile();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Wybierz przystanek'),
          centerTitle: true,
          automaticallyImplyLeading: false,),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _przystanki.length,
                itemBuilder: (BuildContext context,index)  {
                  return Card(
                    child: ListTile(
                        title: Text(_przystanki[index]["nazwa"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Color(0xff30c000), fontSize: 24, fontWeight: FontWeight.bold)),
                        dense: true,
                        visualDensity: const VisualDensity(vertical: 4),
                        leading: const Icon(Icons.place_rounded,
                            color: Color(0xff30c000),
                            size: 40),
                        trailing: const Icon(Icons.arrow_forward_rounded,
                            color: Color(0xff30c000),
                            size: 40),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Rozklad(index, widget.id, widget.numer)));
                        }
                    ),
                  );
                },),
            ),
          ],),
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