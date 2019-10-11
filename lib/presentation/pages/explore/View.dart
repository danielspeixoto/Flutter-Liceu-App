import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/util/text.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:app/presentation/widgets/PostWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ViewModel.dart';

class ExplorePage extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, ExploreViewModel>(
        onInit: (store) => store.dispatch(PageInitAction("Explore")),
        converter: (store) => ExploreViewModel.create(store),
        builder: (BuildContext context, ExploreViewModel viewModel) {
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
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Text(
                      "Veja o que o Liceu tem pra você se preparar para o dia de hoje!",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Text(
                      "Atualize a página pra trocar o conteúdo escolhido!",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FetcherWidget(
                    isLoading: viewModel.posts.isLoading,
                    errorMessage: viewModel.posts.errorMessage,
                    child: () => Container(
                      child: Column(
                        children: viewModel.posts.content.map(
                          (post) {
                            return Column(children: <Widget>[
                              PostWidget(
                                user: post.user,
                                postContent: summarize(post.text, 600),
                                onUserPressed: (user) =>
                                    viewModel.onUserPressed(user),
                                onSharePressed: () {
                                  viewModel.onSharePostPressed(
                                    post.id,
                                    post.type,
                                    post.text,
                                  );
                                },
                                onDeletePressed: user.id == post.user.id
                                    ? () =>
                                        viewModel.onDeletePostPressed(post.id)
                                    : null,
                                imageURL: post.imageURL,
                                seeMore: post.text.length > 600
                                  ? FlatButton(
                                      onPressed: () =>
                                          viewModel.onSeeMorePressed(post),
                                      child: Text(
                                        "Ver mais",
                                        style: TextStyle(
                                          color: Color(0xFF0061A1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))
                                  : null,
                              ),
                              
                            ]);
                          },
                        ).toList(),
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
