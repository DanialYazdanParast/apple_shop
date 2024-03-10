import 'package:apple_shop/data/model/comment.dart';
import 'package:apple_shop/data/repository/comment_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository repository;

  CommentBloc(this.repository) : super(CommentloadingState()) {
    on<CommentInitilzeEvent>((event, emit) async {
      var response = await repository.getComments(event.productId);
      emit(CommentResponseState(response));
    });

    on<CommenPostEvent>((event, emit) async {
      emit(CommentPostloadingState(true));

     await repository.postComments(event.productId, event.comment);

      var response = await repository.getComments(event.productId);
      emit(CommentResponseState(response));
    });
  }
}
