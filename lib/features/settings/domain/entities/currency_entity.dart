import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  final String id;
  final String code;
  final String symbol;
  final String label; // e.g. "$ USD", "€ EURO"
  final bool isSelected;

  const CurrencyEntity({
    required this.id,
    required this.code,
    required this.symbol,
    required this.label,
    this.isSelected = false,
  });

  CurrencyEntity copyWith({
    String? id,
    String? code,
    String? symbol,
    String? label,
    bool? isSelected,
  }) {
    return CurrencyEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      symbol: symbol ?? this.symbol,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, code, symbol, label, isSelected];
}
