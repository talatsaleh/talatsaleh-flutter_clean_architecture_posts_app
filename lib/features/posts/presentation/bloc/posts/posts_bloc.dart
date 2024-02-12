import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_posts_app/core/errors/failure.dart';
import 'package:flutter_clean_architecture_posts_app/core/strings/failure/messages.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/typedef.dart';
import 'package:http/http.dart';
import '../../../domain/usecases/get_all_posts.dart';
import '../../../domain/entities/post.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(PostsLoadingState());
        final posts = await getAllPosts();
        emit(_failureOrPosts(either: posts));
      } else if (event is RefreshPostsEvent) {
        emit(PostsLoadingState());
        final posts = await getAllPosts();
        emit(_failureOrPosts(either: posts));
      }
    });
  }

  PostsState _failureOrPosts({required Either<Failure, List<Post>> either}) {
    return either.fold(
      (failure) {
        return PostsErrorState(message: _errorMessage(failure));
      },
      (posts) {
        return PostsLoadedState(posts: posts);
      },
    );
  }

  String _errorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return sServerFailureMessage;
      case EmptyCacheFailure:
        return sEmptyCacheFailureMessage;
      case OfflineFailure:
        return sOfflineFailureMessage;
      default:
        return 'There is unexpected error..';
    }
  }
}
