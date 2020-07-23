import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ap_interface.dart';
import '../kanban.dart';
import 'kanban_event.dart';
import 'kanban_state.dart';


class KanbanBloc extends Bloc<KanbanEvent, KanbanState> {
  KanbanBloc(): super(KanbanNotReady());

  APInterface apInterface = APInterface();
  KanbanLists lists = KanbanLists();

  @override
  Stream<KanbanState> mapEventToState(KanbanEvent event) async* {

    if (event is KanbanLoad) {
      sendRequest(event.token);
    }

    if (event is KanbanLoaded) {
      yield KanbanReady();
    }

    if (event is KanbanErrorLoading) {
    }

    if (event is KanbanLeft) {
      switch (lists.listIndex) {
        case '0' : lists.listIndex = '1'; break;
        case '1' : lists.listIndex = '2'; break;
        case '2' : lists.listIndex = '3'; break;
        case '3' : break;
      }
      yield KanbanRedraw();
    }

    if (event is KanbanRight) {
      switch (lists.listIndex) {
        case '3' : lists.listIndex = '2'; break;
        case '2' : lists.listIndex = '1'; break;
        case '1' : lists.listIndex = '0'; break;
        case '3' : break;
      }
      yield KanbanRedraw();
    }

  }

  sendRequest(Token token) async {
    List<dynamic> cardsFull = await apInterface.getCards(token);
    if (cardsFull != null) {
      if (cardsFull.removeAt(0) == 'ok') {
        cardsFull.forEach((element) {
          Map<String, dynamic> card = element;
          List<int> cardsUTF = [];
          String toSplit = element['text'];
          cardsUTF.addAll(toSplit.codeUnits);
          lists.list[card['row']].add(utf8.decode(cardsUTF));
          lists.listIndex = '0';
          add(KanbanLoaded());
        });
      } else {
        add(KanbanErrorLoading());
      }
    }
  }

}
