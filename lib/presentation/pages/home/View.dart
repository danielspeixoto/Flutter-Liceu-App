import 'package:app/presentation/reducers/user/Presenter.dart';
import 'package:app/presentation/widgets/LiceuWidget.dart';
import 'package:app/presentation/widgets/PostWidget.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:app/presentation/widgets/TextWithLinks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../State.dart';
import 'ViewModel.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, HomeViewModel>(
      onInit: (store) => store.dispatch(GetProfileAction()),
      converter: (store) => HomeViewModel.create(store),
      builder: (BuildContext context, HomeViewModel viewModel) {
        return Liceu(
          selectedIdx: 0,
          leading: FlatButton(
            onPressed: viewModel.onCreateButtonPressed,
            child: new Icon(
              Icons.create,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    RoundedImage(pictureURL: viewModel.userPic, size: 80.0),
                    Text(
                      viewModel.userName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  child: TextWithLinks(
                    text: viewModel.userBio,
                  ),
                  margin: const EdgeInsets.all(8.0),
                ),
                Divider(),
                PostWidget(
                    "Daniel Peixoto",
                    "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg",
                    "*MORAL*\nvalores, costumes e regras adquiridas pela sociedade a partir de sua convivência em uma certa época e espaço.\n- Não existe moral própria. Você será moral ou imoral diante dos padrões da sociedade.\n- É um juízo de calor\n- Moral absoluta: Ex.: Pena se morte no Brasil\n-Moral relativa: Ex.: Pena de morte nos EUA (relativamente errado dependendo do estado)\n\nÉTICA\nTrabalha com as morais. Estuda quais delas são melhores pra sociedade.\n- É unicersal\n- Antiético: qualquer valor moral que prejudica o humano."),
              ],
            ),
          ),
        );
      });
}
