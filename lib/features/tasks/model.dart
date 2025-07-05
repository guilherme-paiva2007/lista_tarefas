import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';

abstract class Task {
  final String title;
  final DateTime createdAt;
  final MaterialColor color;
  final IconData icon;

  const Task({
    required this.title,
    required this.createdAt,
    required this.color,
    required this.icon,
  });

  static final List<TaskColorRecord> colorsList = List.unmodifiable(<TaskColorRecord>[
    (name: "purple", displayName: "Roxo", color: AppPrimaryColors.purple),
    (name: "indigo", displayName: "Índigo", color: AppPrimaryColors.indigo),
    (name: "blue", displayName: "Azul", color: AppPrimaryColors.blue),
    (name: "aqua", displayName: "Aqua", color: AppPrimaryColors.aqua),
    (name: "green", displayName: "Verde", color: AppSecondaryColors.green),
    (name: "lime", displayName: "Lima", color: AppSecondaryColors.lime),
    (name: "gold", displayName: "Amarelo", color: AppSecondaryColors.gold),
    (name: "orange", displayName: "Laranja", color: AppSecondaryColors.orange),
    (name: "red", displayName: "Vermelho", color: AppSecondaryColors.red),
  ]);
  static final Map colorsMap = Map.unmodifiable(Map.fromEntries(colorsList.map((colorRecord) {
    return MapEntry<String, MaterialColor>(colorRecord.name, colorRecord.color);
  })));

  static final List<TaskIconRecord> iconsList = List.unmodifiable(<TaskIconRecord>[
    (name: "social", displayName: "Social", icon: FontAwesomeIcons.userGroup),
    (name: "personal", displayName: "Pessoal", icon: FontAwesomeIcons.user),
    (name: "house", displayName: "Casa", icon: FontAwesomeIcons.house),
    (name: "work", displayName: "Trabalho", icon: FontAwesomeIcons.briefcase),
    (name: "meeting", displayName: "Reunião", icon: FontAwesomeIcons.handshake),
    (name: "project", displayName: "Projeto", icon: FontAwesomeIcons.folderOpen),
    (name: "deadline", displayName: "Prazo", icon: FontAwesomeIcons.clock),
    (name: "study", displayName: "Estudos", icon: FontAwesomeIcons.graduationCap),
    (name: "reading", displayName: "Leitura", icon: FontAwesomeIcons.book),
    (name: "health", displayName: "Saúde", icon: FontAwesomeIcons.stethoscope),
    (name: "exercise", displayName: "Exercício", icon: FontAwesomeIcons.dumbbell),
    (name: "sport", displayName: "Esporte", icon: FontAwesomeIcons.volleyball),
    (name: "nature", displayName: "Natureza", icon: FontAwesomeIcons.seedling),
    (name: "money", displayName: "Finanças", icon: FontAwesomeIcons.dollarSign),
    (name: "shopping", displayName: "Compras", icon: FontAwesomeIcons.cartShopping),
    (name: "investment", displayName: "Investimento", icon: FontAwesomeIcons.chartLine),
    (name: "home", displayName: "Casa", icon: FontAwesomeIcons.house),
    (name: "cleaning", displayName: "Limpeza", icon: FontAwesomeIcons.broom),
    (name: "cooking", displayName: "Cozinha", icon: FontAwesomeIcons.utensils),
    (name: "paint", displayName: "Pintura", icon: FontAwesomeIcons.paintbrush),
    (name: "repair", displayName: "Reparo", icon: FontAwesomeIcons.hammer),
    (name: "travel", displayName: "Viagem", icon: FontAwesomeIcons.plane),
    (name: "car", displayName: "Carro", icon: FontAwesomeIcons.car),
    (name: "flask", displayName: "Ciência", icon: FontAwesomeIcons.flask),
    (name: "tech", displayName: "Tecnologia", icon: FontAwesomeIcons.laptop),
    (name: "code", displayName: "Código", icon: FontAwesomeIcons.code),
    (name: "password", displayName: "Senhas", icon: FontAwesomeIcons.lock),
    (name: "cloud", displayName: "Nuvem", icon: FontAwesomeIcons.cloud),
    (name: "sun", displayName: "Sol", icon: FontAwesomeIcons.sun),
    (name: "moon", displayName: "Lua", icon: FontAwesomeIcons.moon),
    (name: "entertainment", displayName: "Entretenimento", icon: FontAwesomeIcons.film),
    (name: "music", displayName: "Música", icon: FontAwesomeIcons.music),
    (name: "games", displayName: "Jogos", icon: FontAwesomeIcons.gamepad),
    (name: "photography", displayName: "Fotografia", icon: FontAwesomeIcons.camera),
    (name: "email", displayName: "E-mail", icon: FontAwesomeIcons.solidEnvelope),
    (name: "call", displayName: "Ligação", icon: FontAwesomeIcons.mobile),
    (name: "message", displayName: "Mensagem", icon: FontAwesomeIcons.solidComment),
    (name: "newsletter", displayName: "Newsletter", icon: FontAwesomeIcons.newspaper),
    (name: "birthday", displayName: "Aniversário", icon: FontAwesomeIcons.cakeCandles),
    (name: "anniversary", displayName: "Aniversário", icon: FontAwesomeIcons.solidHeart),
    (name: "event", displayName: "Evento", icon: FontAwesomeIcons.calendar),
    (name: "urgent", displayName: "Urgente", icon: FontAwesomeIcons.triangleExclamation),
    (name: "important", displayName: "Importante", icon: FontAwesomeIcons.solidStar),
    (name: "reminder", displayName: "Lembrete", icon: FontAwesomeIcons.solidBell),
    (name: "note", displayName: "Nota", icon: FontAwesomeIcons.solidNoteSticky),
  ]);
  static final Map iconsMap = Map.unmodifiable(Map.fromEntries(iconsList.map((iconRecord) {
    return MapEntry<String, IconData>(iconRecord.name, iconRecord.icon);
  })));
}

typedef TaskColorRecord = ({ String name, String displayName, MaterialColor color });
typedef TaskIconRecord = ({ String name, String displayName, IconData icon });

class MultiEventTask extends Task {
  final DateTime? startDate;
  final DateTime? endDate;

  const MultiEventTask({
    required super.title,
    required super.createdAt,
    required super.color,
    required super.icon,
    this.startDate,
    this.endDate,
  });
}

class SingleDayEvent extends Task {
  final DateTime? startDate;
  final DateTime? endDate;

  const SingleDayEvent({
    required super.title,
    required super.createdAt,
    required super.color,
    required super.icon,
    this.startDate,
    this.endDate,
  });
}

enum EventTypes {
  multiDayEvent("multi-day-event"),
  singleDayEvent("single-day-event"),
  toDoList("to-do-list");

  final String title;

  const EventTypes(this.title);
}