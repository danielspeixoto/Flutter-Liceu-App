import 'package:states_rebuilder/states_rebuilder.dart';

class ClickAnimation extends StatesRebuilder {
  bool toggleCurveLike = true;
  bool toggleCurveBookmark = true;
  rebuildLike() {
    toggleCurveLike = !toggleCurveLike;
    rebuildStates(['like']);
    
  }
  rebuildSavePost() {
    toggleCurveBookmark = !toggleCurveBookmark;
    rebuildStates(['savePost']);
  }
}