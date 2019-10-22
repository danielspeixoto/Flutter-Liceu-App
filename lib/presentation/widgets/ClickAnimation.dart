import 'package:states_rebuilder/states_rebuilder.dart';

class AnimationBloc extends StatesRebuilder {
  bool toggleCurve = true;
  rebuild() {
    toggleCurve = !toggleCurve;
    rebuildStates(['like']);
  }
}