enum GiveStar { give10, give100, give1000 }

extension GiveStarExtension on GiveStar {
  String get label {
    switch (this) {
      case GiveStar.give10:
        return '10';
      case GiveStar.give100:
        return '100';
      case GiveStar.give1000:
        return '1000';
    }
  }

  int get amount {
    switch (this) {
      case GiveStar.give10:
        return 10000;
      case GiveStar.give100:
        return 100000;
      case GiveStar.give1000:
        return 1000000;
    }
  }
}
