import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  void updateUI() async {
    CoinData cdBTC = CoinData('BTC', selectedValue);
    CoinData cdLTC = CoinData('LTC', selectedValue);
    CoinData cdETH = CoinData('ETH', selectedValue);
    BTCans = await cdBTC.getCoinData();
    ETHans = await cdETH.getCoinData();
    LTCans = await cdLTC.getCoinData();
  }

  DropdownButton getDropDownAndroid() {
    List<DropdownMenuItem<String>> DropDownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var newItem = DropdownMenuItem(
          child: Text(currenciesList[i]), value: currenciesList[i]);
      DropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedValue,
      items: DropDownItems,
      onChanged: (String value) {
        setState(() {
          selectedValue = value;
          updateUI();
        });
      },
    );
  }

  CupertinoPicker getPickeriOS() {
    List<Text> PickerList = [];
    for (int i = 0; i < currenciesList.length; i++) {
      PickerList.add(Text(currenciesList[i]));
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        // print(selectedIndex);
      },
      children: PickerList,
    );
  }

  Widget getCryptoBar(String crypto, int ans) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $ans $selectedValue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  String selectedValue = 'USD';

  int BTCans;
  int LTCans;
  int ETHans;

  @override
  void initState() {
    setState(() {
      updateUI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getCryptoBar('BTC', BTCans),
          getCryptoBar('ETH', ETHans),
          getCryptoBar('LTC', LTCans),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isAndroid ? getDropDownAndroid() : getPickeriOS())
        ],
      ),
    );
  }
}
