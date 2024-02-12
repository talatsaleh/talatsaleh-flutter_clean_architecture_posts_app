import 'package:flutter_clean_architecture_posts_app/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/repositories/post_repository.dart';

class GetAllPostsUseCase extends UseCaseWithoutPrams<List<Post>> {
  const GetAllPostsUseCase(this._repository);

  final PostRepository _repository;

  @override
  ResultFuture<List<Post>> call() async => _repository.getAllPosts();
}
