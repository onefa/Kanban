import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ap_interface.dart';
import 'bloc/authentication_bloc.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authentication_state.dart';
import 'bloc/kanban_bloc.dart';
import 'bloc/kanban_event.dart';
import 'bloc/kanban_state.dart';

class KanbanLists {
  String listIndex = '0';
  final Map<String, String>  name = { '0' : 'On hold',
                                             '1' : 'In progress',
                                             '2' : 'Needs review',
                                             '3' : 'Approved'
  };

  Map<String, List> list = {
                        '0':[],
                        '1':[],
                        '2':[],
                        '3':[]
  };

}

class Kanban extends StatefulWidget {
  @override
  _KanbanState createState() => new _KanbanState();
}

class _KanbanState extends State<Kanban> {
  APInterface apInterface = APInterface();
  AuthenticationBloc _authenticationBloc;
  KanbanBloc kanbanBloc = KanbanBloc();

  @override
  void dispose() {
    kanbanBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    AuthenticationAuthenticated state = _authenticationBloc.state;


    kanbanBloc.add(KanbanLoad(state.token));

    return GestureDetector(
            onHorizontalDragEnd: (DragEndDetails dragEndDetails) {
              if (dragEndDetails.primaryVelocity < 0) {kanbanBloc.add(KanbanLeft());}
              if (dragEndDetails.primaryVelocity > 0) {kanbanBloc.add(KanbanRight());}
            },
            child: BlocBuilder<KanbanBloc, KanbanState>(
                    bloc: kanbanBloc,
                    builder: (context, state) {
                      return Scaffold(
                          appBar: AppBar(
                            title: Text(kanbanBloc.lists.name[kanbanBloc.lists.listIndex]),
                            actions: <Widget>[
                              MaterialButton(
                                child: Text('LogOut', style: TextStyle(fontSize: 17),),
                                onPressed: () => _logOut(),
                              ),
                            ],
                          ),
                          body: checkState(state),
                      );
                   }
            ),
    );

  }

  checkState(KanbanState state){
    if (state is KanbanNotReady) {
      return loadList();
    }
    if (state is KanbanRedraw) {
      return cardList();
    }
    if (state is KanbanReady) {
      return cardList();
    }
    return;
 }


  loadList() {
    return Container(
      child: Center(
        child: CircularProgressIndicator()
      ),
    );
  }

  cardList() {
    if (kanbanBloc.state is KanbanRedraw) {
      kanbanBloc.add(KanbanLoaded());
    }
    List<dynamic> listOfCards = kanbanBloc.lists.list[kanbanBloc.lists.listIndex];
    return ListView.builder(
      itemCount: listOfCards == null ? 0 : listOfCards.length,
      itemBuilder: (BuildContext context, int index) {
        return  Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 3),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Colors.greenAccent,
          ),
          child: Text(listOfCards[index], style: TextStyle(fontSize: 17),),
        );
      },
    );
  }

  _logOut() {
    _authenticationBloc.add(UserLoggedOut());
  }

}


