import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int second = 0, minute = 0, hour = 0;
  String digitsecond = "00", digitminute = "00", digithour = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      second = 0;
      minute = 0;
      hour = 0;

      digitsecond = "00";
      digitminute = "00";
      digithour = "00";

      started = false;
    });
  }

  void addlaps() {
    if (second + minute + hour > 1) {
      String lap = "$digithour:$digitminute:$digitsecond";
      setState(() {
        laps.add(lap);
      });
    }
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localsecond = second + 1;
      int localminute = minute;
      int localhour = hour;

      if (localsecond > 59) {
        if (localminute > 59) {
          localhour++;
          localminute = 0;
        } else {
          localminute++;
          localsecond = 0;
        }
      }
      setState(() {
        hour = localhour;
        minute = localminute;
        second = localsecond;

        digitsecond = (second >= 10) ? "$second" : "0$second";
        digitminute = (minute >= 10) ? "$minute" : "0$minute";
        digithour = (hour >= 10) ? "$hour" : "0$hour";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2757),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Stopwatch App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                "$digithour:$digitminute:$digitsecond",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 83.0),
              ),
            ),
            Container(
                height: 400.0,
                decoration: BoxDecoration(
                    color: Color(0xFF323F68),
                    borderRadius: BorderRadius.circular(8.0)),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap no ${index + 1}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          Text(
                            "${laps[index]}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ],
                      ),
                    );
                  },
                )),
            Text("Develop by:faizan momin",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: RawMaterialButton(
                  onPressed: () {
                    (!started) ? start() : stop();
                  },
                  shape: const StadiumBorder(
                    side: BorderSide(color: Colors.blue),
                  ),
                  child: Text(
                    (!started) ? "Start" : "Stop",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
                IconButton(
                  onPressed: () {
                    addlaps();
                  },
                  icon: Icon(Icons.flag),
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                    child: RawMaterialButton(
                  fillColor: Colors.blue,
                  onPressed: () {
                    reset();
                  },
                  shape: const StadiumBorder(),
                  child: Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
