import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class BadgeWidget extends StatelessWidget {
  final int value;

  const BadgeWidget({super.key, required this.value});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value != 0,
      child: Container(
        width: 18,
        height: 18,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle),
        child: Text(
          value.toString().toPersianDigit(),
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 12),
        ),
      ),
    );
  }
}
