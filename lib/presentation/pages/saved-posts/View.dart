import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/pages/saved-posts/ViewModel.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/util/text.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:app/presentation/widgets/PostWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SavedPostsPage extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  Widget build(BuildContext context) =>
      StoreConnector<AppState, SavedPostsViewModel>(
          onInit: (store) => store.dispatch(PageInitAction("SavedPosts")),
          converter: (store) => SavedPostsViewModel.create(store),
          builder: (BuildContext context, SavedPostsViewModel viewModel) {
            return LiceuScaffold(
                body: SmartRefresher(
              onRefresh: () async {
                viewModel.refresh();
                _refreshController.refreshCompleted();
              },
              controller: _refreshController,
              child: FetcherWidget.build(
                  isLoading: viewModel.posts.isLoading,
                  child: () => ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: viewModel.posts.content.length + 1,
                      itemBuilder: (ctx, idx) {
                        
                        if (idx == 0) {
                          if (viewModel.posts.content.length == 0) {
                            return Container(
                              margin: EdgeInsets.all(16),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Você ainda não salvou nenhum resumo",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        }
                        final post = viewModel.posts.content[idx - 1];
                        return Column(
                          children: <Widget>[
                            AnimatedPost(
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
                              onSharePressed: () {
                                viewModel.onSharePostPressed(
                                  post.id,
                                  post.type,
                                  post.text,
                                );
                              },
                              onUserPressed: (user) =>
                                  viewModel.onUserPressed(user),
                              numberOfComments: post.comments.length.toString(),
                              images: post.images,
                              likes: post.likes == null ? 0 : post.likes,
                              imageURL: post.imageURL,
                              seeMore: post.type == PostType.TEXT &&
                                          post.text.length > 600 ||
                                      post.type == PostType.IMAGE &&
                                          post.text.length > 200
                                  ? true
                                  : false,
                              onSeeMorePressed: () {
                                viewModel.onSeeMorePressed(post, post.user);
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
                                    MediaQuery.of(context)
                                        .size
                                        .width
                                        .toString(),
                                    MediaQuery.of(context)
                                        .size
                                        .height
                                        .toString(),
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
                            ),
                          ],
                        );
                      })),
            ));
          });
}
