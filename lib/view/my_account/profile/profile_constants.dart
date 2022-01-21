class ProfileConstants {
  static const String profile = 'Profile';
  static const String userName = 'User name';
  static const String displayName = 'Display name';
  static const String email = 'Email';
  static const String balance = 'Balance';
}

enum ProfileLabel { userName, displayName, email, balance }

extension ProfileLabelExtension on ProfileLabel {
  String get label {
    switch (this) {
      case ProfileLabel.userName:
        return ProfileConstants.userName;
      case ProfileLabel.displayName:
        return ProfileConstants.displayName;
      case ProfileLabel.email:
        return ProfileConstants.email;
      case ProfileLabel.balance:
        return ProfileConstants.balance;
    }
  }
}
