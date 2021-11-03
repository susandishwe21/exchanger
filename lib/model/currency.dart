import 'dart:convert';
import 'package:exchange_rate/model/rate.dart';

Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));

String currencyToJson(Currency data) => json.encode(data.toJson());

class Currency {
  String info;
  String description;
  Rates rates;
  Currency(
      {required this.info, required this.description, required this.rates});

  factory Currency.fromJson(Map<String, dynamic> json) {
    Rates _rates = Rates.fromJson(json['rates']);
    return Currency(
        info: json['info'],
        description: json['description'],
        rates: Rates.fromJson(json["rates"]));
  }
  Map<String, dynamic> toJson() => {
        "info": info,
        "description": description,
        "rates": rates.toJson(),
      };
}
