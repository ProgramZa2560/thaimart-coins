import 'package:coinmarket/core/invite_positions.dart';

void main() {
  // simulate page 1: 10 coins, top3 excluded -> 7 main coins
  // then page 2 loads: 20 coins -> 17 main coins
  final rows = <String>[];
  var displayPosition = 1;
  for (var coin = 1; coin <= 20; coin++) {
    if (isInvitePosition(displayPosition)) {
      rows.add('INVITE');
      displayPosition++;
    }
    rows.add('COIN-$coin');
    displayPosition++;
  }
  for (var i = 0; i < rows.length; i++) {
    print('${i + 1}: ${rows[i]}');
  }
}
