import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/widgets/FetcherWidget.dart';
import 'package:app/presentation/widgets/LiceuPage.dart';
import 'package:app/presentation/widgets/TextFieldHighlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ViewModel.dart';

List<String> suggestions = [
    "Administração - Bacharelado",
"Agronomia - Bacharelado",
"Arqueologia - Bacharelado",
"Arquitetura e Urbanismo - Bacharelado",
"Arquivologia - Bacharelado",
"Artes Visuais - Bacharelado",
"Artes Visuais - Licenciatura",
"Biblioteconomia - Bacharelado",
"Biomedicina - Bacharelado",
"Ciência da Computação - Bacharelado",
"Ciências Biológicas - Bacharelado",
"Ciências Biológicas - Licenciatura",
"Ciências Atuariais - Bacharelado",
"Ciências Contábeis - Bacharelado",
"Ciências Econômicas - Bacharelado",
"Ciências Naturais - Licenciatura",
"Ciências Sociais - Bacharelado",
"Ciências Sociais - Licenciatura",
"Cinema e Audiovisual - Bacharelado",
"Dança - Bacharelado",
"Dança - Licenciatura",
"Design - Bacharelado",
"Direito - Bacharelado",
"Educação Física - Bacharelado",
"Educação Física - Licenciatura",
"Enfermagem - Bacharelado",
"Engenharia Aeronáutica - Bacharelado",
"Engenharia Agrícola - Bacharelado",
"Engenharia Ambiental e Sanitária - Bacharelado",
"Engenharia Cartográfica e de Agrimensura - Bacharelado",
"Engenharia Civil - Bacharelado",
'Engenharia de Alimentos - Bacharelado',
'Engenharia de Bioprocessos - Bacharelado',
'Engenharia de Computação - Bacharelado',
'Engenharia de Controle e Automação - Bacharelado',
'Engenharia de Fortificação e Construção - Bacharelado',
'Engenharia de Materiais - Bacharelado',
'Engenharia de Minas - Bacharelado',
'Engenharia de Pesca - Bacharelado',
'Engenharia de Petróleo - Bacharelado',
'Engenharia de Produção - Bacharelado',
'Engenharia de Telecomunicações - Bacharelado',
'Engenharia Elétrica - Bacharelado',
'Engenharia Eletrônica - Bacharelado',
'Engenharia Florestal - Bacharelado',
'Engenharia Mecânica - Bacharelado',
'Engenharia Mecânica de Armamentos - Bacharelado',
'Engenharia Mecânica de Veículos Militares - Bacharelado',
'Engenharia Metalúrgica - Bacharelado',
'Engenharia Naval - Bacharelado',
'Engenharia Nuclear - Bacharelado',
'Engenharia Química - Bacharelado',
'Engenharia Têxtil - Bacharelado',
'Estatística - Bacharelado',
'Farmácia - Bacharelado',
'Filosofia - Bacharelado',
'Filosofia - Licenciatura',
'Física - Bacharelado',
'Física - Licenciatura',
'Fisioterapia - Bacharelado',
'Fonoaudiologia - Bacharelado',
'Geografia - Licenciatura',
'Geografia - Bacharelado',
'Geologia - Bacharelado',
'História - Bacharelado',
'História - Licenciatura',
'Informática - Licenciatura',
'Jornalismo - Bacharelado',
'Letras - Língua Estrangeira - Bacharelado',
'Letras - Língua Portuguesa - Bacharelado',
'Letras - Língua Estrangeira - Licenciatura',
'Letras - Língua Portuguesa - Licenciatura',
'Matemática - Bacharelado',
'Matemática - Licenciatura',
'Medicina - Bacharelado',
'Medicina Veterinária - Bacharelado',
'Meteorologia - Bacharelado',
'Museologia - Bacharelado',
'Música - Bacharelado',
'Música - Licenciatura',
'Nutrição - Bacharelado',
'Odontologia - Bacharelado',
'Pedagogia - Licenciatura',
'Psicologia - Bacharelado',
'Publicidade e Propaganda - Bacharelado',
'Química - Bacharelado',
'Química - Licenciatura',
'Radio, TV, Internet (Comunicação Audiovisual e Multimídia) - Bacharelado',
'Relações Internacionais - Bacharelado',
'Relações Públicas - Bacharelado',
'Secretariado Executivo - Bacharelado',
'Serviço Social - Bacharelado',
'Sistemas da Informação - Bacharelado',
'Teatro - Bacharelado',
'Teatro - Licenciatura',
'Teologia - Bacharelado',
'Terapia Ocupacional - Bacharelado',
'Turismo - Bacharelado',
'Zootecnia - Bacharelado',
];

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState,
          EditProfileViewModel>(
      onInit: (store) => store.dispatch(PageInitAction("EditProfile")),
      converter: (store) => EditProfileViewModel.create(store),
      builder: (BuildContext context, EditProfileViewModel viewModel) {
//            Bio Controller
        final TextEditingController bioTextController = TextEditingController(
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
        //Desired Course
        final TextEditingController desiredCourseTextController =
            TextEditingController(
          text: viewModel.desiredCourse,
        );
        desiredCourseTextController.selection = TextSelection.fromPosition(
          TextPosition(
            offset: viewModel.desiredCourse.length,
          ),
        );
        //Phone
        final TextEditingController phoneTextController = TextEditingController(
          text: viewModel.phone,
        );
        phoneTextController.selection = TextSelection.fromPosition(
          TextPosition(
            offset: viewModel.phone.length,
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
            body: FetcherWidget(
                isLoading: viewModel.isLoading,
                child: () => SingleChildScrollView(
                      child: Column(
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
                                  capitalization: TextCapitalization.sentences,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 4, bottom: 4, left: 4, right: 16),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    viewModel.bio.length.toString() + "/300",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[600]),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(4),
                                  child: TextFieldHighlight(
                                    controller: instagramTextController,
                                    onChanged: (text) {
                                      viewModel.onInstagramTextChanged(text);
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(FontAwesomeIcons.instagram),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.1,
                                        ),
                                      ),
                                      hintText: "seu.instagram",
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 4, bottom: 4, left: 4, right: 16),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    viewModel.instagram.length.toString() +
                                        "/60",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[600]),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.all(4),
                                    child: TextFieldHighlight(
                                      controller: phoneTextController,
                                      onChanged: (text) {
                                        viewModel.onPhoneTextChanged(text);
                                      },
                                      isMasked: true,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            Icon(FontAwesomeIcons.phoneAlt),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.1,
                                          ),
                                        ),
                                        hintText: "Telefone",
                                      ),
                                      keyboardType: TextInputType.phone,
                                    )),
                                Container(
                                    margin: EdgeInsets.all(4),
                                    child: TextFieldHighlight(
                                      controller: desiredCourseTextController,
                                      onChanged: (text) {
                                        viewModel
                                            .onDesiredCourseTextChanged(text);
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(FontAwesomeIcons.book),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.1,
                                          ),
                                        ),
                                        hintText: "Curso desejado",
                                      ),
                                      keyboardType: TextInputType.text,
                                      capitalization:
                                          TextCapitalization.sentences,
                                      isAutoCompleteTextField: true,
                                      suggestions: suggestions,
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )));
      });
}
