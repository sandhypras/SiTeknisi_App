import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

class MobileFlowStepper extends StatelessWidget {
  const MobileFlowStepper({
    required this.steps,
    required this.currentStep,
    super.key,
  });

  final List<String> steps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    assert(steps.length > 1);
    assert(currentStep >= 0 && currentStep < steps.length);
    return Semantics(
      label: 'Langkah ${currentStep + 1} dari ${steps.length}',
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppRadius.large,
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var index = 0; index < steps.length; index++) ...[
              Expanded(
                child: _StepItem(
                  number: index + 1,
                  label: steps[index],
                  active: index == currentStep,
                  completed: index < currentStep,
                ),
              ),
              if (index != steps.length - 1)
                _StepConnector(completed: index < currentStep),
            ],
          ],
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  const _StepItem({
    required this.number,
    required this.label,
    required this.active,
    required this.completed,
  });

  final int number;
  final String label;
  final bool active;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final highlighted = active || completed;
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: completed
                ? AppColors.success
                : active
                ? AppColors.primary
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: AppRadius.pill,
          ),
          child: Center(
            child: completed
                ? const Icon(Icons.check_rounded, size: 18, color: Colors.white)
                : Text(
                    '$number',
                    style: TextStyle(
                      color: active
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        SizedBox(
          height: 32,
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: highlighted
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: active ? FontWeight.w800 : FontWeight.w600,
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepConnector extends StatelessWidget {
  const _StepConnector({required this.completed});

  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 2,
      margin: const EdgeInsets.only(top: 14),
      color: completed
          ? AppColors.success
          : Theme.of(context).colorScheme.outlineVariant,
    );
  }
}
