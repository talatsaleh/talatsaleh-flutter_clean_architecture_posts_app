import 'package:flutter_clean_architecture_posts_app/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/repositories/post_repository.dart';

class DeletePostUseCase extends UseCaseWithPrams<void, int> {
  const DeletePostUseCase(this._repository);

  final PostRepository _repository;

  @override
  ResultVoid call(int prams) async =>
      _repository.deletePost(id: prams);
}
