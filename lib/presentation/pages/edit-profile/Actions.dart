class SetUserEditFieldAction {
  final String bio;
  final String instagram;

  SetUserEditFieldAction({this.bio, this.instagram});
}

class SubmitUserProfileChangesAction {
  final String bio;
  final String instagram;

  SubmitUserProfileChangesAction({this.bio, this.instagram});
}

class MyProfileInfoWasChangedAction {
  final String bio;
  final String instagram;

  MyProfileInfoWasChangedAction(this.bio, this.instagram);
}
