import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/todo_model.dart';
import '../controllers/todo_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_text_field.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  String _selectedCategory = "Work";

  DateTime _startDate = DateTime.now();
  DateTime _deadlineDate =
  DateTime.now().add(const Duration(days: 1));

  final List<String> _categories = [
    "Work",
    "Personal",
    "Study",
    "Fitness",
  ];

  Future<void> _selectDate(
      BuildContext context,
      bool isStart,
      ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? _startDate
          : _deadlineDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;

          if (_deadlineDate.isBefore(_startDate)) {
            _deadlineDate =
                _startDate.add(const Duration(days: 1));
          }
        } else {
          _deadlineDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Create Task",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [

            const Text(
              "Create a new task",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Stay organized and productive.",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 28),

            CustomCard(
              child: Column(
                children: [

                  CustomTextField(
                    controller: _titleController,
                    labelText: "Task Title",
                    icon: Icons.title,
                  ),

                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: _descController,
                    labelText: "Description",
                    maxLines: 4,
                    icon: Icons.notes,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            CustomCard(
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Category",
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories
                    .map(
                      (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    _selectedCategory = v!;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: CustomCard(
                    onTap: () =>
                        _selectDate(context, true),
                    child: Column(
                      children: [

                        Icon(
                          Icons.calendar_today,
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          "Start Date",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          _startDate
                              .toString()
                              .split(" ")[0],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: CustomCard(
                    onTap: () =>
                        _selectDate(context, false),
                    child: Column(
                      children: [

                        Icon(
                          Icons.event_available,
                          color: Colors.redAccent,
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          "Deadline",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          _deadlineDate
                              .toString()
                              .split(" ")[0],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 35),

            Hero(
              tag: "addTodo",
              child: CustomButton(
                text: "Save Task",
                icon: Icons.save,

                gradientColors: const [

                  Color(0xff6C63FF),

                  Color(0xff03DAC6),

                ],

                onPressed: () {

                  if (_titleController.text.isEmpty) {
                    return;
                  }

                  final todo = TodoModel(
                    title: _titleController.text,
                    description:
                    _descController.text,
                    category:
                    _selectedCategory,
                    date: DateTime.now(),
                    startDate: _startDate,
                    deadlineDate:
                    _deadlineDate,
                    isCompleted: false,
                  );

                  Provider.of<TodoProvider>(
                    context,
                    listen: false,
                  ).addTodo(todo);

                  Navigator.pop(context);
                },
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}