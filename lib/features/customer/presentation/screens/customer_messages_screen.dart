import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/customer_shell.dart';
import '../widgets/customer_widgets.dart';

class CustomerMessagesScreen extends StatelessWidget {
  const CustomerMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomerShell(
      currentIndex: 2,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: const [
            CustomerHeader(
              title: 'Pesan',
              subtitle: 'Percakapan dengan teknisi dan admin SiTeknisi.',
            ),
            SizedBox(height: AppSpacing.lg),
            _MessageTile(
              name: 'Andi Kurniawan',
              role: 'Teknisi AC',
              message: 'Saya sedang menuju lokasi ya, estimasi 10 menit.',
              time: '10:30',
              unread: 2,
            ),
            SizedBox(height: AppSpacing.sm),
            _MessageTile(
              name: 'Admin SiTeknisi',
              role: 'Customer Support',
              message: 'Invoice otomatis tersedia setelah servis selesai.',
              time: '09:12',
              unread: 0,
            ),
            SizedBox(height: AppSpacing.sm),
            _MessageTile(
              name: 'Rina Wijaya',
              role: 'Teknisi Elektronik',
              message: 'Terima kasih, jangan lupa beri rating layanan.',
              time: 'Kemarin',
              unread: 0,
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    required this.name,
    required this.role,
    required this.message,
    required this.time,
    required this.unread,
  });

  final String name;
  final String role;
  final String message;
  final String time;
  final int unread;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: AppColors.primaryLight,
          child: Text(name.characters.first),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium,
              ),
            ),
            Text(
              time,
              style: textTheme.labelMedium?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xxs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                role,
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(message, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        trailing: unread == 0
            ? const Icon(Icons.chevron_right_rounded)
            : Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppRadius.pill,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$unread',
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.surface,
                  ),
                ),
              ),
      ),
    );
  }
}
