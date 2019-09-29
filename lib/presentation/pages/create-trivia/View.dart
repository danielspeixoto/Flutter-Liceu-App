import 'package:app/presentation/pages/create-trivia/ViewModel.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuPage.dart';

class CreateTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState,
          CreateTriviaViewModel>(
      onInit: (store) => store.dispatch(PageInitAction("CreateTrivia")),
      converter: (store) => CreateTriviaViewModel.create(store),
      builder: (BuildContext context, CreateTriviaViewModel viewModel) {
        return LiceuPage(
            actions: <Widget>[
              FlatButton(
                onPressed: viewModel.onCreateTriviaButtonPressed == null
                    ? null
                    : () => viewModel.onCreateTriviaButtonPressed(),
                child: new Icon(
                  FontAwesomeIcons.penAlt,
                  color: Colors.black,
                ),
              ),
            ],
            title: "Criar Questão",
            body: FetcherWidget(
                isLoading: viewModel.isCreatingTrivia,
                child: () => SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                  child: Text('Selecione uma tag: '),
                                  margin: EdgeInsets.all(4)),
                              DropdownButton<String>(
                                value: viewModel.domain,
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String value) {
                                  viewModel.onTriviaDomainChanged(value);
                                },
                                items: <String>[
                                  'Selecione',
                                  'Matemática',
                                  'Naturais',
                                  'Humanas',
                                  'Linguagens'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          Container(
                              child: Text(
                            viewModel.createTriviaDomainNullError,
                            style: TextStyle(color: Colors.redAccent),
                          )),
                          Container(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: TextField(
                                    onChanged: (text) {
                                      viewModel.onQuestionTextChanged(text);
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(FontAwesomeIcons.question),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.1,
                                        ),
                                      ),
                                      hintText: "Pergunta",
                                    ),
                                    minLines: null,
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.all(8),
                                    child: TextField(
                                      onChanged: (text) {
                                        viewModel
                                            .onCorrectAnswerTextChanged(text);
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            Icon(FontAwesomeIcons.check),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.1,
                                          ),
                                        ),
                                        hintText: "Resposta certa",
                                      ),
                                      keyboardType: TextInputType.multiline,
                                    )),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: TextField(
                                    onChanged: (text) {
                                      viewModel.onWrongAnswerTextChanged(text);
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(FontAwesomeIcons.times),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.1,
                                        ),
                                      ),
                                      hintText: "Resposta errada",
                                    ),
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )));
      });
}
