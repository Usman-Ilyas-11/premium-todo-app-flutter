import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/todo_provider.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All Time';

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodoProvider>(context).todos;

    // Filter calculations
    final now = DateTime.now();
    List filteredTodos = todos.where((t) {
      if (_selectedFilter == 'Weekly') {
        return t.date.isAfter(now.subtract(const Duration(days: 7)));
      } else if (_selectedFilter == 'Monthly') {
        return t.date.month == now.month && t.date.year == now.year;
      } else if (_selectedFilter == 'Yearly') {
        return t.date.year == now.year;
      }
      return true;
    }).toList();

    int totalTasks = filteredTodos.length;
    int completedTasks = filteredTodos.where((t) => t.isCompleted).length;
    int pendingTasks = totalTasks - completedTasks;
    double completionRate = totalTasks == 0 ? 0 : completedTasks / totalTasks;

    Map<String, int> categoryCounts = {};
    for (var t in filteredTodos) {
      categoryCounts[t.category] = (categoryCounts[t.category] ?? 0) + 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphical Analytics'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              value: _selectedFilter,
              underline: const SizedBox(),
              items: ['All Time', 'Weekly', 'Monthly', 'Yearly']
                  .map((val) => DropdownMenuItem(value: val, child: Text(val, style: const TextStyle(fontWeight: FontWeight.bold))))
                  .toList(),
              onChanged: (val) => setState(() => _selectedFilter = val!),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Gradient Overview Banner with Ripple/Shadow effect
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF03DAC6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$_selectedFilter Performance', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetricBadge('Total', totalTasks.toString(), Icons.list_alt),
                      _buildMetricBadge('Done', completedTasks.toString(), Icons.check_circle_outline),
                      _buildMetricBadge('Pending', pendingTasks.toString(), Icons.pending_actions),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Completion Progress', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: completionRate,
                      minHeight: 10,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text('Category-wise Graphical Breakdowns', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (categoryCounts.isEmpty)
              const Center(child: Padding(padding: EdgeInsets.all(32.0), child: Text('No data available for this timeframe.')))
            else
              ...categoryCounts.entries.map((entry) {
                double catPercentage = totalTasks == 0 ? 0 : entry.value / totalTasks;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('${entry.value} Tasks (${(catPercentage * 100).toStringAsFixed(1)}%)', style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: catPercentage,
                          minHeight: 8,
                          backgroundColor: Colors.grey.withOpacity(0.15),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            entry.key == 'Work'
                                ? const Color(0xFF6C63FF)
                                : entry.key == 'Personal'
                                ? const Color(0xFF03DAC6)
                                : const Color(0xFFFF6584),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricBadge(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}