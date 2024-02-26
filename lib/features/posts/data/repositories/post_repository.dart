import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts_app/core/errors/exptiones.dart';
import 'package:flutter_clean_architecture_posts_app/core/errors/failure.dart';
import 'package:flutter_clean_architecture_posts_app/core/network/network_info.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/repositories/post_repository.dart';

import '../datasource/post_local_data_source.dart';
import '../datasource/post_remote_data_source.dart';

class PostRepositoryImp extends PostRepository {
  PostRepositoryImp(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfoImp});

  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfoImp;

  @override
  ResultVoid addPost(Post post) async {
    return await _resultVoid(() => remoteDataSource.addPost(post));
  }

  @override
  ResultVoid deletePost({required int id}) async {
    return await _resultVoid(() => remoteDataSource.deletePost(id));
  }

  @override
  ResultFuture<List<Post>> getAllPosts() async {
    if (await networkInfoImp.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts as List<PostModel>);
        return Right(remotePosts);
      } on ServerException {
        return const Left(ServerFailure(statusCode: 1, message: ''));
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return const Left(EmptyCacheFailure(statusCode: 2, message: ''));
      }
    }
  }

  @override
  ResultVoid updatePost({required Post post}) async {
    return await _resultVoid(() {
      return remoteDataSource.updatePost(
          PostModel(id: post.id, title: post.title, body: post.body),);
    });
  }

  ResultVoid _resultVoid(Future<Unit> Function() useCase) async {
    if (await networkInfoImp.isConnected) {
      try {
        await useCase();
        return const Right(unit);
      } on ServerException {
        return const Left(
          ServerFailure(message: '', statusCode: 3),
        );
      }
    } else {
      return const Left(OfflineFailure(statusCode: 2, message: ''));
    }
  }
}
