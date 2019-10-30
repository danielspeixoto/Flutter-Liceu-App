import 'dart:math';

import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/util/text.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/PostWidget.dart';
import 'package:app/presentation/widgets/TextFieldHighlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

          final TextEditingController _controller = TextEditingController(
            text: viewModel.query,
          );
          _controller.selection = TextSelection.fromPosition(
            TextPosition(
              offset: viewModel.query.length,
            ),
          );
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              elevation: 2.0,
              title: Container(
                child: TextFieldHighlight(
                  controller: _controller,
                  onChanged: (text) {
                    viewModel.onQueryTextChanged(text);
                  },
                  inputStyle: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "O que você procura?",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: viewModel.query != null && viewModel.query != ""
                        ? IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              viewModel.onQueryTextChanged("");
                            })
                        : null,
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            body: FetcherWidget.build(
              isLoading: viewModel.posts.isLoading,
              errorMessage: viewModel.posts.errorMessage,
              child: () => ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: viewModel.posts.content.length,
                itemBuilder: (ctx, idx) {
                  final post = viewModel.posts.content[idx];
                  return AnimatedPost(
                    user: post.user,
                    postStatus: post.statusCode,
                    savedPostIcon: post.isSaved
                        ? FontAwesomeIcons.solidBookmark
                        : FontAwesomeIcons.bookmark,
                    postContent: post.type == PostType.TEXT
                        ? summarize(post.text, 600)
                        : '\n'.allMatches(post.text).length + 1 > 15
                            ? summarize(post.text, 30)
                            : summarize(post.text, 200),
                    likes: post.likes == null ? 0 : post.likes,
                    onUserPressed: (user) => viewModel.onUserPressed(user),
                    onSharePressed: () {
                      viewModel.onSharePostPressed(
                        post.id,
                        post.type,
                        post.text,
                      );
                    },
                    images: post.images,
                    onDeletePressed: user.id == post.user.id
                        ? () => viewModel.onDeletePostPressed(post.id)
                        : null,
                    imageURL: post.imageURL,
                    numberOfComments: post.comments.length.toString(),
                    seeMore:
                        post.type == PostType.TEXT && post.text.length > 600 ||
                                post.type == PostType.IMAGE &&
                                    post.text.length > 200
                            ? true
                            : false,
                    onSeeMorePressed: () {
                      viewModel.onSeeMorePressed(post);
                    },
                    onImageZoomPressed: () {
                      viewModel.onImageZoomPressed(post.images);
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
                    onSavePostPressed: (isSaved) {
                      if (isSaved) {
                        viewModel.onDeleteSavedPostPressed(post.id);
                      } else {
                        viewModel.onSavePostPressed(post.id);
                      }
                    },
                  );
                },
              ),
            ),
          );
        },
      );
}
