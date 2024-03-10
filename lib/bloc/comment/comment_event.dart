part of 'comment_bloc.dart';

abstract class CommentEvent {}

class CommentInitilzeEvent extends CommentEvent {
  String productId;
  CommentInitilzeEvent(this.productId);
}
class CommenPostEvent extends CommentEvent {
  String productId;
  String comment;
  CommenPostEvent(this.productId,this.comment);
}
