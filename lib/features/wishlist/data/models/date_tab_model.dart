import '../../domain/entities/date_tab_entity.dart';

class DateTabModel extends DateTabEntity {
  const DateTabModel({
    required super.id,
    required super.label,
    super.date,
    super.isPreset = true,
  });

  factory DateTabModel.today() {
    return const DateTabModel(
      id: 'today',
      label: 'Today',
      isPreset: true,
    );
  }

  factory DateTabModel.yesterday() {
    return const DateTabModel(
      id: 'yesterday',
      label: 'Yesterday',
      isPreset: true,
    );
  }

  factory DateTabModel.custom(DateTime date, String label) {
    return DateTabModel(
      id: 'date_${date.year}_${date.month}_${date.day}',
      label: label,
      date: date,
      isPreset: false,
    );
  }
}
