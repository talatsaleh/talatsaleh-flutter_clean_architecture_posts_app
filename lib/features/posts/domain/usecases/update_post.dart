import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts_app/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/repositories/post_repository.dart';

class UpdatePostUseCase extends UseCaseWithPrams<Unit, Post> {
  const UpdatePostUseCase(this._repository);

  final PostRepository _repository;

  @override
  ResultVoid call(Post post) async =>
      _repository.updatePost(post: post);
}
