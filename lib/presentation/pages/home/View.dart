import 'package:app/presentation/reducers/user/Presenter.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:app/presentation/widgets/PostWidget.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:app/presentation/widgets/TextWithLinks.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../redux.dart';
import 'ViewModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class HomePage extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, HomeViewModel>(
      onInit: (store) {
        store.dispatch(FetchMyInfoAction());
        store.dispatch(FetchMyPostsAction());
      },
      converter: (store) => HomeViewModel.create(store),
      builder: (BuildContext context, HomeViewModel viewModel) {
        final user = viewModel.user.content;
        return LiceuScaffold(
          selectedIdx: 0,
          leading: FlatButton(
            onPressed: viewModel.onCreateButtonPressed,
            child: new Icon(
              FontAwesomeIcons.edit,
            ),
          ),
          body: SmartRefresher(
            onRefresh: () async {
              viewModel.refresh();
              _refreshController.refreshCompleted();
            },
            controller: _refreshController,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    FetcherWidget(
                      isLoading: viewModel.user.isLoading,
                      errorMessage: viewModel.user.errorMessage,
                      child: () => Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                RoundedImage(
                                  pictureURL: user.picURL,
                                  size: 80.0,
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          user.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        margin: EdgeInsets.all(8),
                                      ),
                                      RaisedButton(
                                        onPressed: viewModel
                                            .onEditProfileButtonPressed,
                                        color: Colors.white,
                                        child: Text(
                                          "Editar Perfil",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            user.instagramProfile != null
                                ? Container(
                                    child: FlatButton(
                                      onPressed: () {
                                        launch("https://www.instagram.com/" +
                                            user.instagramProfile);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Icon(
                                              FontAwesomeIcons.instagram,
                                              size: 18,
                                            ),
                                            margin: EdgeInsets.only(right: 8),
                                          ),
                                          Center(
                                            child: Text(
                                              user.instagramProfile,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            user.bio != null
                                ? Container(
                                    width: double.infinity,
                                    child: TextWithLinks(
                                      text: user.bio,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black54,
                      indent: 32,
                      endIndent: 32,
                    ),
                    FetcherWidget(
                      isLoading:
                          viewModel.posts.isLoading || viewModel.user.isLoading,
                      errorMessage: viewModel.posts.errorMessage,
                      child: () => Container(
                        child: viewModel.posts.content.length == 0
                            ? Container(
                                margin: EdgeInsets.all(16),
                                child: Column(
                                  children: <Widget>[
                                    Text("Você ainda não tem nenhuma postagem"),
                                  ],
                                ),
                              )
                            : Column(
                                children: viewModel.posts.content
                                    .map((post) => PostWidget(
                                          user.name,
                                          user.picURL,
                                          post.text,
                                        ))
                                    .toList(),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
