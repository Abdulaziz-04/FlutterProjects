import 'dart:convert';

import 'package:http/http.dart' as http;

const baseURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '49B96679-2E59-4EBB-B8C4-5425B670E694 ';
const List<String> currenciesList = [
  'INR',
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
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

class CoinData {
  Future getCoinData(String inputCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL = '$baseURL/$crypto/$inputCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var price = data['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(2);
      } else {
        print(response.statusCode);
        throw "Some Problem occured while retrieving data";
      }
    }
    return cryptoPrices;
  }
}
