import 'dart:async';

import 'package:exchange_rate/screen/show_all_currency_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _timer = new Timer(
        Duration(seconds: 2), () => Get.off(() => ShowAllLatestExchangeRate()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/money.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FractionallySizedBox(
          widthFactor: 0.8,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(
                color: Color.fromRGBO(75, 214, 145, 1.0).withOpacity(1),
                width: 4,
              ),
            ),
            child: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              child: LinearProgressIndicator(
                  minHeight: 20,
                  value: 0.5,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(75, 214, 145, 1.0))),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Loading....',
          textScaleFactor: 1.0,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
