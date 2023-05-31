import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class InsertCommentDialog extends StatefulWidget {
  const InsertCommentDialog({super.key});

  @override
  State<InsertCommentDialog> createState() => _InsertCommentDialogState();
}

class _InsertCommentDialogState extends State<InsertCommentDialog> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: Container(
        height: 300,
        child: Column(
          children: [
            Text(
              "ثبت نظر",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _labelController,
              decoration: const InputDecoration(
                label: Text("عنوان"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                label: Text("متن نظر خود را اینجا وارد کنید"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('ذخیره'))),
          ],
        ),
      ),
    );
  }
}
