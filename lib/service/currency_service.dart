// import 'dart:convert';

// import 'package:exchange_rate/model/ExchangeRate.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;

// class ExchangeRateService {
//   static var client = http.Client();

//   static Future<ExchangeRate> fetchExchangeRate() async {
//     var response =
//         await client.get(Uri.parse('https://forex.cbm.gov.mm/api/latest'));
//     if (response.statusCode == 200) {
//       debugPrint(" Response: " + response.statusCode.toString());
//       var jsonString = response.body;
//       return parseExchangeRate(jsonString);
//     } else {
//       return null!;
//     }
//   }

//   static Future<String> parseExchangeRate(
//       String responseBody) async {
//     final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

//     List<ExchangeRate> mList = parsed
//         .map<ExchangeRate>((json) => ExchangeRate.fromJson(json))
//         .toList();

//     debugPrint("AllLearningLessonList: " + mList.length.toString());
//     ;
//   }
// }
