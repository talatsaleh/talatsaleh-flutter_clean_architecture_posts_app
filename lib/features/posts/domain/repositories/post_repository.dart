import 'package:flutter_clean_architecture_posts_app/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';

abstract class PostRepository {
  ResultFuture<List<Post>> getAllPosts();

  ResultVoid updatePost({required Post post});

  ResultVoid deletePost({required int id});

  ResultVoid addPost(Post post);
}
