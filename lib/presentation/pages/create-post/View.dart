import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../Injection.dart';
import '../../../State.dart';
import 'ViewModel.dart';

class CreatePostPage extends StatelessWidget {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, CreatePostViewModel>(
          converter: (store) =>
              CreatePostViewModel.create(store, createPostUseCase),
          builder: (BuildContext context, CreatePostViewModel viewModel) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                centerTitle: true,
                elevation: 1.0,
                actions: <Widget>[
                  FlatButton(
                    onPressed: () =>
                        viewModel.onPostSubmitted(inputController.text),
                    child: new Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                ],
                title: Text("Escreva seu post"),
              ),
              body: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextField(
                      controller: inputController,
                      onSubmitted: viewModel.onPostSubmitted,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              "Clique aqui para começar à escrever seu post."),
                      minLines: null,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
            );
          });
}
