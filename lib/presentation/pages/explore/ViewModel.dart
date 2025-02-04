import 'dart:io';

import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/injection.dart';
import 'package:app/presentation/state/actions/FriendActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/ReportActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:app/presentation/util/text.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';

class ExploreViewModel {
  final Data<User> user;
  final Data<List<PostData>> posts;
  final Function() refresh;
  final Function(String postId) onDeletePostPressed;
  final Function(String postId, PostType type, String text) onSharePostPressed;
  final Function(User user) onUserPressed;
  final Function(List<String> imageURL) onImageZoomPressed;
  final Function(PostData post) onSeeMorePressed;
  final Function(String page, String width, String height, String authorId,
      String authorName, String postId, String postType) onReportPressed;
  final Function(String text) onReportTextChange;
  final String reportText;
  final Function(String postId) onLikePressed;
  final Function(String query) onQueryTextChanged;
  final String query;
  final Function(String postId) onSavePostPressed;
  final Function(String postId) onDeleteSavedPostPressed;

  ExploreViewModel({
    this.user,
    this.onDeletePostPressed,
    this.onSharePostPressed,
    this.posts,
    this.refresh,
    this.onUserPressed,
    this.onSeeMorePressed,
    this.onImageZoomPressed,
    this.onReportPressed,
    this.onReportTextChange,
    this.reportText,
    this.onLikePressed,
    this.onQueryTextChanged,
    this.query,
    this.onSavePostPressed,
    this.onDeleteSavedPostPressed
  });

  factory ExploreViewModel.create(Store<AppState> store) {
    final userState = store.state.userState;
    final postState = store.state.postState;
    return ExploreViewModel(
      user: userState.user,
      posts: postState.query != "" ? postState.searchPosts : postState.posts,
      reportText: postState.reportText,
      query: store.state.postState.query,
      refresh: () {
        store.dispatch(FetchPostsAction());
      },
      onDeletePostPressed: (String postId) {
        store.dispatch(DeletePostAction(postId));
      },
      onSharePostPressed: (postId, type, text) {
        store.dispatch(PostShareAction(postId, type));
        Share.share(summarize(text, 300) +
            "\n\nVeja o post que ${store.state.userState.user.content.name} compartilhou com você!\nhttp://liceu.co?postId=$postId");
      },
      onUserPressed: (user) {
        store.dispatch(UserClickedAction(user));
      },
      onSeeMorePressed: (post) {
        store.dispatch(NavigatePostAction(post.id));
      },
      onImageZoomPressed: (imageURL) {
        store.dispatch(NavigatePostImageZoomAction(imageURL));
      },
      onReportTextChange: (text) {
        store.dispatch(SetPostReportTextFieldAction(text));
      },
      onReportPressed: (String page,
          String width,
          String height,
          String authorId,
          String authorName,
          String postId,
          String postType) async {
        final String version = await Information.appVersion;
        final String phoneModel = await Information.phoneModel;
        final String brand = await Information.brand;
        final String release = await Information.osRelease;
        String os;

        if (Platform.isAndroid) {
          os = "Android";
        } else if (Platform.isIOS) {
          os = "iOS";
        }

        Map<String, dynamic> params = {
          "postId": postId,
          "postType": postType,
          "authorId": authorId,
          "authorName": authorName,
          "page": page,
          "appVersion": version,
          "platform": os,
          "brand": brand,
          "model": phoneModel,
          "osRelease": release,
          "screenSize": width + " x " + height
        };

        List<String> tags = ["created", "report", "post"];
        store.dispatch(
            SubmitReportAction(store.state.postState.reportText, tags, params));
      },
      onLikePressed: (postId) {
        store.dispatch(SubmitPostUpdateRatingAction(postId));
      },
      onQueryTextChanged: (query) {
        store.dispatch(SearchPostAction(query));
      },
      onSavePostPressed: (postId) {
        store.dispatch(SubmitUserSavePostAction(postId));
      },
      onDeleteSavedPostPressed: (postId) {
        store.dispatch(DeleteUserSavedPostAction(postId));
      }
    );
  }
}
