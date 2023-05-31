import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/ui/product/comment/insert/bloc/insert_commnet_bloc.dart';

import '../../../../data/repo/comment_repository.dart';

class InsertCommentDialog extends StatefulWidget {
  final int productId;
  const InsertCommentDialog({super.key, required this.productId});

  @override
  State<InsertCommentDialog> createState() => _InsertCommentDialogState();
}

class _InsertCommentDialogState extends State<InsertCommentDialog> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  StreamSubscription? subscription;

  _InsertCommentDialogState();

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InsertCommnetBloc>(
      create: (context) {
        final bloc = InsertCommnetBloc(commentRepository, widget.productId);
        bloc.stream.listen((state) {
          if (state is InsertCommnetError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.appException.message)));
            Navigator.of(context).pop();
          } else if (state is InsertCommnetSuccess) {
            Navigator.of(context).pop();
          }
        });

        return bloc;
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        child: Container(
          height: 900,
          child: BlocBuilder<InsertCommnetBloc, InsertCommnetState>(
            builder: (context, state) {
              return Column(
                children: [
                  Text(
                    "ثبت نظر",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _labelController,
                    decoration: const InputDecoration(
                      label: Text("عنوان"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      label: Text("متن نظر خود را اینجا وارد کنید"),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<InsertCommnetBloc>(context).add(
                            InsertCommnetSubmittedEvent(_labelController.text,
                                _contentController.text, widget.productId));
                      },
                      child: state is InsertCommnetLoading
                          ? CupertinoActivityIndicator()
                          : Text('ذخیره'),
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size.fromHeight(56))),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
