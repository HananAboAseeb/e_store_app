enum GenderFilter {
  all,
  female,
  male;

  String get label {
    switch (this) {
      case GenderFilter.all:
        return 'All';
      case GenderFilter.female:
        return 'Female';
      case GenderFilter.male:
        return 'Male';
    }
  }
}
