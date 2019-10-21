import 'package:app/domain/aggregates/Post.dart';
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
              child: FetcherWidget.build(
                isLoading:
                    viewModel.user.isLoading || viewModel.posts.isLoading,
                errorMessage: viewModel.user.errorMessage,
                child: () => ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: viewModel.posts.content.length + 1,
                  itemBuilder: (ctx, idx) {
                    if (idx == 0) {
                      return Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: RoundedImage(
                                        pictureURL: user.picURL != null
                                            ? user.picURL
                                            : null,
                                        size: 80.0,
                                      ),
                                      margin: EdgeInsets.all(8),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: [
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
                                              user.isFounder
                                                  ? Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child: Image(
                                                        image: AssetImage(
                                                            "assets/founder.png"),
                                                        width: 16,
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                margin:
                                                    EdgeInsets.only(right: 8),
                                              ),
                                              Center(
                                                child: Text(
                                                  user.instagramProfile,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
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
                          LiceuDivider(),
                          viewModel.posts.content.length == 0
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
                              : Container()
                        ],
                      );
                    }
                    final post = viewModel.posts.content[idx - 1];
                    return Column(
                      children: <Widget>[
                        PostWidget(
                          user: user,
                          postStatus: post.statusCode,
                          postContent: post.type == PostType.TEXT
                          ? summarize(post.text, 600)
                          : '\n'.allMatches(post.text).length + 1 > 15
                              ? summarize(post.text, 30)
                              : summarize(post.text, 200),
                          onSharePressed: () {
                            viewModel.onSharePostPressed(
                              post.id,
                              post.type,
                              post.text,
                            );
                          },
                          images: post.images,
                          likes: post.likes == null ? 0 : post.likes,
                          imageURL: post.imageURL,
                          seeMore: post.type == PostType.TEXT &&
                                  post.text.length > 600 ||
                              post.type == PostType.IMAGE &&
                                  post.text.length > 200
                                  ||  '\n'.allMatches(post.text).length + 1 > 15
                              ? FlatButton(
                                  onPressed: () =>
                                      viewModel.onSeeMorePressed(post, user),
                                  child: Text(
                                    "Ver mais",
                                    style: TextStyle(
                                      color: Color(0xFF0061A1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                              : null,
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
                                user.id,
                                user.name,
                                post.id,
                                post.type.toString());
                          },
                          onLikePressed: () {
                            viewModel.onLikePressed(post.id);
                            post.likes++;
                          },
                          onSendCommentPressed: (comment) {
                            viewModel.onSendCommentPressed(post.id, comment);
                          },
                          comments: post.comments,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
}
