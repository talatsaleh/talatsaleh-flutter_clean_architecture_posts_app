import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';

class PostDetailsWidget extends StatelessWidget {
  const PostDetailsWidget({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          post.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(),
        const SizedBox(
          height: 15,
        ),
        Text(
          post.body,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
