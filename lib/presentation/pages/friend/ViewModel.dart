import 'dart:io';

import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/injection.dart';
import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/actions/FriendActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/ReportActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:app/presentation/util/text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class FriendViewModel {
  final Data<User> user;
  final Data<List<Post>> posts;
  final Function() refresh;
  final Function(String postId) onDeletePostPressed;
  final Function(String postId, PostType type, String text) onSharePostPressed;
  final Function(String userId) onChallengeMePressed;
  final Function() onInstagramPressed;
  final Function(Post post, User user) onSeeMorePressed;
  final Function(List<String> imageURL) onImageZoomPressed;
  final Function(String page, String width, String height, String authorId,
      String authorName, String postId, String postType) onReportPressed;
  final Function(String text) onReportTextChange;
  final String reportText;
  final Function(String postId) onLikePressed;
  final Function(User user) onUserPressed;
  final Function(String postId) onSavePostPressed;
  final Function(String postId) onDeleteSavedPostPressed;

  FriendViewModel(
      {this.user,
      this.onDeletePostPressed,
      this.onSharePostPressed,
      this.posts,
      this.refresh,
      this.onChallengeMePressed,
      this.onInstagramPressed,
      this.onSeeMorePressed,
      this.onImageZoomPressed,
      this.onReportPressed,
      this.onReportTextChange,
      this.reportText,
      this.onLikePressed,
      this.onUserPressed,
      this.onSavePostPressed,
      this.onDeleteSavedPostPressed});

  factory FriendViewModel.create(Store<AppState> store) {
    final friendState = store.state.friendState;
    final id = friendState.user.content.id;
    return FriendViewModel(
      user: friendState.user,
      posts: friendState.posts,
      reportText: friendState.reportText,
      refresh: () {
        store.dispatch(FetchFriendAction(id));
        store.dispatch(FetchFriendPostsAction(id));
      },
      onDeletePostPressed: (String postId) {
        store.dispatch(DeletePostAction(postId));
      },
      onUserPressed: (user) {
        store.dispatch(UserClickedAction(user));
      },
      onSharePostPressed: (postId, type, text) {
        store.dispatch(PostShareAction(postId, type));
        Share.share(summarize(text, 300) +
            "\n\nVeja o post que ${store.state.userState.user.content.name} compartilhou com você!\nhttp://liceu.co?postId=$postId");
      },
      onChallengeMePressed: (String userId) {
        store.dispatch(ChallengeSomeoneAction(userId));
      },
      onInstagramPressed: () {
        final instagramProfile = friendState.user.content.instagramProfile;
        store.dispatch(InstagramClickedAction(instagramProfile));
        launch("https://www.instagram.com/" + instagramProfile);
      },
      onSeeMorePressed: (post, user) {
        store.dispatch(NavigatePostAction(post.id));
      },
      onImageZoomPressed: (imageURL) {
        store.dispatch(NavigatePostImageZoomAction(imageURL));
      },
      onReportTextChange: (text) {
        store.dispatch(SetFriendPostReportTextFieldAction(text));
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
        store.dispatch(SubmitReportAction(
            store.state.friendState.reportText, tags, params));
      },
      onLikePressed: (postId) {
        store.dispatch(SubmitPostUpdateRatingAction(postId));
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
