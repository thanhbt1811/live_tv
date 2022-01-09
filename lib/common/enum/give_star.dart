enum GiveStar { give1, give5, give10 }

extension GiveStarExtension on GiveStar {
  String get label {
    switch (this) {
      case GiveStar.give1:
        return '1';
      case GiveStar.give5:
        return '5';
      case GiveStar.give10:
        return '10';
    }
  }

  int get amount {
    switch (this) {
      case GiveStar.give1:
        return 20000;
      case GiveStar.give5:
        return 100000;
      case GiveStar.give10:
        return 200000;
    }
  }
}
