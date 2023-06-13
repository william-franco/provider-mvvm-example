// Package imports:
import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  const TodoModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      completed: json['completed'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['completed'] = completed;
    return data;
  }

  @override
  List<Object?> get props => [
        userId,
        id,
        title,
        completed,
      ];
}
