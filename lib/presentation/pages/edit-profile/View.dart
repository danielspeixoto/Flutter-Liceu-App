import 'package:app/presentation/widgets/LiceuPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../injection.dart';
import '../../../redux.dart';
import 'Middleware.dart';
import 'ViewModel.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, EditProfileViewModel>(
          onInit: (store) {
            store.dispatch(FillUserFieldsInEditPageAction());
          },
          converter: (store) =>
              EditProfileViewModel.create(store, setUserDescriptionUseCase),
          builder: (BuildContext context, EditProfileViewModel viewModel) {
            return LiceuPage(
              actions: <Widget>[
                FlatButton(
                  onPressed: viewModel.save,
                  child: new Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                ),
              ],
              title: "Editar Perfil",
              body: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextField(
                      controller: TextEditingController(text: viewModel.editData.content.bio),
                      onChanged: viewModel.onBioTextChanged,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.1,
                          ),
                        ),
                        hintText: "Fale sobre você",
                      ),
                      minLines: null,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
            );
          });
}
