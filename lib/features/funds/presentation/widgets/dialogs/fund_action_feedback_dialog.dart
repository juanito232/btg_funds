import 'package:flutter/material.dart';

/// Result of suscripción o cancelación (éxito o error).
Future<void> showFundActionFeedbackDialog(
  BuildContext context, {
  required String message,
  required bool isError,
}) {
  final scheme = Theme.of(context).colorScheme;

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      return AlertDialog(
        icon: Icon(
          isError ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded,
          color: isError ? scheme.error : scheme.primary,
          size: 32,
        ),
        title: Text(isError ? 'No se pudo completar' : 'Operación exitosa'),
        content: SingleChildScrollView(
          child: Text(message),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
