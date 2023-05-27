import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentReciept extends StatelessWidget {
  const PaymentReciept({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("رسید پرداخت"), centerTitle: true),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 48, 16, 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text("پرداخت با موفقیت انجام شد",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: Theme.of(context).colorScheme.primary)),
                SizedBox(
                  height: 32,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("وضعیت سفارش",
                          style: Theme.of(context).textTheme.subtitle1),
                      Text("پرداخت شده",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ]),
                Divider(
                  height: 32,
                  thickness: 1,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("مبلغ",
                          style: Theme.of(context).textTheme.subtitle1),
                      Text("1000 تومان",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ]),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(onPressed: () {}, child: Text('سوابق سفارش')),
              SizedBox(
                width: 12,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text('بازگشت به صفحه اصلی')),
            ],
          ),
        ],
      ),
    );
  }
}
