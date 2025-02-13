// lib/screens/predictions/prediction_chart.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expensepredict/constants/colors.dart';

class PredictionChart extends StatelessWidget {
  const PredictionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: 1,
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(
                        color: Color(0xff68737d),
                        fontSize: 12,
                      );
                      Widget text;
                      switch (value.toInt()) {
                        case 0:
                          text = const Text('JAN', style: style);
                          break;
                        case 2:
                          text = const Text('MAR', style: style);
                          break;
                        case 4:
                          text = const Text('MAY', style: style);
                          break;
                        case 6:
                          text = const Text('JUL', style: style);
                          break;
                        default:
                          text = const Text('', style: style);
                          break;
                      }
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: text,
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '${value.toInt()}M',
                        style: const TextStyle(
                          color: Color(0xff67727d),
                          fontSize: 12,
                        ),
                      );
                    },
                    reservedSize: 42,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              minX: 0,
              maxX: 6,
              minY: 0,
              maxY: 6,
              lineBarsData: [
                // Actual Data
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 3),
                    FlSpot(1, 2.5),
                    FlSpot(2, 3.1),
                    FlSpot(3, 3.2),
                  ],
                  isCurved: true,
                  color: AppColors.teal,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: AppColors.teal.withOpacity(0.2),
                  ),
                ),
                // Predicted Data
                LineChartBarData(
                  spots: const [
                    FlSpot(3, 3.2),
                    FlSpot(4, 3.3),
                    FlSpot(5, 3.5),
                    FlSpot(6, 3.7),
                  ],
                  isCurved: true,
                  color: AppColors.warmOrange,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: true),
                  dashArray: [5, 5],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(AppColors.teal, 'Data Aktual'),
              const SizedBox(width: 20),
              _buildLegendItem(AppColors.warmOrange, 'Prediksi'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}