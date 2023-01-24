import 'package:flutter/material.dart';
import 'package:transport/screens/miasta.dart';

class BouncingButton extends StatefulWidget {
  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}
class _BouncingButtonState extends State<BouncingButton> with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
      appBar: AppBar(
        title: Text("Rozkład autobusów"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
              'assets/images/bus.png',
              height: 300,
              width: 300),
          Text('Wybierz miasto aby rozpocząć.',style: TextStyle(color: Color(0xff30c000),fontSize: 20.0),),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: GestureDetector(
              onTapDown: _tapDown,
              onTapUp: _tapUp,
              child: Transform.scale(
                scale: _scale,
                child: _animatedButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget  _animatedButton() {
    return Container(
      height: 60,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff30c000),
              Color(0xffeceff3),
            ],
          )),
      child: Center(
        child: Text(
          'WYBIERZ',
          style: TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    );
  }
  
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Miasta()));
  }
  
  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }
  void _tapUp(TapUpDetails details) {
    _navigateToNextScreen(context);
    _controller.reverse();
  }
}