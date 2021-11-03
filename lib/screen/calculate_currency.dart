import 'package:exchange_rate/controller/currency_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CalculateCurrencyScreen extends StatefulWidget {
  String data;
  CalculateCurrencyScreen({required this.data});

  @override
  _CalculateCurrencyScreenState createState() =>
      _CalculateCurrencyScreenState(data: data);
}

class _CalculateCurrencyScreenState extends State<CalculateCurrencyScreen> {
  String data;
  _CalculateCurrencyScreenState({required this.data});

  final _txtController = TextEditingController();

  CurrencyController _controller = Get.put(CurrencyController());
  var currentValue = 1;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _txtController.text = currentValue.toString();
    _doCurrency();
    super.initState();
  }

  var calculateMya;

  void _doCurrency() {
    debugPrint("Data USD: ${data}");
    if (data.contains(',')) {
      var usdResult = data.toString().replaceAll(',', '');
      double result = double.parse(usdResult);
      setState(() {
        calculateMya = result * double.parse(_txtController.text);
        debugPrint("USD Result: $calculateMya");
      });
    } else {
      setState(() {
        var usdResult = data.toString();
        double result = double.parse(usdResult);
        calculateMya = result * (double.parse(_txtController.text));
        debugPrint("USD Result: $calculateMya");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Converter'),
          automaticallyImplyLeading: true,
          backgroundColor: Color.fromRGBO(75, 214, 145, 1.0),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                  side: const BorderSide(
                    color: Colors.white,
                    width: 4,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ListTile(
                          title: TextField(
                            autofocus: true,
                            controller: _txtController,
                            cursorColor: Color.fromRGBO(75, 214, 145, 1.0),
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.black),
                            keyboardType: TextInputType.number,
                          ),
                          trailing: const Text('USD')),
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        _doCurrency();
                      },
                      child: Icon(
                        Icons.swap_vert,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      shape: CircleBorder(),
                      elevation: 4.0,
                      fillColor: Color.fromRGBO(75, 214, 145, 1.0),
                      padding: EdgeInsets.all(8.0),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Color.fromRGBO(75, 214, 145, 1.0),
                          width: 2,
                        ),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: ListTile(
                          title: Chip(
                            backgroundColor: Colors.white,
                            label: data != null
                                ? Text(
                                    calculateMya.toString(),
                                    style: TextStyle(fontSize: 20),
                                  )
                                : Text(""),
                          ),
                          trailing: Text('MMK'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
