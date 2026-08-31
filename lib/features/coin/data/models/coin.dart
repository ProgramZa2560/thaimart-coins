import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  static const empty = Coin(
    uuid: '',
    symbol: '',
    name: '',
    iconUrl: '',
    price: 0,
    change: 0,
    marketCap: 0,
  );
  final String uuid;
  final String symbol;
  final String name;
  final String? color;
  final String iconUrl;
  final num price;
  final num change;
  final num marketCap;
  final String? description;
  final String? websiteUrl;

  const Coin({
    required this.uuid,
    required this.symbol,
    required this.name,
    required this.iconUrl,
    required this.price,
    required this.change,
    required this.marketCap,
    this.color,
    this.description,
    this.websiteUrl,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      uuid: json['uuid'] as String,
      symbol: (json['symbol'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      color: json['color'] as String?,
      iconUrl: (json['iconUrl'] as String?) ?? '',
      price: num.tryParse(json['price']?.toString() ?? '') ?? 0,
      change: num.tryParse(json['change']?.toString() ?? '') ?? 0,
      marketCap: num.tryParse(json['marketCap']?.toString() ?? '') ?? 0,
      description: json['description'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        uuid,
        symbol,
        name,
        color,
        iconUrl,
        price,
        change,
        marketCap,
        description,
        websiteUrl,
      ];
}
