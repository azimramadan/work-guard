import 'package:flutter/material.dart';
import 'package:work_guard/features/monthly_report/presentation/view/widgets/year_calendar.dart';

class MonthlyReportView extends StatelessWidget {
  const MonthlyReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthlyReportPage();
  }
}
// lib/pages/monthly_report_page.dart

class MonthlyReportPage extends StatelessWidget {
  // Example static data - replace with dynamic data fetching in a real app
  final EmployeeReport monthlyReport = EmployeeReport(
    monthYear: 'April 2025',
    daysPresent: 20,
    daysAbsent: 2,
    leaveDays: 1,
    totalViolations: 3,
    basicSalary: 6000.00,
    bonuses: 500.00,
    deductions: 150.00,
    netSalary: 6350.00, // basic + bonuses - deductions
    // Add evaluation data
    performanceRating: 4.5, // Example rating out of 5
    companySatisfaction: 'Highly Satisfied',
    evaluationComments:
        'Excellent performance this month, exceeding expectations.', // Optional comment
  );

  MonthlyReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Report'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16),
            MonthCalendarExample(),

            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Attendance Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      _buildReportRow(
                        icon: Icons.check_circle_outline,
                        iconColor: Colors.green,
                        label: 'Days Present',
                        value: '${monthlyReport.daysPresent} Days',
                        valueColor: Colors.green[700],
                      ),
                      Divider(indent: 16, endIndent: 16),
                      _buildReportRow(
                        icon: Icons.cancel_outlined,
                        iconColor: Colors.red,
                        label: 'Days Absent',
                        value: '${monthlyReport.daysAbsent} Days',
                        valueColor: Colors.red[700],
                      ),
                      Divider(indent: 16, endIndent: 16),
                      _buildReportRow(
                        icon: Icons.beach_access,
                        iconColor: Colors.blue,
                        label: 'Leave Days',
                        value:
                            '${monthlyReport.leaveDays} Day${monthlyReport.leaveDays != 1 ? 's' : ''}',
                        valueColor: Colors.blue[700],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),

            // Violations Summary Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Violations Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildReportRow(
                    icon: Icons.warning_amber_outlined,
                    iconColor: Colors.orange,
                    label: 'Total Violations',
                    value:
                        '${monthlyReport.totalViolations} Violation${monthlyReport.totalViolations != 1 ? 's' : ''}',
                    valueColor: Colors.orange[700],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),

            // Salary Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Salary Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      _buildReportRow(
                        icon: Icons.credit_card,
                        iconColor: Colors.teal,
                        label: 'Basic Salary',
                        value:
                            '${monthlyReport.basicSalary.toStringAsFixed(2)} EGP',
                        valueColor: Colors.teal[700],
                      ),
                      Divider(indent: 16, endIndent: 16),
                      _buildReportRow(
                        icon: Icons.add_circle_outline,
                        iconColor: Colors.green,
                        label: 'Bonuses',
                        value:
                            '${monthlyReport.bonuses.toStringAsFixed(2)} EGP',
                        valueColor: Colors.green[700],
                      ),
                      Divider(indent: 16, endIndent: 16),
                      _buildReportRow(
                        icon: Icons.remove_circle_outline,
                        iconColor: Colors.red,
                        label: 'Deductions',
                        value:
                            '${monthlyReport.deductions.toStringAsFixed(2)} EGP',
                        valueColor: Colors.red[700],
                      ),
                      Divider(indent: 16, endIndent: 16),
                      _buildReportRow(
                        icon: Icons.account_balance_wallet_outlined,
                        iconColor: Colors.blue,
                        label: 'Net Salary',
                        value:
                            '${monthlyReport.netSalary.toStringAsFixed(2)} EGP',
                        valueColor: Colors.blue[700],
                        isNetSalary: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),

            // Performance Evaluation Section (NEW)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Performance Evaluation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      _buildReportRow(
                        icon: Icons.star_half_outlined,
                        iconColor: Colors.amber,
                        label: 'Performance Rating',
                        value:
                            '${monthlyReport.performanceRating.toStringAsFixed(1)} / 5', // Display rating
                        valueColor: Colors.amber[800],
                      ),
                      Divider(indent: 16, endIndent: 16),
                      _buildReportRow(
                        icon: Icons.sentiment_satisfied_alt_outlined,
                        iconColor: Colors.lightGreen,
                        label: 'Company Satisfaction',
                        value:
                            monthlyReport
                                .companySatisfaction, // Display satisfaction text
                        valueColor: Colors.lightGreen[800],
                      ),
                      if (monthlyReport.evaluationComments != null &&
                          monthlyReport.evaluationComments!.isNotEmpty) ...[
                        Divider(indent: 16, endIndent: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Comments:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                monthlyReport.evaluationComments!,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Add more sections as needed
          ],
        ),
      ),
    );
  }

  // Helper widget to build a single row in the report
  Widget _buildReportRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    Color? valueColor,
    bool isNetSalary = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isNetSalary ? FontWeight.bold : FontWeight.normal,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
// lib/models/employee_report.dart

class EmployeeReport {
  final String monthYear;

  // Attendance Summary
  final int daysPresent;
  final int daysAbsent;
  final int leaveDays;

  // Violations Summary
  final int totalViolations;

  // Salary Details
  final double basicSalary;
  final double bonuses;
  final double deductions;
  final double netSalary;

  // New fields for Evaluation
  final double performanceRating; // e.g., out of 5 or 10
  final String
  companySatisfaction; // e.g., "Highly Satisfied", "Satisfied", etc.
  final String? evaluationComments; // Optional comments

  EmployeeReport({
    required this.monthYear,
    required this.daysPresent,
    required this.daysAbsent,
    required this.leaveDays,
    required this.totalViolations,
    required this.basicSalary,
    required this.bonuses,
    required this.deductions,
    required this.netSalary,
    required this.performanceRating,
    required this.companySatisfaction,
    this.evaluationComments,
  });

  // In a real app, you would add a factory constructor like fromJson
  // to parse data received from an API.
}
