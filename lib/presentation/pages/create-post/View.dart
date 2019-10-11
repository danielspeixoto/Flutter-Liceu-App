import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuPage.dart';
import 'package:app/presentation/widgets/TextFieldHighlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
                  onPressed: viewModel.isLoading
                      ? null
                      : () {
                          viewModel.onPostSubmitted(
                              inputController.text, viewModel.image);
                        },
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
                        child: TextFieldHighlight(
                          controller: inputController,
                          hintTextColor: Colors.black45,
                          borderHighlightColor: Colors.black54,
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
                          capitalization: TextCapitalization.sentences,
                        ),
                      ),
                      Container(
                        child: Text(
                          viewModel.createPostTextErrorMessage,
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      FlatButton(
                        onPressed: () async {
                          viewModel.onImageSet(await ImagePicker.pickImage(
                            source: ImageSource.gallery,
                          ));
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                FontAwesomeIcons.cameraRetro,
                              ),
                            ),
                            Text("Adicione uma imagem"),
                          ],
                        ),
                      ),
                      viewModel.image == null
                          ? Container()
                          : Container(
                              child: Image.file(viewModel.image),
                              margin: EdgeInsets.only(
                                top: 16,
                              ))
                    ],
                  ),
                ),
              ),
            );
          });
}
