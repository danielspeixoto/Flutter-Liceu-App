import 'package:app/presentation/reducers/user/Presenter.dart';
import 'package:app/presentation/widgets/LiceuWidget.dart';
import 'package:app/presentation/widgets/PostWidget.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:app/presentation/widgets/TextWithLinks.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../State.dart';
import 'ViewModel.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class HomePage extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, HomeViewModel>(
      onInit: (store) {
        store.dispatch(FetchMyInfoAction());
        store.dispatch(FetchMyPostsAction());
      },
      converter: (store) => HomeViewModel.create(store),
      builder: (BuildContext context, HomeViewModel viewModel) {
        return Liceu(
          selectedIdx: 0,
          leading: FlatButton(
            onPressed: viewModel.onCreateButtonPressed,
            child: new Icon(
              Icons.create,
            ),
          ),
          body: SmartRefresher(
            onRefresh: () async {
              viewModel.refresh();
              await Future.delayed(Duration(milliseconds: 1000));
              _refreshController.refreshCompleted();
            },
            controller: _refreshController,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RoundedImage(pictureURL: viewModel.user.content.picURL, size: 80.0),
                        Text(
                          viewModel.userName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    viewModel.userBio != null
                        ? Container(
                            child: TextWithLinks(
                              text: viewModel.userBio,
                            ),
                            margin: const EdgeInsets.all(8.0),
                          )
                        : Container(),
                    Divider(
                      color: Colors.black54,
                      indent: 16,
                      endIndent: 16,
                    ),
                    Container(
                      child: Column(
                        children: viewModel.posts
                            .map((post) => PostWidget(viewModel.userName,
                                viewModel.userPic, post.text))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
