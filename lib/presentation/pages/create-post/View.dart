import 'package:app/presentation/widgets/LiceuPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../injection.dart';
import '../../../redux.dart';
import 'ViewModel.dart';

class CreatePostPage extends StatelessWidget {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, CreatePostViewModel>(
          converter: (store) =>
              CreatePostViewModel.create(store, createPostUseCase),
          builder: (BuildContext context, CreatePostViewModel viewModel) {
            return LiceuPage(
              actions: <Widget>[
                FlatButton(
                  onPressed: () =>
                      viewModel.onPostSubmitted(inputController.text),
                  child: new Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                ),
              ],
              title: "Escreva seu post",
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
