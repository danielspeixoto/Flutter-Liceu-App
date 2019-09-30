import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ViewModel.dart';

class CreatePostPage extends StatelessWidget {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, CreatePostViewModel>(
          onInit: (store) => store.dispatch(PageInitAction("CreatePost")),
          converter: (store) => CreatePostViewModel.create(store),
          builder: (BuildContext context, CreatePostViewModel viewModel) {
            return LiceuPage(
              actions: <Widget>[
                FlatButton(
                  onPressed: viewModel.onPostSubmitted == null
                      ? null
                      : () => viewModel.onPostSubmitted(inputController.text),
                  child: new Icon(
                    FontAwesomeIcons.shareSquare,
                    color: Colors.black,
                  ),
                ),
              ],
              title: "Resumo",
              body: FetcherWidget(
                isLoading: viewModel.isLoading,
                child: () => SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(8),
                          child: Theme(
                              data: new ThemeData(
                                  primaryColor: Colors.red,
                                  accentColor: Colors.orange,
                                  hintColor: Colors.green),
                              child: TextField(
                                controller: inputController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0.1,
                                    ),
                                  ),
                                  hintText: "Comece a escrever um resumo",
                                ),
                                minLines: null,
                                maxLines: 9,
                                keyboardType: TextInputType.multiline,
                              ))),
                      Container(
                        child: Text(
                          viewModel.createPostTextErrorMessage,
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
}
