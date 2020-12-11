import 'dart:convert';
import 'package:http/http.dart' as http;

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

const apiKey = 'D77EBDA4-A032-4049-B076-8B55B7F9A8DE';

class CoinData {
  CoinData(this.key, this.currency);
  String key;
  String currency;

  Future getCoinData() async {
    http.Response response = await http.get(
        'https://rest.coinapi.io/v1/exchangerate/$key/$currency?apikey=$apiKey');
    String data = response.body;
    print(data);
    var coinData = jsonDecode(data);
    double rv = coinData['rate'];
    return rv.toInt();
  }
}
