import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/snackbar.dart';
import 'package:flutter_clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_posts/add_delete_posts_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/pages/postsPage.dart';

class PostDeleteWidget extends StatelessWidget {
  final int postId;

  const PostDeleteWidget({super.key, required this.postId});

  void _deletePost(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeletePostsBloc, AddDeletePostsState>(
              builder: (context, state) {
            if (state is LoadingAddDeletePostsState) {
              return const AlertDialog(title:LoadingWidget());
            }
            return AlertDialog(
              title: const Text("Are you sure delete this?"),
              actions: [
                TextButton(
                    onPressed: () {
                      BlocProvider.of<AddDeletePostsBloc>(context)
                          .add(DeletePostEvent(postId: postId));
                    },
                    child: Text(
                      'yes',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    )),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child:
                      Text('No', style: Theme.of(context).textTheme.bodySmall!),
                ),
              ],
            );
          }, listener: (context, state) {
            if (state is MessageAddDeletePostsState) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  (route) => false);
              SnackBarWidget.snackBarSuccess(
                  message: state.message, ctx: context);
            } else if (state is FailureAddDeletePostsState) {
              Navigator.of(context).pop();
              SnackBarWidget.snackBarFailure(
                  message: state.message, ctx: context);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _deletePost(context),
      icon: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
