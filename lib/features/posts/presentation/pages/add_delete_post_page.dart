import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/snackbar.dart';
import 'package:flutter_clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_posts/add_delete_posts_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/pages/postsPage.dart';

import '../widgets/add_update_post_page/form_widget.dart';

class AddDeletePostPage extends StatelessWidget {
  const AddDeletePostPage({super.key, required this.isUpdatePost, this.post});

  final bool isUpdatePost;
  final Post? post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePost ? 'Update Post' : 'Add post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: BlocConsumer<AddDeletePostsBloc, AddDeletePostsState>(
            listener: (ctx, state) {
              if (state is MessageAddDeletePostsState) {
                SnackBarWidget.snackBarSuccess(
                  message: state.message,
                  ctx: context,
                );
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                    (route) => false);
              } else if (state is FailureAddDeletePostsState) {
                SnackBarWidget.snackBarFailure(
                  message: state.message,
                  ctx: context,
                );
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                        (route) => false);
              }
            },
            builder: (ctx, state) {
              if (state is LoadingAddDeletePostsState) {
                return const LoadingWidget();
              }
              return FormWidget(
                  isUpdate: isUpdatePost, post: isUpdatePost ? post : null);
            },
          ),
        ),
      ),
    );
  }
}
