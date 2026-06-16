import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import 'status_chip.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({
    required this.invoiceNumber,
    required this.serviceName,
    required this.totalAmount,
    required this.dateText,
    super.key,
    this.statusLabel = 'Lunas',
    this.statusType = StatusChipType.success,
    this.onTap,
  });

  final String invoiceNumber;
  final String serviceName;
  final String totalAmount;
  final String dateText;
  final String statusLabel;
  final StatusChipType statusType;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.large,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: AppRadius.medium,
                    ),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(invoiceNumber, style: textTheme.titleMedium),
                        Text(
                          dateText,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StatusChip(label: statusLabel, type: statusType),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                serviceName,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(totalAmount, style: textTheme.headlineLarge),
            ],
          ),
        ),
      ),
    );
  }
}
