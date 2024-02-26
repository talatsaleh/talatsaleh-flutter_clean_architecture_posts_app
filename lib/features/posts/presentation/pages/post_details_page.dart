import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/snackbar.dart';
import 'package:flutter_clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_posts/add_delete_posts_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/pages/add_delete_post_page.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/pages/postsPage.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/widgets/post_details_widgets/post_delete_widget.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/widgets/post_details_widgets/post_details_widget.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/widgets/post_details_widgets/post_update_widget.dart';

import '../../domain/entities/post.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        actions: [
          PostDeleteWidget(
            postId: post.id!,
          ),
        ],
      ),
      floatingActionButton: PostUpdateWidget(post: post),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailsWidget(
          post: post,
        ),
      ),
    );
  }
}
