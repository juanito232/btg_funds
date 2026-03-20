/// Entidad que representa una transacción (suscripción o cancelación)
class Transaction {
  const Transaction({
    required this.id,
    required this.fundId,
    required this.fundName,
    required this.type,
    required this.amount,
    required this.date,
    required this.notificationMethod,
  });

  final String id;
  final String fundId;
  final String fundName;
  final TransactionType type;
  final double amount;
  final DateTime date;
  final NotificationMethod notificationMethod;
}

enum TransactionType { subscription, cancellation }

enum NotificationMethod { email, sms }

extension NotificationMethodExtension on NotificationMethod {
  String get label => switch (this) {
        NotificationMethod.email => 'Email',
        NotificationMethod.sms => 'SMS',
      };
}
