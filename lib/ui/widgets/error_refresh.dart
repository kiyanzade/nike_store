
import 'package:flutter/material.dart';

import '../../common/exceptions.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException exception;
  final Function() onPressed;
  const AppErrorWidget({
    super.key,
    required this.exception,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Text(exception.message),
          TextButton(onPressed: onPressed, child: const Text('تلاش مجدد'))
        ],
      ),
    );
  }
}
