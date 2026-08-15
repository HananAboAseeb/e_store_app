// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: lib/config/env/.env
final class _Env {
  static const List<int> _enviedkeyapiKey = <int>[
    1127838615,
    1268251396,
    3195349979,
    698373665,
    3228324366,
    26825357,
  ];

  static const List<int> _envieddataapiKey = <int>[
    1127838630,
    1268251446,
    3195349992,
    698373653,
    3228324411,
    26825403,
  ];

  static final String apiKey = String.fromCharCodes(List<int>.generate(
    _envieddataapiKey.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]));

  static const List<int> _enviedkeybaseUrl = <int>[
    3089569421,
    2338296412,
    422233905,
    3683281666,
    2940440512,
    643071481,
    2848656949,
    1017611039,
    3753946310,
    789336393,
    2664539111,
    3892580530,
    284523010,
    1608610771,
    103897577,
    989998144,
    4016103753,
    4093391290,
    1362612973,
    1651026057,
    309682644,
  ];

  static const List<int> _envieddatabaseUrl = <int>[
    3089569509,
    2338296360,
    422233925,
    3683281778,
    2940440499,
    643071427,
    2848656922,
    1017611056,
    3753946274,
    789336380,
    2664539018,
    3892580575,
    284523131,
    1608610745,
    103897498,
    989998127,
    4016103719,
    4093391252,
    1362612878,
    1651026150,
    309682617,
  ];

  static final String baseUrl = String.fromCharCodes(List<int>.generate(
    _envieddatabaseUrl.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddatabaseUrl[i] ^ _enviedkeybaseUrl[i]));
}
