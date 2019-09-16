import 'package:app/presentation/redux/app_state.dart';
import 'package:app/presentation/widgets/LiceuScaffold.dart';
import 'package:app/presentation/widgets/RankingPosition.dart';
import 'package:app/presentation/widgets/RoundedImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LiceuDivider extends StatelessWidget {
  LiceuDivider();

  @override
  Widget build(BuildContext context) =>
      Divider(
        indent: 32,
        endIndent: 32,
      );
}
