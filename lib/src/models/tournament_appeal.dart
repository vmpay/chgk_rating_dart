import 'dart:convert';

import 'tournament_controversial.dart';

/// Response example:
/// ```json
/// [
/// {
///     "type": "A",
///     "question_number": "1",
///     "issued_at": "2018-12-11 23:09:01",
///     "status": "D",
///     "appeal": "Мы считаем, что ответ \"Руководитель палаты мер и весов\" целиком и полностью свидетельствует о проникновении командой в логику вопроса, а явного требования назвать фамилию человека в вопросе дано не было. Из комментария к вопросу, а также из комментария к одному из незасчитанных спорных ответов, прямо следует, что функцией новгородского владыки также являлось хранение этанолов мер и весов. Функцию хранения этанолов мер и весов в России в XIX и XX веке выполнял Управляющий Главной палатой мер и весов.\r\n\r\nВ соответствии с п. 2.1.1 Кодекса спортивного \"Что?Где?Когда?\", ответ команды считается правильным, если он <...> соответствует форме вопроса и требованиям к формулировке ответа и при этом может быть интерпретирован как развернутый ответ, т.е. включает авторский или эквивалентный ему ответ, а также дополнительную информацию, которая не может быть принята за другой ответ, не противоречит содержанию вопроса и не содержит грубых фактических ошибок.\r\n\r\nПросим апелляционное жюри зачесть наш ответ как правильный. Спасибо.",
///     "comment": "Отклонить 2:1 (АВ, РХ — за отклонение; ИИ — за принятие).\r\rСогласно пункту 2.1.4.2 Кодекса, описательный ответ (в котором вместо наименования объекта или субъекта даются его свойства), как правило, засчитываться не должен.",
///     "resolved_at": "2018-12-19 18:36:59",
///     "answer": "Руководитель палаты мер и весов"
/// },
/// {
///     "type": "A",
///     "question_number": "5",
///     "issued_at": "2018-12-12 01:39:54",
///     "status": "D",
///     "appeal": "Судя по выдаче поисковиковых машин, \"Нибиру\" является распространённым обозначением для гипотетической планеты Солнечной Системы за Нептуном. В тексте нет отсечек для авторского ответа на первый подвопрос, за исключением каламбура с римской цифрой X. Проникновение в логику у команды явно присутствует.",
///     "comment": "Отклонить 3:0.\r\rНаименование «Нибиру» в данном контексте нельзя считать эквивалентом «Планеты X». В общем случае Нибиру означает конкретную планету из вселенной Захарии Ситчина, реально не наблюдаемую с Земли, а описанную только теоретически. С другой стороны, под планетой X в общем случае подразумевают некую неизвестную планету дальше Нептуна. Свойства и факты, приписываемые Нибиру (местообитание человекоподобной расы аннунаков, столкновение с планетой Тиамат и формирование в результате этого планеты Земля), не совпадают со свойствами и фактами, приписываемыми планете X.",
///     "resolved_at": "2018-12-19 18:37:30",
///     "answer": "1) Нибиру, 2) Солнечная система"
/// }
/// ]
/// ```
class TournamentAppeal {
  TournamentAppeal({
    this.type,
    this.questionNumber,
    this.issuedAt,
    this.status,
    this.appeal,
    this.comment,
    this.resolvedAt,
    this.answer,
  });

  final Type? type;
  final String? questionNumber;
  final DateTime? issuedAt;
  final QuestionStatus? status;
  final String? appeal;
  final String? comment;
  final DateTime? resolvedAt;
  final String? answer;

  /// Decodes [TournamentAppeal] object from json string
  factory TournamentAppeal.fromJson(String str) =>
      TournamentAppeal.fromMap(json.decode(str));

  /// Encodes [TournamentAppeal] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [TournamentAppeal] object from json map
  factory TournamentAppeal.fromMap(Map<String, dynamic> json) =>
      TournamentAppeal(
        type: json['type'] == null ? null : typeValues.map[json['type']],
        questionNumber:
            json['question_number'] == null ? null : json['question_number'],
        issuedAt: json['issued_at'] == null
            ? null
            : DateTime.parse(json['issued_at']),
        status:
            json['status'] == null ? null : statusValues.map[json['status']],
        appeal: json['appeal'] == null ? null : json['appeal'],
        comment: json['comment'] == null ? null : json['comment'],
        resolvedAt: json['resolved_at'] == null
            ? null
            : DateTime.parse(json['resolved_at']),
        answer: json['answer'] == null ? null : json['answer'],
      );

  /// Encodes [TournamentAppeal] object to json map
  Map<String, dynamic> toMap() => {
        'type': type == null ? null : typeValues.reverse[type],
        'question_number': questionNumber == null ? null : questionNumber,
        'issued_at': issuedAt == null ? null : issuedAt?.toIso8601String(),
        'status': status == null ? null : statusValues.reverse[status],
        'appeal': appeal == null ? null : appeal,
        'comment': comment == null ? null : comment,
        'resolved_at':
            resolvedAt == null ? null : resolvedAt?.toIso8601String(),
        'answer': answer == null ? null : answer,
      };

  @override
  String toString() {
    return 'TournamentAppeal{type: $type, questionNumber: $questionNumber, issuedAt: $issuedAt, status: $status, appeal: $appeal, comment: $comment, resolvedAt: $resolvedAt, answer: $answer}';
  }
}

/// [A] - approved, [R] - rejected
enum Type { A, R }

/// [Type.A] - approved, [Type.R] - rejected
final EnumValues<Type> typeValues =
    EnumValues<Type>({'A': Type.A, 'R': Type.R});
