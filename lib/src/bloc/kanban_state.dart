import 'package:equatable/equatable.dart';

class KanbanState extends Equatable {
  @override
  List<Object> get props => [];
}

class KanbanNotReady extends KanbanState {}

class KanbanReady extends KanbanState {}

class KanbanRedraw extends KanbanState {}
