import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuDivider.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:app/presentation/widgets/PostWidget.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:app/presentation/widgets/TextWithLinks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ViewModel.dart';

class ProfilePage extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, ProfileViewModel>(
        onInit: (store) => store.dispatch(PageInitAction("Profile")),
        converter: (store) => ProfileViewModel.create(store),
        builder: (BuildContext context, ProfileViewModel viewModel) {
          final user = viewModel.user.content;
          return LiceuScaffold(
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        launch("https://www.instagram.com/liceu.co");
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.instagram),
                          Text("@liceu.co")
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Editar Perfil'),
                    onTap: viewModel.onEditProfileButtonPressed,
                  ),
                  ListTile(
                    title: Text('Sair desta conta'),
                    onTap: viewModel.onLogoutPressed,
                  ),
                ],
              ),
            ),
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
              child: ListView(
                children: <Widget>[
                  FetcherWidget(
                    isLoading: viewModel.user.isLoading,
                    errorMessage: viewModel.user.errorMessage,
                    child: () => Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: RoundedImage(
                                  pictureURL: user.picURL,
                                  size: 80.0,
                                ),
                                margin: EdgeInsets.all(8),
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
                                    FlatButton(
                                      onPressed:
                                          viewModel.onEditProfileButtonPressed,
                                      child: Text(
                                        "Edite seu perfil",
                                        style: TextStyle(
                                          color: Color(0xFF0061A1),
                                        ),
                                      ),
                                    ),
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
                  LiceuDivider(),
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
                                  Text(
                                      "Você ainda não compartilhou nenhum resumo"),
                                ],
                              ),
                            )
                          : Column(
                              children: viewModel.posts.content
                                  .map(
                                    (post) => PostWidget(
                                      user: viewModel.user.content,
                                      postContent: post.text,
                                      onSharePressed: () {
                                        viewModel.onSharePostPressed(
                                          post.id,
                                          post.type,
                                          post.text,
                                        );
                                      },
                                      onDeletePressed: () => viewModel
                                          .onDeletePostPressed(post.id),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
