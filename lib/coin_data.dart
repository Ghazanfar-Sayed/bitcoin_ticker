import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKEY = "7D8D9917-F678-4A92-8DE0-D3BF9614FFD4";
const coinAPIURL = 'http://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

Future<double> getCoinData(String currency, String crypto) async {
  Uri url = Uri(
      host: "rest.coinapi.io",
      path: "/v1/exchangerate/$crypto/$currency",
      scheme: "https",
      queryParameters: {
        "apikey": apiKEY,
      });

  http.Response response = await http.get(url);
  print(url);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)["rate"];
  }

  return 0.0;
}
