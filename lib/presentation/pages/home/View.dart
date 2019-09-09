import 'package:app/presentation/reducers/user/Presenter.dart';
import 'package:app/presentation/widgets/LiceuWidget.dart';
import 'package:app/presentation/widgets/PostWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../State.dart';
import 'Presenter.dart';
import 'ViewModel.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

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
          2,
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(viewModel.userPic)),
                      ),
                      margin: const EdgeInsets.all(16.0),
                    ),
                    Text(
                      viewModel.userName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  child: Linkify(
                    onOpen: (link) => launch(link.url),
                    text:
                        viewModel.userBio,
                  ),
                  margin: const EdgeInsets.all(8.0),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Editar perfil"),

                  ),
                ),
                Divider(),
                PostWidget(
                    "Daniel Peixoto",
                    "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg",
                    "I'm having a https://www.reddit.com on above code I am displaying a list of items ( total 5) in CustomScrollView. YourRowWidget widget gets rendered 5 times as list item. Generally you should render each row based on some data.You can remove decoration property of Container widget, it is just for providing background image."),
              ],
            ),
          ),
        );
      });
}
