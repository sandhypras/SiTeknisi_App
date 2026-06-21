import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsApp(
  BuildContext context, {
  required String phoneNumber,
  required String message,
}) async {
  final normalizedNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
  final uri = Uri.https('wa.me', '/$normalizedNumber', {'text': message});

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    return;
  }

  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('WhatsApp tidak dapat dibuka pada perangkat ini.'),
    ),
  );
}
