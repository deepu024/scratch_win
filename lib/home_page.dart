// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // initialize images
  AssetImage circle = AssetImage('images/circle.png');
  AssetImage lucky = AssetImage('images/rupee.png');
  AssetImage unlucky = AssetImage('images/sadFace.png');

  // initialize variables
  late List<String> itemArray;
  late int luckyNumber;

  //initi function
  @override
  void initState() {
    super.initState();
    setState(() {
      itemArray = List<String>.generate(25, (index) => "empty");
    });
    generateLuckyNumber();
  }

  // radndom number generate
  generateLuckyNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  // reset game
  reset() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
    });
    generateLuckyNumber();
  }

  // get images
  AssetImage getImage(int index) {
    String current = itemArray[index];
    switch (current) {
      case "lucky":
        return lucky;
      case "unlucky":
        return unlucky;
    }
    return circle;
  }

  // play game
  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = "lucky";
      });
    } else {
      setState(() {
        itemArray[index] = "unlucky";
      });
    }
  }

  //show all
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scratch Win',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    playGame(i);
                  },
                  child: Image(
                    image: getImage(i),
                  ),
                ),
              ),
              itemCount: itemArray.length,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: MaterialButton(
              onPressed: () {
                showAll();
              },
              color: Colors.green,
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Show All",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: MaterialButton(
              onPressed: () {
                reset();
              },
              color: Colors.green,
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Reset",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
