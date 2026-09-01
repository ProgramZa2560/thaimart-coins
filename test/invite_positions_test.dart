import 'package:flutter_test/flutter_test.dart';

import 'package:coinmarket/core/invite_positions.dart';

void main() {
  test('invite positions are 5, 10, 20, 40, 80, 160, ...', () {
    final invites = <int>[
      for (var i = 1; i <= 200; i++)
        if (isInvitePosition(i)) i,
    ];
    expect(invites, [5, 10, 20, 40, 80, 160]);
  });

  test('inserts invite after every 4 non-invite items starting at 5', () {
    final rows = <String>[];
    var displayPosition = 1;
    for (var coin = 1; coin <= 30; coin++) {
      if (isInvitePosition(displayPosition)) {
        rows.add('INVITE');
        displayPosition++;
      }
      rows.add('COIN-$coin');
      displayPosition++;
    }
    final inviteIndexes = [
      for (var i = 0; i < rows.length; i++)
        if (rows[i] == 'INVITE') i,
    ];
    expect(inviteIndexes, [4, 9, 19]);
    expect(rows[4], 'INVITE');
    expect(rows[9], 'INVITE');
    expect(rows[5], 'COIN-5');
    expect(rows[10], 'COIN-6');
  });
}
