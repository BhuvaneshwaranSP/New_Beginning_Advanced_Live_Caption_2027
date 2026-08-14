/*
1. PAGE NAME
   Analytics Usage Chart

2. PURPOSE
   Visualizes recent LinguaLive conversation usage.

3. DESCRIPTION
   Lightweight custom-painted line chart using local dummy data.

4. UI SECTIONS
   Chart title, trend summary, plotted usage, weekday labels.

5. NAVIGATION FLOW
   AnalyticsPage → AnalyticsUsageChart.

6. DYNAMIC COMPONENTS
   UsagePointEntity collection.

7. FUTURE BACKEND INTEGRATION
   Chart points will later be populated from time-series analytics.

8. TECHNOLOGIES USED
   Flutter Material 3 and CustomPainter.

9. REQUIRED DATA MODELS
   UsagePointEntity.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.show_chart.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None; static lightweight chart painting.

16. ACCESSIBILITY
    Chart summary and individual point semantics are supplied as text.

17. EDGE CASES
    Empty points, one point, zero values, and large text.

18. VALIDATION RULES
    Values are clamped to the chart's display range.

19. ERROR HANDLING
    Parent state handles missing data.

20. LOADING STATE
    Parent state handles loading.

21. EMPTY STATE
    Parent state handles empty data.

22. OFFLINE BEHAVIOUR
    Parent state handles offline state.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Single CustomPainter with simple path operations.

25. WIDGET TREE OVERVIEW
    Card → title → summary → chart → labels.

26. COMPLETE TESTING CHECKLIST
    Seven-point chart, empty points, zero values, responsive width,
    dark mode, semantics, and large text.
*/

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/entities/analytics_feature_entity.dart';

class AnalyticsUsageChart extends StatelessWidget {
  const AnalyticsUsageChart({super.key, required this.points});

  final List<UsagePointEntity> points;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (points.isEmpty) {
      return const SizedBox.shrink();
    }

    final average =
        points.fold<double>(0, (sum, point) => sum + point.value) /
        points.length;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
        child: Semantics(
          container: true,
          label:
              'Usage trend. Average usage ${average.toStringAsFixed(0)} percent.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Conversation activity',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your recent multilingual conversation rhythm',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 190,
                width: double.infinity,
                child: CustomPaint(
                  painter: _UsageChartPainter(
                    points: points,
                    color: theme.colorScheme.primary,
                    gridColor: theme.colorScheme.outlineVariant,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  for (final point in points)
                    Expanded(
                      child: Text(
                        point.label,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelSmall,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsageChartPainter extends CustomPainter {
  _UsageChartPainter({
    required this.points,
    required this.color,
    required this.gridColor,
  });

  final List<UsagePointEntity> points;
  final Color color;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    final chartHeight = size.height - 12;
    final chartWidth = size.width;
    final maxValue = math.max(
      100,
      points.fold<double>(
        0,
        (maximum, point) => math.max(maximum, point.value),
      ),
    );

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    for (var row = 0; row <= 4; row++) {
      final y = chartHeight * row / 4;
      canvas.drawLine(Offset(0, y), Offset(chartWidth, y), gridPaint);
    }

    if (points.length < 2) {
      return;
    }

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final linePath = Path();
    final fillPath = Path();

    for (var index = 0; index < points.length; index++) {
      final x = chartWidth * index / (points.length - 1);
      final normalized = (points[index].value / maxValue).clamp(0.0, 1.0);
      final y = chartHeight - (normalized * chartHeight);

      final point = Offset(x, y);

      if (index == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, chartHeight);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(point.dx, point.dy);
        fillPath.lineTo(point.dx, point.dy);
      }

      canvas.drawCircle(point, 4, Paint()..color = color);
    }

    fillPath.lineTo(chartWidth, chartHeight);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant _UsageChartPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.color != color ||
        oldDelegate.gridColor != gridColor;
  }
}
