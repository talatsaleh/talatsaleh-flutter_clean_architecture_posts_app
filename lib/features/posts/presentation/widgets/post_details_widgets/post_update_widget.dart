import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';
import '../../pages/add_delete_post_page.dart';

class PostUpdateWidget extends StatelessWidget {
  final Post post;

  const PostUpdateWidget({super.key, required this.post});

  void _editPost(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddDeletePostPage(
          isUpdatePost: true,
          post: post,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _editPost(context),
      child: const Icon(Icons.edit),
    );
  }
}
