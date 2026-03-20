import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/currency_formatter.dart';
import 'package:flutter_application_1/domain/entities/fund.dart';
import 'package:flutter_application_1/domain/entities/transaction.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/dialogs/notification_method_chip.dart';

class SubscribeDialog extends StatefulWidget {
  const SubscribeDialog({
    super.key,
    required this.fund,
    required this.onSubscribe,
  });

  final Fund fund;
  final void Function(double amount, NotificationMethod notificationMethod)
  onSubscribe;

  @override
  State<SubscribeDialog> createState() => _SubscribeDialogState();
}

class _SubscribeDialogState extends State<SubscribeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  NotificationMethod _notificationMethod = NotificationMethod.email;

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.fund.minimumAmount.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.add_circle_outline_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          const Expanded(child: Text('Suscribir a fondo')),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.fund.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Monto mínimo: ${formatCop(widget.fund.minimumAmount, decimals: true)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Monto a suscribir',
                    prefixText: copPrefix,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese un monto';
                    }
                    final amount = double.tryParse(value);
                    if (amount == null || amount <= 0) {
                      return 'Monto inválido';
                    }
                    if (amount < widget.fund.minimumAmount) {
                      return 'El monto mínimo es ${formatCop(widget.fund.minimumAmount, decimals: true)}';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 22),
                Text(
                  'Método de notificación',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: NotificationMethodChip(
                        icon: Icons.mail_outline_rounded,
                        label: 'Email',
                        selected:
                            _notificationMethod == NotificationMethod.email,
                        semanticLabel: 'Notificación por correo electrónico',
                        onTap: () => setState(
                          () => _notificationMethod = NotificationMethod.email,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: NotificationMethodChip(
                        icon: Icons.sms_outlined,
                        label: 'SMS',
                        selected: _notificationMethod == NotificationMethod.sms,
                        semanticLabel: 'Notificación por SMS',
                        onTap: () => setState(
                          () => _notificationMethod = NotificationMethod.sms,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final amount = double.parse(_amountController.text);
              widget.onSubscribe(amount, _notificationMethod);
            }
          },
          child: const Text('Confirmar suscripción'),
        ),
      ],
    );
  }
}
