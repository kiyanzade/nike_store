import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/ui/product/comment/bloc/comment_list_bloc.dart';
import 'package:nike_store/ui/widgets/errorRefresh.dart';

import '../../../data/comment.dart';
import '../../../data/repo/comment_repository.dart';

class CommentList extends StatelessWidget {
  final int productId;

  const CommentList({super.key, required this.productId});
  @override
  Widget build(Object context) {
    return BlocProvider(
      create: (context) {
        final bloc = CommentListBloc(
          commentRepository: commentRepository,
          productId: productId,
        );
        bloc.add(CommentListStartedEvent());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListSuccessState) {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return CommentItem(comment: state.comments[index]);
              }, childCount: state.comments.length),
            );
          } else if (state is CommentListLoadingState) {
            return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is CommentListErrorState) {
            return SliverToBoxAdapter(
                child: AppErrorWidget(
                    exception: state.exception,
                    onPressed: () {
                      BlocProvider.of<CommentListBloc>(context)
                          .add(CommentListStartedEvent());
                    }));
          } else {
            throw Exception('state is not supported.');
          }
        },
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final Comment comment;
  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
          borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.title),
                  Text(comment.email,
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
              Text(
                comment.date,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(comment.content),
        ],
      ),
    );
  }
}
