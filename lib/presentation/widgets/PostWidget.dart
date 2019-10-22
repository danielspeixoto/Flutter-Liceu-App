import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/widgets/TextFieldHighlight.dart';
import 'package:app/util/FeaturesAvailable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'RoundedImage.dart';

class TabData {
  final IconData icon;

  TabData(this.icon);
}

class PostWidget extends StatelessWidget {
  final User user;
  final String postContent;
  final String imageURL;
  final List<String> images;
  final Function() onDeletePressed;
  final Function() onSharePressed;
  final Function(User) onUserPressed;
  final bool seeMore;
  final Function() onImageZoomPressed;
  final String postStatus;
  final Function() onReportPressed;
  final Function(String) onReportTextChange;
  int likes;
  final Function() onLikePressed;
  final Function() onSeeMorePressed;
  final String numberOfComments;

  PostWidget(
      {@required this.user,
      @required this.postContent,
      this.onDeletePressed,
      @required this.onSharePressed,
      this.onUserPressed,
      @required this.imageURL,
      this.seeMore,
      this.onImageZoomPressed,
      @required this.postStatus,
      this.onReportPressed,
      this.onReportTextChange,
      @required this.likes,
      @required this.onLikePressed,
      @required this.images,
      this.onSeeMorePressed,
      this.numberOfComments});

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        elevation: 0,
        child: Container(
          padding: EdgeInsets.only(bottom: 4),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => onUserPressed(user),
                    child: Row(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.all(8),
                            child: Opacity(
                              opacity:
                                  this.postStatus == "approved" ? 1.0 : 0.5,
                              child: RoundedImage(
                                pictureURL: this.user.picURL != null
                                    ? this.user.picURL
                                    : null,
                                size: 36,
                              ),
                            )),
                        Opacity(
                          opacity: this.postStatus == "approved" ? 1.0 : 0.5,
                          child: Text(
                            this.user.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        user.isFounder
                            ? Container(
                                padding: EdgeInsets.all(4),
                                child: Opacity(
                                  opacity:
                                      this.postStatus == "approved" ? 1.0 : 0.5,
                                  child: Image(
                                    image: AssetImage("assets/founder.png"),
                                    width: 12,
                                  ),
                                ))
                            : Container(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        alignment: Alignment.topRight,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  children: <Widget>[
                                    this.postStatus == "approved"
                                        ? ListTile(
                                            title: Text("Compartilhar"),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              onSharePressed();
                                            },
                                          )
                                        : Container(),
                                    this.postStatus == "approved"
                                        ? ListTile(
                                            title: Text("Reportar"),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return SimpleDialog(
                                                      title: Text("Reportar"),
                                                      children: <Widget>[
                                                        Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        24),
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                TextFieldHighlight(
                                                                  onChanged:
                                                                      (text) {
                                                                    this.onReportTextChange(
                                                                        text);
                                                                  },
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            0.1,
                                                                      ),
                                                                    ),
                                                                    hintText:
                                                                        "Ex: O conteúdo do resumo é inadequado",
                                                                  ),
                                                                  maxLines: 4,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                ),
                                                                ListTile(
                                                                  title: Text(
                                                                    "Enviar",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    this.onReportPressed();
                                                                  },
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    );
                                                  });
                                            },
                                          )
                                        : Container(),
                                    onDeletePressed != null
                                        ? ListTile(
                                            title: Text("Deletar postagem"),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              onDeletePressed();
                                            },
                                          )
                                        : Container(),
                                  ],
                                );
                              });
                        },
                        icon: Container(
                          child: Icon(
                            FontAwesomeIcons.ellipsisV,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              this.postStatus == "inReview"
                  ? Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "O resumo está em processo de avaliação",
                        style: TextStyle(color: Colors.amber, fontSize: 12),
                      ),
                    )
                  : this.postStatus == "approved"
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Infelizmente o resumo não foi aceito",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
              Container(
                alignment: Alignment.centerLeft,
                child: Opacity(
                  opacity: this.postStatus == "approved" ? 1.0 : 0.5,
                  child: Linkify(
                    onOpen: (link) => launch(link.url),
                    text: this.postContent,
                  ),
                ),
                margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                padding: EdgeInsets.only(bottom: 4),
              ),
              seeMore != null
                  ? seeMore == true
                      ? FlatButton(
                          onPressed: () {
                            this.onSeeMorePressed();
                          },
                          child: Text(
                            "Ver mais",
                            style: TextStyle(
                              color: Color(0xFF0061A1),
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                      : Container()
                  : Container,
              imageURL == null
                  ? Container()
                  : Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: (MediaQuery.of(context).size.width - 8),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              this.onImageZoomPressed();
                            },
                            child: Opacity(
                              opacity:
                                  this.postStatus == "approved" ? 1.0 : 0.5,
                              child: CachedNetworkImage(
                                width: double.infinity,
                                height: (MediaQuery.of(context).size.width - 8),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.center,
                                imageUrl: imageURL,
                                placeholder: (ctx, x) => Image(
                                  image: AssetImage("assets/pencil.gif"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: images.length != 0
                              ? Text(
                                  "1/" + images.length.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text(
                                  "1/1",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ],
                    ),
              Row(
                children: <Widget>[
                  this.postStatus == "approved"
                      ? Container(
                          alignment: Alignment.centerLeft,
                          child: FlatButton(
                              onPressed: () {
                                this.onLikePressed();
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.solidHeart,
                                    size: 15,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 4),
                                      child: Text(this.likes.toString()))
                                ],
                              )),
                        )
                      : Container(),
                  this.postStatus == "approved" && FeaturesAvailable.comments
                      ? Container(
                          alignment: Alignment.centerLeft,
                          child: FlatButton(
                              onPressed: () {
                                this.onSeeMorePressed();
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.commentAlt,
                                    size: 15,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 4),
                                      child: Text(this.numberOfComments))
                                ],
                              )),
                        )
                      : Container(),
                ],
              )
            ],
          ),
        ),
      );
}
