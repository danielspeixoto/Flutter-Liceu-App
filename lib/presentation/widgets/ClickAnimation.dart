import 'package:states_rebuilder/states_rebuilder.dart';

class ClickAnimation extends StatesRebuilder {
  bool toggleCurve = true;
  rebuild() {
    toggleCurve = !toggleCurve;
    rebuildStates(['like']);
  }
}