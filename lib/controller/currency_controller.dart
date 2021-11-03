import 'dart:collection';
import 'dart:convert';
import 'package:exchange_rate/model/currency.dart';
import 'package:exchange_rate/model/rate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CurrencyController extends GetxController {
  static var client = http.Client();

  //var dataList = new LinkedHashMap();
  Map<String, dynamic> dataList = new Map<String, dynamic>();
  Map listMap = Map();

  fetchCurrency(String date) async {
    debugPrint("_$date");
    dataList.clear();
    final response = await client
        .get(Uri.parse('https://forex.cbm.gov.mm/api/history/' + date));
    debugPrint("Currency Results ${response.statusCode}");
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      dataList = jsonData['rates'];
      debugPrint("Data List :${dataList.length}");
      setListMap(dataList);
    } else {}
    update();
  }

  void setListMap(Map listMap) {
    listMap = listMap;
    debugPrint("ListMap : $listMap");
  }
}
