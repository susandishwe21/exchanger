import 'dart:convert';
import 'package:exchange_rate/controller/currency_controller.dart';
import 'package:exchange_rate/model/Rate.dart';
import 'package:exchange_rate/model/currency.dart';
import 'package:exchange_rate/screen/calculate_currency.dart';
import 'package:exchange_rate/service/currency_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ShowAllLatestExchangeRate extends StatefulWidget {
  const ShowAllLatestExchangeRate({Key? key}) : super(key: key);

  @override
  _ShowAllLatestExchangeRateState createState() =>
      _ShowAllLatestExchangeRateState();
}

class _ShowAllLatestExchangeRateState extends State<ShowAllLatestExchangeRate> {
  CurrencyController _controller = Get.put(CurrencyController());
  TextEditingController _txtDateController = TextEditingController();
  final _dateFocusNode = FocusNode();

  var date;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    date = DateTime.now();
    var format = DateFormat('dd-MM-yyyy').format(date);
    _txtDateController.text = format.toString().substring(0, 10);
    debugPrint('DATE ${_txtDateController.text}');
    _controller.fetchCurrency(_txtDateController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exchange Rates"),
        leading: Icon(Icons.home),
        backgroundColor: Color.fromRGBO(75, 214, 145, 1.0),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
                margin: EdgeInsets.all(10),
                height: 45,
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  focusNode: _dateFocusNode,
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  controller: _txtDateController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.event),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      )),
                  onTap: () async {
                    debugPrint("SelectedDates: ${_txtDateController.text}");

                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      selectableDayPredicate: (DateTime val) =>
                          val.weekday == 6 || val.weekday == 7 ? false : true,
                    );

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        date = pickedDate;
                        _txtDateController.text = formattedDate;
                        _controller.fetchCurrency(_txtDateController.text);
                      });
                    } else {}
                  },
                )),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: _buildShowAllExchangeList(context),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowAllLatestExchangeRate()));
                },
              ),
            ),
            Expanded(
              child: IconButton(
                  icon: Icon(Icons.swap_calls,
                      color: Color.fromRGBO(75, 214, 145, 1.0)),
                  onPressed: () {
                    if (_controller.dataList['USD'] == null) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text('No Data'),
                              ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalculateCurrencyScreen(
                                    data: _controller.dataList['USD'],
                                  )));
                    }
                  }),
            ),
            Expanded(
              child: IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowAllExchangeList(BuildContext context) {
    return GetBuilder<CurrencyController>(
        init: CurrencyController(),
        builder: (_ctrl) => _ctrl.dataList.length > 0
            ? ListView.builder(
                itemCount: _ctrl.dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = _ctrl.dataList.keys.elementAt(index);
                  debugPrint("Key:$key");
                  return Material(
                    elevation: 24,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 4,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CalculateCurrencyScreen(
                                            data: _ctrl.dataList[key],
                                          )));
                              debugPrint("USD : ${_ctrl.dataList[key]}");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('${key} : '),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(_ctrl.dataList[key]),
                                    Text('kyats')
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CalculateCurrencyScreen(
                                                  data: _ctrl.dataList[key],
                                                )));
                                  },
                                  icon: Icon(Icons.swap_calls),
                                  color: Color.fromRGBO(75, 214, 145, 1.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text('No Data'),
              ));
  }
}
