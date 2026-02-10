import 'package:flutter/material.dart';

/// Localization strings for date and time pickers.
class PickerLocalizations {
  final String quickChoices;
  final String showMore;
  final String customTime;
  final String selectedTimes;
  final List<String> weekDays;
  final String localeCode;

  const PickerLocalizations({
    required this.quickChoices,
    required this.showMore,
    required this.customTime,
    required this.selectedTimes,
    required this.weekDays,
    required this.localeCode,
  });

  /// English localization
  static const english = PickerLocalizations(
    quickChoices: 'Quick choices:',
    showMore: 'Show more',
    customTime: 'Custom time',
    selectedTimes: 'Selected times:',
    weekDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    localeCode: 'en',
  );

  /// Italian localization
  static const italian = PickerLocalizations(
    quickChoices: 'Scelte rapide:',
    showMore: 'Mostra di più',
    customTime: 'Orario personalizzato',
    selectedTimes: 'Orari selezionati:',
    weekDays: ['Lun', 'Mar', 'Mer', 'Gio', 'Ven', 'Sab', 'Dom'],
    localeCode: 'it',
  );

  /// French localization
  static const french = PickerLocalizations(
    quickChoices: 'Choix rapides:',
    showMore: 'Afficher plus',
    customTime: 'Heure personnalisée',
    selectedTimes: 'Heures sélectionnées:',
    weekDays: ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
    localeCode: 'fr',
  );

  /// Spanish localization
  static const spanish = PickerLocalizations(
    quickChoices: 'Opciones rápidas:',
    showMore: 'Mostrar más',
    customTime: 'Hora personalizada',
    selectedTimes: 'Horas seleccionadas:',
    weekDays: ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
    localeCode: 'es',
  );

  /// Portuguese localization
  static const portuguese = PickerLocalizations(
    quickChoices: 'Escolhas rápidas:',
    showMore: 'Mostrar mais',
    customTime: 'Hora personalizada',
    selectedTimes: 'Horários selecionados:',
    weekDays: ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'],
    localeCode: 'pt',
  );

  /// German localization
  static const german = PickerLocalizations(
    quickChoices: 'Schnellauswahl:',
    showMore: 'Mehr anzeigen',
    customTime: 'Benutzerdefinierte Zeit',
    selectedTimes: 'Ausgewählte Zeiten:',
    weekDays: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
    localeCode: 'de',
  );

  /// Get localization based on locale code
  static PickerLocalizations fromLocale(String localeCode) {
    final code = localeCode.toLowerCase().split('_').first;
    switch (code) {
      case 'it':
        return italian;
      case 'fr':
        return french;
      case 'es':
        return spanish;
      case 'pt':
        return portuguese;
      case 'de':
        return german;
      case 'en':
      default:
        return english;
    }
  }

  /// Get localization from BuildContext
  static PickerLocalizations of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return fromLocale(locale.languageCode);
  }
}
