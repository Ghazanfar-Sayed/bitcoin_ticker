import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'components/crypto_card.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  String btcRate = '?';
  String ethRate = '?';
  String ltcRate = '?';
  Widget androidPicker() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      dropdownItems.add(DropdownMenuItem(
        value: currency,
        child: Text(
          currency,
          style: const TextStyle(color: Colors.white),
        ),
      ));
    }

    return DropdownButton<String>(
        dropdownColor: Colors.black,
        items: dropdownItems,
        onChanged: (value) async {
          double usdPrice = await getCoinData(value!, "BTC");
          double ethPrice = await getCoinData(value, "ETH");
          double ltcPrice = await getCoinData(value, "LTC");
          setState(() {
            selectedCurrency = value;
            btcRate = usdPrice.toStringAsFixed(2);
            ethRate = ethPrice.toStringAsFixed(2);
            ltcRate = ltcPrice.toStringAsFixed(2);
          });
        },
        value: selectedCurrency);
  }

  CupertinoPicker iOSPicker() {
    List<Widget> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(
        Text(currency),
      );
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {
        setState(() {
          selectedCurrency = currenciesList[value];
        });
      },
      children: pickerItems,
    );
  }

  dynamic getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidPicker();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Colors.blue,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Center(
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CryptoCard(
                      label: "BTC",
                      rate: btcRate,
                      currency: selectedCurrency,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CryptoCard(
                      label: "LTC",
                      rate: ltcRate,
                      currency: selectedCurrency,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CryptoCard(
                      label: "ETH",
                      rate: ethRate,
                      currency: selectedCurrency,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPicker(),
            ),
          ],
        ));
  }
}
