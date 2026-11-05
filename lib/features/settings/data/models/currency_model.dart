import '../../domain/entities/currency_entity.dart';

class CurrencyModel extends CurrencyEntity {
  const CurrencyModel({
    required super.id,
    required super.code,
    required super.symbol,
    required super.label,
    super.isSelected = false,
  });

  factory CurrencyModel.fromEntity(CurrencyEntity entity) {
    return CurrencyModel(
      id: entity.id,
      code: entity.code,
      symbol: entity.symbol,
      label: entity.label,
      isSelected: entity.isSelected,
    );
  }

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'] as String? ?? '',
      code: json['code'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      label: json['label'] as String? ?? '',
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  @override
  CurrencyModel copyWith({
    String? id,
    String? code,
    String? symbol,
    String? label,
    bool? isSelected,
  }) {
    return CurrencyModel(
      id: id ?? this.id,
      code: code ?? this.code,
      symbol: symbol ?? this.symbol,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'symbol': symbol,
      'label': label,
      'isSelected': isSelected,
    };
  }
}
