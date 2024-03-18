class Transactions {
  final String id;
  final String fromWallet;
  final String type;
  final double amount;
  final String currency;
  final DateTime timestamp;

  Transactions({
    required this.id,
    required this.fromWallet,
    required this.type,
    required this.amount,
    required this.currency,
    required this.timestamp,
  });
}
