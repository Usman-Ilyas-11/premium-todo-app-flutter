import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/todo_provider.dart';
import '../widgets/custom_card.dart';
import '../widgets/todo_tile.dart';
import 'create_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String userName = "User";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    print("Loaded Username: ${prefs.getString("userName")}");
    print("Loaded Email: ${prefs.getString("email")}");

    setState(() {
      userName = prefs.getString("userName") ?? "User";
      userEmail = prefs.getString("email") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TodoProvider>(context);

    final total = provider.todos.length;
    final completed =
        provider.todos.where((e) => e.isCompleted).length;
    final pending = total - completed;

    return Scaffold(
      backgroundColor: Colors.transparent,

      floatingActionButton: FloatingActionButton.extended(
        heroTag: "addTodo",
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("New Task"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateTodoScreen(),
            ),
          );
        },
      ),

      body: SafeArea(
        child: provider.isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Column(
          children: [

            /// HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  10),
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Hello 👋",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        if (userEmail.isNotEmpty)
                          Text(
                            userEmail,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),

                  Hero(
                    tag: "profile",

                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor:
                      Theme.of(context)
                          .colorScheme
                          .primary,

                      child: Text(
                        userName
                            .substring(0, 1)
                            .toUpperCase(),

                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// STATISTICS

            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16),
              child: Row(
                children: [

                  Expanded(
                    child: CustomCard(
                      child: Column(
                        children: [

                          Text(
                            total.toString(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                              "Total Tasks"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: CustomCard(
                      child: Column(
                        children: [

                          Text(
                            completed.toString(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                              "Completed"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: CustomCard(
                      child: Column(
                        children: [

                          Text(
                            pending.toString(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                              "Pending"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            Expanded(
              child: provider.todos.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [

                    Icon(
                      Icons.task_alt,
                      size: 90,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "No Tasks Yet",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Tap the button below to create your first task.",
                      textAlign:
                      TextAlign.center,
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding:
                const EdgeInsets.only(
                    bottom: 90),

                itemCount:
                provider.todos.length,

                itemBuilder:
                    (_, index) {

                  final todo =
                  provider.todos[index];

                  return TodoTile(
                    todo: todo,

                    onChanged: (_) =>
                        provider
                            .updateTodoStatus(
                            todo),

                    onDelete: () =>
                        provider
                            .deleteTodo(
                            todo.id!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}