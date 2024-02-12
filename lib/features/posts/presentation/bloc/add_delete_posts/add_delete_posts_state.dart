part of 'add_delete_posts_bloc.dart';

@immutable
abstract class AddDeletePostsState extends Equatable {}

class AddDeletePostsInitial extends AddDeletePostsState {
  @override
  List<Object?> get props => [];
}

class LoadingAddDeletePostsState extends AddDeletePostsState {
  @override
  List<Object?> get props => [];
}

class MessageAddDeletePostsState extends AddDeletePostsState {
  final String message;

  MessageAddDeletePostsState({required this.message});

  @override
  List<Object?> get props => [];
}

class FailureAddDeletePostsState extends AddDeletePostsState {
  final String message;

  FailureAddDeletePostsState({required this.message});

  @override
  List<Object?> get props => [message];
}
