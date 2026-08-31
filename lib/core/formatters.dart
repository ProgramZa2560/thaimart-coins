import 'package:intl/intl.dart';

class AppFormatters {
  static String formatMarketCap(num value) {
    if (value >= 1e12) {
      return '${_format(value / 1e12)} trillion';
    } else if (value >= 1e9) {
      return '${_format(value / 1e9)} billion';
    } else if (value >= 1e6) {
      return '${_format(value / 1e6)} million';
    }
    return NumberFormat.compact().format(value);
  }

  static String _format(num value) {
    final fixed = value.toStringAsFixed(2);
    final trimmed = fixed.endsWith('.00')
        ? fixed.substring(0, fixed.length - 3)
        : fixed;
    return '\$$trimmed';
  }

  static String formatPrice(num value) {
    return '\$${NumberFormat('#,##0.00').format(value)}';
  }

  static String formatChange(num value) {
    final fixed = value.abs().toStringAsFixed(2);
    return '${value < 0 ? '-' : '+'}$fixed%';
  }
}
