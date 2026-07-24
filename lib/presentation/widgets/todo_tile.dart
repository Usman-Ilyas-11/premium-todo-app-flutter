import 'dart:ui';
import 'package:flutter/material.dart';
import '../../data/models/todo_model.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;
  final Function(bool?) onChanged;
  final VoidCallback onDelete;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final deadline =
    todo.deadlineDate.toLocal().toString().split(' ')[0];

    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12,
            sigmaY: 12,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(22),
              splashColor: primary.withOpacity(.15),
              onTap: () {},
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(.06)
                      : Colors.white.withOpacity(.78),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withOpacity(.18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    /// Checkbox
                    Transform.scale(
                      scale: 1.15,
                      child: Checkbox(
                        value: todo.isCompleted,
                        activeColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(6),
                        ),
                        onChanged: onChanged,
                      ),
                    ),

                    const SizedBox(width: 14),

                    /// Avatar
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primary,
                            primary.withOpacity(.65),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.task_alt_rounded,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          /// Title
                          Text(
                            todo.title,
                            style: TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 17,
                              decoration:
                              todo.isCompleted
                                  ? TextDecoration
                                  .lineThrough
                                  : null,
                              color:
                              todo.isCompleted
                                  ? Colors.grey
                                  : null,
                            ),
                          ),

                          if (todo.description
                              .isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              todo.description,
                              maxLines: 2,
                              overflow:
                              TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],

                          const SizedBox(height: 14),

                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [

                              Chip(
                                avatar: const Icon(
                                  Icons.folder,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  todo.category,
                                  style:
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                                backgroundColor: primary,
                              ),

                              Chip(
                                avatar: const Icon(
                                  Icons.calendar_today,
                                  size: 15,
                                ),
                                label: Text(
                                  deadline,
                                  style:
                                  const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),

                              Chip(
                                avatar: Icon(
                                  todo.isCompleted
                                      ? Icons.check_circle
                                      : Icons.timelapse,
                                  size: 16,
                                  color:
                                  todo.isCompleted
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                                label: Text(
                                  todo.isCompleted
                                      ? "Completed"
                                      : "Pending",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    IconButton(
                      splashRadius: 22,
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                      ),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}