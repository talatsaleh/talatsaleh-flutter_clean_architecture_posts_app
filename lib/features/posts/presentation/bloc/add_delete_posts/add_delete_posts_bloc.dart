import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_posts_app/core/strings/failure/messages.dart';
import 'package:flutter_clean_architecture_posts_app/core/strings/messages/messages.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

part 'add_delete_posts_event.dart';

part 'add_delete_posts_state.dart';

class AddDeletePostsBloc
    extends Bloc<AddDeletePostsEvent, AddDeletePostsState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;

  AddDeletePostsBloc(this.addPost, this.updatePost, this.deletePost)
      : super(AddDeletePostsInitial()) {
    on<AddDeletePostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeletePostsState());
        final failureOrDoneMessage = await addPost(event.post);
        emit(
          foldFailureOrDone(failureOrDoneMessage, sAddSuccessMessage),
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeletePostsState());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(
          foldFailureOrDone(failureOrDoneMessage, sUpdateSuccessMessage),
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeletePostsState());
        final failureOrDoneMessage = await deletePost(event.postId);
        emit(
          foldFailureOrDone(failureOrDoneMessage, sDeleteSuccessMessage),
        );
      }
    });
  }

  AddDeletePostsState foldFailureOrDone(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) {
        return FailureAddDeletePostsState(message: _errorMessage(failure));
      },
      (_) {
        return MessageAddDeletePostsState(message: message);
      },
    );
  }

  String _errorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return sServerFailureMessage;
      case OfflineFailure:
        return sOfflineFailureMessage;
      default:
        return 'There is unexpected error..';
    }
  }
}
