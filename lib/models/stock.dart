import "dart:convert";

class Stock {
  final String name;
  final String symbol;
  final String iconPath;

  AlphaVantageDailyResponse daily;

  Stock({
    required this.name,
    required this.symbol,
    required this.iconPath,
    required this.daily,
  });

  double get latestClose {
    if (daily.bars.isEmpty) return 0.0;
    return daily.bars.first.close;
  }


  double get latestPercentChange {
    if (daily.bars.isEmpty) return 0.0;

    final open = daily.bars.first.open;
    final close = daily.bars.first.close;

    if (open == 0) return 0.0;

    return ((close - open) / open) * 100;
  }

  bool get isUp => latestPercentChange >= 0;

  String get percentText {
    final pct = latestPercentChange;
    if (pct == 0) return "--";
    final sign = pct >= 0 ? "+" : "";
    return "$sign${pct.toStringAsFixed(2)}%";
  }

  String get closeText {
    final c = latestClose;
    if (c == 0) return "--";
    return "\$${c.toStringAsFixed(2)}";
  }
}

class MetaData {
  final String information;
  final String symbol;
  final DateTime lastRefreshed;
  final String outputSize;
  final String timeZone;

  MetaData({
    required this.information,
    required this.symbol,
    required this.lastRefreshed,
    required this.outputSize,
    required this.timeZone,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      information: json["1. Information"] as String,
      symbol: json["2. Symbol"] as String,
      lastRefreshed: DateTime.parse(json["3. Last Refreshed"] as String),
      outputSize: json["4. Output Size"] as String,
      timeZone: json["5. Time Zone"] as String,
    );
  }
}

class DailyBar {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;

  DailyBar({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory DailyBar.fromAlphaVantage(String dateStr, Map<String, dynamic> day) {
    double parseD(String key) => double.parse(day[key] as String);
    int parseI(String key) => int.parse(day[key] as String);

    return DailyBar(
      date: DateTime.parse(dateStr),
      open: parseD('1. open'),
      high: parseD('2. high'),
      low: parseD('3. low'),
      close: parseD('4. close'),
      volume: parseI('5. volume'),
    );
  }
}

class AlphaVantageDailyResponse {
  final MetaData meta;
  final List<DailyBar> bars; // sorted newest -> oldest

  AlphaVantageDailyResponse({required this.meta, required this.bars});

  factory AlphaVantageDailyResponse.fromJson(Map<String, dynamic> json) {
    final metaJson = (json['Meta Data'] as Map).cast<String, dynamic>();

    final seriesJson =
        (json['Time Series (Daily)'] as Map).cast<String, dynamic>();

    final bars = seriesJson.entries.map((e) {
      final dateStr = e.key; // "2025-12-19"
      final day = (e.value as Map).cast<String, dynamic>();
      return DailyBar.fromAlphaVantage(dateStr, day);
    }).toList();

    // Sort newest -> oldest (string compare works for YYYY-MM-DD)
    bars.sort((a, b) => b.date.compareTo(a.date));

    return AlphaVantageDailyResponse(
      meta: MetaData.fromJson(metaJson),
      bars: bars,
    );
  }

  static AlphaVantageDailyResponse fromRawJson(String raw) =>
      AlphaVantageDailyResponse.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );

  static AlphaVantageDailyResponse fromEmpty() => AlphaVantageDailyResponse(
        meta: MetaData(
          information: '',
          symbol: '',
          lastRefreshed: DateTime.now(),
          outputSize: '',
          timeZone: '',
        ),
        bars: [],
      );
}
