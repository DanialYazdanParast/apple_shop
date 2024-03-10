part of 'comment_bloc.dart';

abstract class CommentState {}

class CommentloadingState extends CommentState {}

class CommentResponseState extends CommentState {
  Either<String, List<Comment>> response;
  CommentResponseState(this.response);
}

class CommentPostloadingState extends CommentState {
  bool isLoding;
  CommentPostloadingState(this.isLoding);
}


class CommentPostResponseState extends CommentState {
  Either<String, String> response;
  CommentPostResponseState(this.response);
}