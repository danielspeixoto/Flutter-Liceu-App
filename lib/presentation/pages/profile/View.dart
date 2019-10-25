import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/util/text.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuDivider.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:app/presentation/widgets/PostWidget.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:app/presentation/widgets/TextFieldHighlight.dart';
import 'package:app/presentation/widgets/TextWithLinks.dart';
import 'package:app/util/FeaturesAvailable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
                        viewModel.onLiceuInstagramPressed();
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
                    title: Text('Compartilhar perfil'),
                    onTap: viewModel.onShareProfilePressed,
                  ),
                  ListTile(
                    title: Text('Relatar um problema'),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: Text("Relatar um problema"),
                              children: <Widget>[
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    child: Column(
                                      children: <Widget>[
                                        TextFieldHighlight(
                                          onChanged: (text) {
                                            viewModel
                                                .onFeedbackTextChanged(text);
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 0.1,
                                              ),
                                            ),
                                            hintText:
                                                "Não estou conseguindo desafiar alguém. Sempre que tento, o aplicativo fecha.",
                                          ),
                                          maxLines: 4,
                                          keyboardType: TextInputType.multiline,
                                          capitalization:
                                              TextCapitalization.sentences,
                                        ),
                                        ListTile(
                                          title: Text(
                                            "Enviar",
                                            textAlign: TextAlign.center,
                                          ),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            viewModel.onSendReportButtonPressed(
                                                runtimeType.toString(),
                                                MediaQuery.of(context)
                                                    .size
                                                    .width
                                                    .toString(),
                                                MediaQuery.of(context)
                                                    .size
                                                    .height
                                                    .toString());
                                          },
                                        ),
                                      ],
                                    )),
                              ],
                            );
                          });
                    },
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
                                            onPressed: viewModel
                                                .onEditProfileButtonPressed,
                                            child: Text(
                                              "Editar perfil",
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: FeaturesAvailable.savePosts
                                      ? OutlineButton(

                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.all(8),
                                                child: Text("Resumos salvos"),
                                              ),
                                              Icon(
                                                  FontAwesomeIcons
                                                      .solidBookmark,
                                                  size: 10),
                                            ],
                                          ),
                                          onPressed: () {
                                            viewModel.onSavedResumesPressed();
                                          },
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10.0)))
                                      : Container(),
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
                                        "Você ainda não compartilhou nenhum resumo",
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
                              : summarize(post.text, 200),
                          onSharePressed: () {
                            viewModel.onSharePostPressed(
                              post.id,
                              post.type,
                              post.text,
                            );
                          },
                          numberOfComments: post.comments.length.toString(),
                          images: post.images,
                          onDeletePressed: () =>
                              viewModel.onDeletePostPressed(post.id),
                          imageURL: post.imageURL,
                          likes: post.likes == null ? 0 : post.likes,
                          seeMore: post.type == PostType.TEXT &&
                                      post.text.length > 600 ||
                                  post.type == PostType.IMAGE &&
                                      post.text.length > 200
                              ? true
                              : false,
                          onSeeMorePressed: () {
                            viewModel.onSeeMorePressed(post, user);
                          },
                          onImageZoomPressed: () {
                            viewModel.onImageZoomPressed(post.images);
                          },
                          onLikePressed: () {
                            viewModel.onLikePressed(post.id);
                            post.likes++;
                          },
                          onSavePostPressed: () {
                            viewModel.onSavePostPressed(post.id);
                          },
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
