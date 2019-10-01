import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/LiceuPage.dart';
import 'package:app/presentation/widgets/TextFieldHighlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ViewModel.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, EditProfileViewModel>(
          onInit: (store) => store.dispatch(PageInitAction("EditProfile")),
          converter: (store) => EditProfileViewModel.create(store),
          builder: (BuildContext context, EditProfileViewModel viewModel) {
//            Bio Controller
            final TextEditingController bioTextController =
                TextEditingController(
              text: viewModel.bio,
            );
            bioTextController.selection = TextSelection.fromPosition(
              TextPosition(offset: viewModel.bio.length),
            );
// Instagram
            final TextEditingController instagramTextController =
                TextEditingController(
              text: viewModel.instagram,
            );
            instagramTextController.selection = TextSelection.fromPosition(
              TextPosition(
                offset: viewModel.instagram.length,
              ),
            );
            return LiceuPage(
              actions: <Widget>[
                FlatButton(
                  onPressed: viewModel.save,
                  child: new Icon(
                    FontAwesomeIcons.save,
                    color: Colors.black,
                  ),
                ),
              ],
              title: "Editar Perfil",
              body: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        TextFieldHighlight(
                          controller: bioTextController,
                          onChanged: (text) {
                            viewModel.onBioTextChanged(text);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(FontAwesomeIcons.user),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.1,
                              ),
                            ),
                            hintText: "Fale sobre você",
                          ),
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                        ),
                        Container(
                          margin: EdgeInsets.all(4),
                          child: Text(viewModel.bio.length.toString() + "/300"),
                        ),
                        TextFieldHighlight(
                          controller: instagramTextController,
                          onChanged: (text) {
                            viewModel.onInstagramTextChanged(text);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(FontAwesomeIcons.instagram),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.1,
                              ),
                            ),
                            hintText: "seu.instagram",
                          ),
                          keyboardType: TextInputType.multiline,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
}
