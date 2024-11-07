

class SummaryData {
  final Map<String, double> debtMap;

  const SummaryData({required this.debtMap});

  static const empty = SummaryData(debtMap: {});
}