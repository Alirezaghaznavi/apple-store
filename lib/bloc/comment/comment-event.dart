part of 'comment-bloc.dart';

abstract class CommentEvent {}

class CommentInitialRequestEvent extends CommentEvent {
  String productId;
  CommentInitialRequestEvent(this.productId);
}

class CommentPostEvent extends CommentEvent {
  String comment;
  String productId;
  CommentPostEvent(this.comment, this.productId);
}
