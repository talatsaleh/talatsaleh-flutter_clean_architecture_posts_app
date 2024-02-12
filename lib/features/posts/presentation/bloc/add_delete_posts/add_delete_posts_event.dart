part of 'add_delete_posts_bloc.dart';

@immutable
abstract class AddDeletePostsEvent extends Equatable {}

class AddPostEvent extends AddDeletePostsEvent {
  final Post post;

  AddPostEvent({required this.post});

  @override
  List<Object?> get props => [post];

}
class UpdatePostEvent extends AddDeletePostsEvent {
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  List<Object?> get props => [post];

}


class DeletePostEvent extends AddDeletePostsEvent {
  final String postId;

  DeletePostEvent({required this.postId});

  @override
  List<Object?> get props => [postId];

}
