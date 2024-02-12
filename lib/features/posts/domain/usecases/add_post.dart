import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_posts_app/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/repositories/post_repository.dart';

class AddPostUseCase extends UseCaseWithPrams<void, Post> {
  const AddPostUseCase(this._repository);

  final PostRepository _repository;

  @override
  ResultVoid call(Post prams) async => _repository.addPost(prams);
}
