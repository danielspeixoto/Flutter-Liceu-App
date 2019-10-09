import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/util/text.dart';
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

import 'ViewModel.dart';

class FriendPage extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, FriendViewModel>(
        onInit: (store) => store.dispatch(PageInitAction("Friend")),
        converter: (store) => FriendViewModel.create(store),
        builder: (BuildContext context, FriendViewModel viewModel) {
          final user = viewModel.user.content;
          return LiceuScaffold(
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
                                  pictureURL:
                                      user.picURL != null ? user.picURL : null,
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
                                      onPressed: () => viewModel
                                          .onChallengeMePressed(user.id),
                                      child: Text(
                                        "Me desafie!",
                                        style: TextStyle(
                                          color: Color(0xFF0061A1),
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
                                      viewModel.onInstagramPressed();
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
                                    "${viewModel.user.content.name} ainda não compartilhou nenhum resumo",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: viewModel.posts.content.map((post) {
                                return Column(children: <Widget>[
                                  PostWidget(
                                    user: user,
                                    postContent: summarize(post.text, 600),
                                    onSharePressed: () {
                                      viewModel.onSharePostPressed(
                                        post.id,
                                        post.type,
                                        post.text,
                                      );
                                    },
                                    imageURL: post.imageURL,
                                    seeMore: post.text.length > 600 ? FlatButton(
                                      onPressed: () =>
                                          viewModel.onSeeMorePressed(post, user),
                                      child: Text(
                                        "Ver mais",
                                        style: TextStyle(
                                          color: Color(0xFF0061A1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))
                                  : null
                                  ),
                                    
                                  
                                ]);
                              }).toList(),
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
