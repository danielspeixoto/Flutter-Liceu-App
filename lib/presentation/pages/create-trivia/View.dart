import 'package:app/presentation/pages/create-trivia/ViewModel.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuPage.dart';
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
<<<<<<< HEAD
                          Row(
                            children: <Widget>[
                              Container(
                                  child: Text('Escolha uma tag: '),
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
=======
>>>>>>> 4dd9d70c56bde522d28b02cfbd7bd1102cba32e7
                          Container(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Container(
<<<<<<< HEAD
                                  margin: EdgeInsets.all(8),
                                  child: Theme(
                                      data: new ThemeData(
                                          primaryColor: Colors.black54,
                                          hintColor: Colors.black45),
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
                                      )),
                                ),
                                Container(
                                    margin: EdgeInsets.all(8),
                                    child: Theme(
                                        data: new ThemeData(
                                            primaryColor: Colors.green[400],
                                            hintColor: Colors.black45),
                                        child: TextField(
                                          onChanged: (text) {
                                            viewModel
                                                .onCorrectAnswerTextChanged(
                                                    text);
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(FontAwesomeIcons.check),
=======
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
                                        child: TextField(
                                          onChanged: (text) {
                                            viewModel
                                                .onQuestionTextChanged(text);
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(FontAwesomeIcons.question),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 0.1,
                                              ),
                                            ),
                                            hintText:
                                                "Em qual bioma se passa o Rei Leão?",
                                          ),
                                          minLines: null,
                                          maxLines: 3,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                      ),
                                      viewModel.question != null
                                          ? Container(
                                              margin: EdgeInsets.all(4),
                                              child: Text(viewModel
                                                      .question.length
                                                      .toString() +
                                                  "/200"),
                                            )
                                          : Container(
                                              margin: EdgeInsets.all(4),
                                              child: Text("0/200"),
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
                                          child: TextField(
                                            onChanged: (text) {
                                              viewModel
                                                  .onCorrectAnswerTextChanged(
                                                      text);
                                            },
                                            decoration: InputDecoration(
                                              prefixIcon:
                                                  Icon(FontAwesomeIcons.check),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 0.1,
                                                ),
                                              ),
                                              hintText: "Savana",
                                            ),
                                            keyboardType:
                                                TextInputType.multiline,
                                          )),
                                      viewModel.correctAnswer != null
                                          ? Container(
                                              margin: EdgeInsets.all(4),
                                              child: Text(viewModel
                                                      .correctAnswer.length
                                                      .toString() +
                                                  "/200"),
                                            )
                                          : Container(
                                              margin: EdgeInsets.all(4),
                                              child: Text("0/200"),
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
                                        child: TextField(
                                          onChanged: (text) {
                                            viewModel
                                                .onWrongAnswerTextChanged(text);
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(FontAwesomeIcons.times),
>>>>>>> 4dd9d70c56bde522d28b02cfbd7bd1102cba32e7
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 0.1,
                                              ),
                                            ),
<<<<<<< HEAD
                                            hintText: "Resposta certa",
                                          ),
                                          keyboardType: TextInputType.multiline,
                                        ))),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Theme(
                                      data: new ThemeData(
                                          primaryColor: Colors.red[400],
                                          hintColor: Colors.black45),
                                      child: TextField(
                                        onChanged: (text) {
                                          viewModel
                                              .onWrongAnswerTextChanged(text);
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              Icon(FontAwesomeIcons.times),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 0.1,
                                            ),
                                          ),
                                          hintText: "Resposta errada",
                                        ),
                                        keyboardType: TextInputType.multiline,
                                      )),
=======
                                            hintText: "Caatinga",
                                          ),
                                          keyboardType: TextInputType.multiline,
                                        ),
                                      ),
                                      viewModel.wrongAnswer != null
                                          ? Container(
                                              margin: EdgeInsets.all(4),
                                              child: Text(viewModel
                                                      .wrongAnswer.length
                                                      .toString() +
                                                  "/200"),
                                            )
                                          : Container(
                                              margin: EdgeInsets.all(4),
                                              child: Text("0/200"),
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
>>>>>>> 4dd9d70c56bde522d28b02cfbd7bd1102cba32e7
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )));
      });
}
