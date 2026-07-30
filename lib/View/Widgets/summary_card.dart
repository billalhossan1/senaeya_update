import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final Widget icon;
  final String value;
  final String label;
  final TextStyle? valueStyle;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final Widget? trailing;

  const SummaryCard({
    Key? key,
    required this.icon,
    required this.value,
    required this.label,
    this.valueStyle,
    this.labelStyle,
    this.padding,
    this.borderColor,
    this.borderRadius = 8,
    this.borderWidth = 2,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Colors.grey.shade300, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 4),
              Text(value, style: valueStyle),
              if (trailing != null) ...[
                const Spacer(),
                trailing!,
              ],
            ],
          ),
          Text(label, style: labelStyle),
        ],
      ),
    );
  }
}

