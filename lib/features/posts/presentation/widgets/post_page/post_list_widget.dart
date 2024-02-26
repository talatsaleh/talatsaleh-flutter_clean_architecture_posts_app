import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/pages/post_details_page.dart';

import '../../../domain/entities/post.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (ctx, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => PostDetailsPage(
                  post: posts[index],
                ),
              ),
            );
          },
          title: Text(posts[index].title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              posts[index].id.toString(),
            ),
          ),
          subtitle: Text(posts[index].body,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
              )),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        );
      },
      separatorBuilder: (ctx, index) => const Divider(
        thickness: 1,
      ),
      itemCount: posts.length,
    );
  }
}
