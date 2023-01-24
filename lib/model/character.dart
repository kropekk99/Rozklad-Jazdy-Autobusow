import 'package:meta/meta.dart';

class Miasto {
  final String miasto;
  final String linie;
  final String numer;
  final String przystanki;
  final String nazwa;
  final String wspolrzedne;
  final String rozklad;
  final String godzina;
  final String minuty;

  const Miasto({
    required this.miasto,
    required this.linie,
    required this.numer,
    required this.przystanki,
    required this.nazwa,
    required this.wspolrzedne,
    required this.rozklad,
    required this.godzina,
    required this.minuty
  });

  static Miasto fromJson(json) => Miasto(
        miasto: json['miasto'],
        linie: json['linie'],
        numer: json['numer'],
        przystanki: json['przystanki'],
        nazwa: json['nazwa'],
        wspolrzedne: json['wspolrzedne'],
        rozklad: json['rozklad'],
        godzina: json['godzina'],
        minuty: json['minuty']);
}