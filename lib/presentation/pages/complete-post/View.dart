import 'package:app/presentation/pages/complete-post/ViewModel.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:app/presentation/widgets/PostWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CompletePostPage extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, CompletePostViewModel>(
        onInit: (store) => store.dispatch(PageInitAction("CompletePost")),
        converter: (store) => CompletePostViewModel.create(store),
        builder: (BuildContext context, CompletePostViewModel viewModel) {
          final post = viewModel.post;
          return LiceuScaffold(
            body: SmartRefresher(
              onRefresh: () async {
                viewModel.refresh();
                _refreshController.refreshCompleted();
              },
              controller: _refreshController,
              child: ListView(
                children: <Widget>[
                  FetcherWidget.build(
                    isLoading: post.isLoading,
                    errorMessage: post.errorMessage,
                    child: () => PostWidget(
                      user: post.content.user,
                      postStatus: post.content.statusCode,
                      postContent: post.content.text,
                      imageURL: post.content.imageURL,
                      onUserPressed: (user) => {viewModel.onUserPressed(user)},
                      onSharePressed: () {
                        viewModel.onSharePostPressed(post.content.id,
                            post.content.type, post.content.text);
                      },
                      onImageZoomPressed: () {
                        viewModel.onImageZoomPressed(post.content.images);
                      },
                      likes: post.content.likes,
                      onLikePressed: () {
                        viewModel.onLikePressed(post.content.id);
                        post.content.likes++;
                      },
                      images: post.content.images,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
