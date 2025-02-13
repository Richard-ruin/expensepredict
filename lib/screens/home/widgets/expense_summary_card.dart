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

// lib/screens/predictions/prediction_summary.dart
class PredictionSummary extends StatelessWidget {
  const PredictionSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPredictionCard(
          title: 'Prediksi Minggu Depan',
          amount: 'Rp 2.500.000',
          trend: 0.05,
          isIncrease: true,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInsightCard(
                title: 'Pengeluaran Tertinggi',
                category: 'Makanan',
                amount: 'Rp 800.000',
                icon: Icons.restaurant,
                color: AppColors.softRed,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInsightCard(
                title: 'Kategori Terbanyak',
                category: 'Transport',
                amount: '15 transaksi',
                icon: Icons.directions_car,
                color: AppColors.warmOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPredictionCard({
    required String title,
    required String amount,
    required double trend,
    required bool isIncrease,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.darkBlue,
                )),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      isIncrease
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: isIncrease ? AppColors.softRed : AppColors.teal,
                      size: 16,
                    ),
                    Text(
                      '${(trend * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: isIncrease ? AppColors.softRed : AppColors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard({
    required String title,
    required String category,
    required String amount,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                )),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          )),
                      Text(amount,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// lib/screens/home/widgets/expense_insight_chart.dart
class ExpenseInsightChart extends StatelessWidget {
  const ExpenseInsightChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.blueGrey,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  'Rp ${rod.toY.round()}K',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
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
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  );
                  String text;
                  switch (value.toInt()) {
                    case 0:
                      text = 'Sen';
                      break;
                    case 1:
                      text = 'Sel';
                      break;
                    case 2:
                      text = 'Rab';
                      break;
                    case 3:
                      text = 'Kam';
                      break;
                    case 4:
                      text = 'Jum';
                      break;
                    case 5:
                      text = 'Sab';
                      break;
                    case 6:
                      text = 'Min';
                      break;
                    default:
                      text = '';
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(text, style: style),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value == 0) return const Text('');
                  return Text('${value.toInt()}K',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ));
                },
                reservedSize: 40,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            horizontalInterval: 5,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
          ),
          barGroups: [
            _generateBarGroup(0, 12, AppColors.teal),
            _generateBarGroup(1, 8, AppColors.teal),
            _generateBarGroup(2, 15, AppColors.teal),
            _generateBarGroup(3, 10, AppColors.teal),
            _generateBarGroup(4, 18, AppColors.softRed),
            _generateBarGroup(5, 14, AppColors.teal),
            _generateBarGroup(6, 6, AppColors.teal),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _generateBarGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }
}