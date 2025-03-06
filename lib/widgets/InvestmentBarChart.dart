import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InvestmentBarChart extends StatelessWidget {
  final List<Investment> investments;

  InvestmentBarChart({required this.investments});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles:
          AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                // Customize the title based on the value
                return Text(
                  investments[value.toInt()].projects_count,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                );
              },
            )
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true)
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: investments.asMap().entries.map((entry) {
          int index = entry.key;
          Investment investment = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: investment.amount,
                color: Colors.lightBlueAccent,
              ),
              BarChartRodData(
                toY: investment.interest_amount,
                color: Colors.greenAccent,
              ),
              BarChartRodData(
                toY: investment.year,
                color: Colors.pinkAccent,
              ),
            ],
            barsSpace: 4,
          );
        }).toList(),
      ),
    );
  }
}
class Investment {
  final String projects_count;
  final double amount;
  final double interest_amount;
  final double year;

  Investment({required this.projects_count, required this.amount, required this.interest_amount, required this.year});

  factory Investment.fromJson(Map<String, dynamic> json) {
    return Investment(
      projects_count: json['projects_count'],
      amount: json['amount'],
      interest_amount: json['interest_amount'],
      year: json['year'],
    );
  }
}
