bool isInvitePosition(int position) {
  if (position < 5) return false;
  var p = 5;
  while (p < position) {
    p *= 2;
  }
  return p == position;
}
