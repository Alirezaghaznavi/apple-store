part of 'comment-bloc.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentResponseState extends CommentState {
  Either<String, List<Comment>> comments;
  CommentResponseState(this.comments);
}

class CommentPostLoadingState extends CommentState {
  bool isLoading;
  CommentPostLoadingState(this.isLoading);
}


// if want to show dialog affter posting comment use it
class CommentPostResponseState extends CommentState {
  Either<String, String> response;
  CommentPostResponseState(this.response);
}
