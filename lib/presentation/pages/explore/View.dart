import 'dart:math';

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

List<String> tips = [
  "Atualize a página pra trocar o conteúdo escolhido!",
  "Clique nas imagens para dar um zoom!"
];

class ExplorePage extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  final randomTip = tips[new Random().nextInt(tips.length)];

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
              child: FetcherWidget.build(
                isLoading: viewModel.posts.isLoading,
                errorMessage: viewModel.posts.errorMessage,
                child: () => ListView.builder(
                  itemCount: viewModel.posts.content.length,
                  itemBuilder: (ctx, idx) {
                    final post = viewModel.posts.content[idx];
                    return PostWidget(
                      user: post.user,
                      postStatus: post.statusCode,
                      postContent: summarize(post.text, 600),
                      likes: post.likes == null ? 0 : post.likes,
                      onUserPressed: (user) => viewModel.onUserPressed(user),
                      onSharePressed: () {
                        viewModel.onSharePostPressed(
                          post.id,
                          post.type,
                          post.text,
                        );
                      },
                      onDeletePressed: user.id == post.user.id
                          ? () => viewModel.onDeletePostPressed(post.id)
                          : null,
                      imageURL: post.imageURL,
                      seeMore: post.text.length > 600
                          ? FlatButton(
                              onPressed: () => viewModel.onSeeMorePressed(post),
                              child: Text(
                                "Ver mais",
                                style: TextStyle(
                                  color: Color(0xFF0061A1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                          : null,
                      onImageZoomPressed: () {
                        viewModel.onImageZoomPressed(post.imageURL);
                      },
                      onReportTextChange: (text) {
                        viewModel.onReportTextChange(text);
                      },
                      onReportPressed: () {
                        viewModel.onReportPressed(
                            runtimeType.toString(),
                            MediaQuery.of(context).size.width.toString(),
                            MediaQuery.of(context).size.height.toString(),
                            post.user.id,
                            post.user.name,
                            post.id,
                            post.type.toString());
                      },
                      onLikePressed: () {
                        viewModel.onLikePressed(post.id);
                        post.likes++;
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
}
