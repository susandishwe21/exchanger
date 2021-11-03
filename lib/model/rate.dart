import 'dart:collection';

class Rates {
  String USD;
  String VND;

  Rates({required this.USD, required this.VND});

  var rates = new LinkedHashMap();

  factory Rates.fromJson(Map<String, dynamic> data) => Rates(
        USD: data["USD"],
        VND: data["VND"],
      );
  Map<String, dynamic> toJson() => {
        "USD": USD,
        "VND": USD,
      };
}
