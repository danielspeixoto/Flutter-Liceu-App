import 'package:app/presentation/pages/intro/ViewModel.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

List<Slide> slides = [
  new Slide(
    title: "Bem vindo ao Liceu",
    styleTitle: TextStyle(
        color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
    description:
        "Preparado para estudar de uma forma dinâmica e divertida? Vamos lá!",
    pathImage: "assets/liceu-logo.png",
    backgroundColor: Color(0xFF0061A1),
  ),
  new Slide(
    title: "Desafie seus amigos",
    styleTitle: TextStyle(
        color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
    description:
        "Corra contra o tempo para responder perguntas de diversos assuntos. Quem acertar mais, é o grande vencedor!",
    pathImage: "assets/swords-icon.png",
    backgroundColor: Color(0xFF0061A1),
  ),
  new Slide(
    title: "Treine para o Enem",
    styleTitle: TextStyle(
        color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
    description:
        "Você pode praticar para o Enem e entender a resolução das questões através de vídeos! ",
    pathImage: "assets/learning-icon.png",
    backgroundColor: Color(0xFF0061A1),
  ),
  new Slide(
    title: "Dispute com a galera",
    styleTitle: TextStyle(
        color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
    description:
        "Jogue o Torneio Enem e fique entre os melhores do Ranking Mensal!",
    pathImage: "assets/trophy-icon.png",
    backgroundColor: Color(0xFF0061A1),
  ),
  new Slide(
    title: "Descubra resumos",
    styleTitle: TextStyle(
        color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
    description:
        "Explore conteúdos criados para auxiliar nos estudos, e crie seu próprio resumo!",
    pathImage: "assets/explore-icon.png",
    backgroundColor: Color(0xFF0061A1),
  ),
];

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, IntroViewModel>(
          onInit: (store) => store.dispatch(PageInitAction("Intro")),
          converter: (store) => IntroViewModel.create(store),
          builder: (BuildContext context, IntroViewModel viewModel) {
            return new IntroSlider(
              slides: slides,
              onDonePress: viewModel.onDoneOrSkipButtonPressed,
              onSkipPress: viewModel.onDoneOrSkipButtonPressed,
              renderNextBtn: Icon(
                Icons.navigate_next,
                color: Colors.white,
                size: 35.0,
              ),
              renderSkipBtn: Text("PULAR",
                  key: Key("skipIntro"),
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              renderDoneBtn: Text("ENTRAR",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              colorDot: Colors.white70,
              colorActiveDot: Colors.white,
              sizeDot: 10.0,
            );
          });
}
