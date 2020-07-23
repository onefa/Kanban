import 'package:equatable/equatable.dart';

import '../ap_interface.dart';


abstract class KanbanEvent extends Equatable {
  const KanbanEvent();

  @override
  List<Object> get props => [];
}
class KanbanLoad extends KanbanEvent {
  final Token token;
  KanbanLoad(this.token);
}
class KanbanLoaded extends KanbanEvent {}

class KanbanErrorLoading extends KanbanEvent {}

class KanbanRight extends KanbanEvent {}

class KanbanLeft extends KanbanEvent {}
