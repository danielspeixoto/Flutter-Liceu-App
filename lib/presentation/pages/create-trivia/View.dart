import 'package:app/presentation/pages/create-trivia/ViewModel.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuPage.dart';
import 'package:app/presentation/widgets/TextFieldHighlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  FontAwesomeIcons.shareSquare,
                  color: Colors.black,
                ),
              ),
            ],
            title: "Criar Questão",
            body: FetcherWidget.build(
                isLoading: viewModel.isCreatingTrivia,
                child: () => SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Pergunta",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          margin: EdgeInsets.all(8),
                                          child: TextFieldHighlight(
                                            onChanged: (text) {
                                              viewModel
                                                  .onQuestionTextChanged(text);
                                            },
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                  FontAwesomeIcons.question),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 0.1,
                                                ),
                                              ),
                                              hintText:
                                                  "Ex: Em qual bioma se passa o Rei Leão?",
                                            ),
                                            maxLines: 3,
                                            keyboardType:
                                                TextInputType.multiline,
                                            capitalization:
                                                TextCapitalization.sentences,
                                          )),
                                      viewModel.question != null
                                          ? Container(
                                              margin: EdgeInsets.all(4),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  viewModel.question.length
                                                          .toString() +
                                                      "/200",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600])),
                                            )
                                          : Container(
                                              margin: EdgeInsets.all(4),
                                              child: Text("0/200",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600])),
                                            ),
                                      Container(
                                          child: Text(
                                        viewModel
                                            .createTriviaQuestionErrorMessage,
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Resposta Certa",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        child: TextFieldHighlight(
                                          onChanged: (text) {
                                            viewModel
                                                .onCorrectAnswerTextChanged(
                                                    text);
                                          },
                                          borderHighlightColor:
                                              Colors.green[400],
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(FontAwesomeIcons.check),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 0.1,
                                              ),
                                            ),
                                            hintText: "Ex: Savana",
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          capitalization:
                                              TextCapitalization.sentences,
                                        ),
                                      ),
                                      viewModel.correctAnswer != null
                                          ? Container(
                                              margin: EdgeInsets.all(4),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  viewModel.correctAnswer.length
                                                          .toString() +
                                                      "/200",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600])),
                                            )
                                          : Container(
                                              margin: EdgeInsets.all(4),
                                              child: Text("0/200",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600])),
                                            ),
                                      Container(
                                          child: Text(
                                        viewModel
                                            .createTriviaCorrectAnswerErrorMessage,
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Resposta Errada",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        child: TextFieldHighlight(
                                          onChanged: (text) {
                                            viewModel
                                                .onWrongAnswerTextChanged(text);
                                          },
                                          borderHighlightColor: Colors.red[400],
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(FontAwesomeIcons.times),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 0.1,
                                              ),
                                            ),
                                            hintText: "Ex: Caatinga",
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          capitalization:
                                              TextCapitalization.sentences,
                                        ),
                                      ),
                                      viewModel.wrongAnswer != null
                                          ? Container(
                                              margin: EdgeInsets.all(4),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  viewModel.wrongAnswer.length
                                                          .toString() +
                                                      "/200",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600])),
                                            )
                                          : Container(
                                              margin: EdgeInsets.all(4),
                                              alignment: Alignment.centerRight,
                                              child: Text("0/200",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600])),
                                            ),
                                      Container(
                                          child: Text(
                                        viewModel
                                            .createTriviaWrongAnswerErrorMessage,
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      )),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                        child: Text(
                                          'Qual o assunto da sua pergunta?',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8)),
                                    DropdownButton<String>(
                                      value: viewModel.domain,
                                      icon: Icon(
                                        Icons.add,
                                        size: 16,
                                      ),
                                      iconSize: 24,
                                      iconEnabledColor: Colors.black,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.black),
                                      onChanged: (String value) {
                                        viewModel.onTriviaDomainChanged(value);
                                      },
                                      items: <String>[
                                        'Selecione',
                                        'Matemática',
                                        'Naturais',
                                        'Humanas',
                                        'Linguagens'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    Container(
                                        child: Text(
                                      viewModel
                                          .createTriviaDomainNullErrorMessage,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom))
                        ],
                      ),
                    )));
      });
}
