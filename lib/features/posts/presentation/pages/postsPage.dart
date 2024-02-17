import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/pages/add_delete_post_page.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/post_page/message_display_widget.dart';
import '../widgets/post_page/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const AddDeletePostPage(
                isUpdatePost: false,
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoadingState) {
              return const LoadingWidget();
            } else if (state is PostsLoadedState) {
              return PostListWidget(
                posts: state.posts,
              );
            } else if (state is PostsErrorState) {
              return MessageDisplayWidget(
                message: state.message,
              );
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
