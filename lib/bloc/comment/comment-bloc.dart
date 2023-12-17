import 'package:apple_store/data/model/comment.dart';
import 'package:apple_store/data/repository/comment-repository.dart';
import 'package:apple_store/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'comment-event.dart';
part 'comment-state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository _commentRepository = locatore.get();
  CommentBloc() : super(CommentLoadingState()) {
    on<CommentInitialRequestEvent>((event, emit) async {
      var comments = await _commentRepository.getComments(event.productId);
      emit(CommentResponseState(comments));
    });
    on<CommentPostEvent>((event, emit) async {
      emit(CommentPostLoadingState(true));
      var postResult = await _commentRepository.postComments(
          event.productId, '', event.comment);
      emit(CommentPostLoadingState(false));
      emit(CommentLoadingState());
      var comments = await _commentRepository.getComments(event.productId);
      emit(CommentResponseState(comments));
      emit(CommentPostResponseState(postResult));
    });
  }
}
