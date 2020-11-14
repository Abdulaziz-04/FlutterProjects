import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'crypto_data.dart';

const greenCol = 0xff50c878;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> coinPrices;
  bool wait, fail;
  //Data takes time to be fetched and stateless widget loads instantly
  String selectedCurrency = 'INR';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoinPrice();
  }

  //Dropdown for android
  DropdownButton<String> dropDown() {
    List<DropdownMenuItem<String>> dropDownitems = [];
    for (String currency in currenciesList) {
      dropDownitems.add(
        DropdownMenuItem(
            child: Center(
              child: Text(currency),
            ),
            value: currency),
      );
    }
    return DropdownButton<String>(
      isExpanded: true,
      value: selectedCurrency,
      items: dropDownitems,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
            getCoinPrice();
          },
        );
      },
    );
  }

  //picker for ioS(untested)
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightGreenAccent,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(
          () {
            selectedCurrency = currenciesList[selectedIndex];
            getCoinPrice();
          },
        );
      },
      children: pickerItems,
    );
  }

  //Looping all display Cards
  Expanded displayCards() {
    List<Widget> cards = [];
    if (wait == false) {
      for (String cur in cryptoList) {
        cards.add(
          CryptoCard(
            selectedCurrency,
            cur,
            wait ? coinPrices[cur] : '???',
          ),
        );
      }
    } else {
      LoadingIcon();
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cards,
      ),
    );
  }

  //getting the value of cryptocurrencies
  void getCoinPrice() async {
    setState(() {
      wait = true;
      fail = false;
    });
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      setState(
        () {
          coinPrices = data;
          wait = false;
        },
      );
    } catch (e) {
      setState(() {
        wait = false;
        fail = true;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(greenCol),
        title: Center(
          child: Text(
            "Bitcoin Ticker",
            style: TextStyle(
                fontFamily: 'Moderno', color: Colors.black, fontSize: 30.0),
          ),
        ),
      ),
      body: wait
          ? LoadingIcon()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Platform.isIOS ? iOSPicker() : dropDown(),
                  ),
                ),
                displayCards(),
                fail
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'Couldn\'t Connect!',
                            style: TextStyle(
                                fontFamily: 'Moderno', fontSize: 30.0),
                          ),
                        ),
                      )
                    : '',
              ],
            ),
    );
  }
}

//Stateless widget of particular card
class CryptoCard extends StatelessWidget {
  CryptoCard(this.selectedCurrency, this.crypto, this.price);
  final String selectedCurrency, crypto, price;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(greenCol),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Text(
            '1 $crypto = $price $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30.0, fontFamily: 'Moderno', color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class LoadingIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCube(
        color: Color(greenCol),
      ),
    );
  }
}
