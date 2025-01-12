import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final String label;
  final String rate;
  final String currency;

  const CryptoCard({
    required this.label,
    required this.rate,
    required this.currency,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          "1 $label = $rate $currency",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 20.0,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
