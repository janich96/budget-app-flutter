import 'package:flutter/material.dart';

enum AppLanguage { ru, en }

class AppLocalizations {
  final AppLanguage language;

  const AppLocalizations(this.language);

  static const supportedLanguages = [AppLanguage.ru, AppLanguage.en];

  static AppLocalizations of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return AppLocalizations.fromLocale(locale);
  }

  static AppLocalizations fromLocale(Locale locale) {
    return switch (locale.languageCode) {
      'en' => const AppLocalizations(AppLanguage.en),
      _ => const AppLocalizations(AppLanguage.ru),
    };
  }

  Locale get locale => switch (language) {
        AppLanguage.ru => const Locale('ru'),
        AppLanguage.en => const Locale('en'),
      };

  String get appName => switch (language) {
        AppLanguage.ru => 'Budget Tracker',
        AppLanguage.en => 'Budget Tracker',
      };

  String get signInWithGoogle => switch (language) {
        AppLanguage.ru => 'Войти через Google',
        AppLanguage.en => 'Sign in with Google',
      };

  String get tryDemoMode => switch (language) {
        AppLanguage.ru => 'Попробовать демо-режим',
        AppLanguage.en => 'Try demo mode',
      };

  String get russian => 'Русский';
  String get english => 'English';

  String get chooseLanguage => switch (language) {
        AppLanguage.ru => 'Язык',
        AppLanguage.en => 'Language',
      };

  String get dashboard => switch (language) {
        AppLanguage.ru => 'Сводка',
        AppLanguage.en => 'Dashboard',
      };
  String get expense => switch (language) {
        AppLanguage.ru => 'Расход',
        AppLanguage.en => 'Expense',
      };
  String get categories => switch (language) {
        AppLanguage.ru => 'Категории',
        AppLanguage.en => 'Categories',
      };
  String get history => switch (language) {
        AppLanguage.ru => 'История',
        AppLanguage.en => 'History',
      };
  String get settings => switch (language) {
        AppLanguage.ru => 'Настройки',
        AppLanguage.en => 'Settings',
      };

  String get loading => switch (language) {
        AppLanguage.ru => 'Инициализация...',
        AppLanguage.en => 'Loading...',
      };

  String error(String message) => switch (language) {
        AppLanguage.ru => 'Ошибка: $message',
        AppLanguage.en => 'Error: $message',
      };

  String get noAccumulationCategories => switch (language) {
        AppLanguage.ru =>
          'Нет категорий накоплений.\nДобавьте их во вкладке "Категории".',
        AppLanguage.en =>
          'No accumulation categories yet.\nAdd them in the "Categories" tab.',
      };

  String get lastPeriod => switch (language) {
        AppLanguage.ru => 'Последний период',
        AppLanguage.en => 'Last period',
      };

  String get mySavings => switch (language) {
        AppLanguage.ru => 'Мои накопления',
        AppLanguage.en => 'My savings',
      };

  String get subtract => switch (language) {
        AppLanguage.ru => 'Вычесть',
        AppLanguage.en => 'Subtract',
      };

  String get cancel => switch (language) {
        AppLanguage.ru => 'Отмена',
        AppLanguage.en => 'Cancel',
      };

  String get amount => switch (language) {
        AppLanguage.ru => 'Сумма',
        AppLanguage.en => 'Amount',
      };

  String get delete => switch (language) {
        AppLanguage.ru => 'Удалить',
        AppLanguage.en => 'Delete',
      };

  String get generalBalance => switch (language) {
        AppLanguage.ru => 'Общий баланс',
        AppLanguage.en => 'Total balance',
      };

  String get weekProgress => switch (language) {
        AppLanguage.ru => 'Потрачено за неделю',
        AppLanguage.en => 'Spent this week',
      };

  String get noWeeklyExpenses => switch (language) {
        AppLanguage.ru => 'На этой неделе еще нет трат',
        AppLanguage.en => 'No expenses for this week yet',
      };

  String get deductFrom => switch (language) {
        AppLanguage.ru => 'Вычесть из',
        AppLanguage.en => 'Subtract from',
      };

  String get theme => switch (language) {
        AppLanguage.ru => 'Тема приложения',
        AppLanguage.en => 'App theme',
      };

  String get user => switch (language) {
        AppLanguage.ru => 'Пользователь',
        AppLanguage.en => 'User',
      };

  String get loggedIn => switch (language) {
        AppLanguage.ru => 'Вы вошли в систему',
        AppLanguage.en => 'You are signed in',
      };

  String get version => switch (language) {
        AppLanguage.ru => 'Версия',
        AppLanguage.en => 'Version',
      };

  String get madeWithLove => switch (language) {
        AppLanguage.ru => 'Сделано с любовью к бюджету',
        AppLanguage.en => 'Made with love for budgeting',
      };

  String get signOut => switch (language) {
        AppLanguage.ru => 'Выйти из аккаунта',
        AppLanguage.en => 'Sign out',
      };

  String get chooseTheme => switch (language) {
        AppLanguage.ru => 'Выберите тему',
        AppLanguage.en => 'Choose a theme',
      };

  String get systemTheme => switch (language) {
        AppLanguage.ru => 'Системная',
        AppLanguage.en => 'System',
      };

  String get lightTheme => switch (language) {
        AppLanguage.ru => 'Светлая',
        AppLanguage.en => 'Light',
      };

  String get darkTheme => switch (language) {
        AppLanguage.ru => 'Тёмная',
        AppLanguage.en => 'Dark',
      };

  String get currentThemeName => switch (language) {
        AppLanguage.ru => 'Текущая тема',
        AppLanguage.en => 'Current theme',
      };

  String get expenseCategories => switch (language) {
        AppLanguage.ru => 'Категории трат',
        AppLanguage.en => 'Expense categories',
      };

  String get accumulationCategories => switch (language) {
        AppLanguage.ru => 'Категории накоплений',
        AppLanguage.en => 'Savings categories',
      };

  String get expensesTab => switch (language) {
        AppLanguage.ru => 'Траты',
        AppLanguage.en => 'Expenses',
      };

  String get savingsTab => switch (language) {
        AppLanguage.ru => 'Накопления',
        AppLanguage.en => 'Savings',
      };

  String get addExpenseCategory => switch (language) {
        AppLanguage.ru => 'Добавить категорию трат',
        AppLanguage.en => 'Add expense category',
      };

  String get addAccumulation => switch (language) {
        AppLanguage.ru => 'Добавить накопление',
        AppLanguage.en => 'Add savings category',
      };

  String get linkedAccumulation => switch (language) {
        AppLanguage.ru => 'Привязать к накоплению',
        AppLanguage.en => 'Link to savings',
      };

  String get noLink => switch (language) {
        AppLanguage.ru => 'Не выбран',
        AppLanguage.en => 'None',
      };

  String get noExpenseCategories => switch (language) {
        AppLanguage.ru => 'Нет категорий трат. Добавьте их в Категориях.',
        AppLanguage.en => 'No expense categories yet. Add them in Categories.',
      };

  String get noSavingsCategories => switch (language) {
        AppLanguage.ru => 'Нет категорий накоплений. Добавьте их в настройках.',
        AppLanguage.en => 'No savings categories yet. Add them in settings.',
      };

  String get color => switch (language) {
        AppLanguage.ru => 'Выберите цвет:',
        AppLanguage.en => 'Choose color:',
      };

  String get howLinkWorks => switch (language) {
        AppLanguage.ru => 'Как работает привязка',
        AppLanguage.en => 'How linking works',
      };

  String get linkInfo => switch (language) {
        AppLanguage.ru =>
          'Если выбрать накопление, то все деньги, которые останутся после фактических трат по этой категории, будут автоматически уходить в указанное накопление.',
        AppLanguage.en =>
          'If you choose a savings category, all remaining money after actual expenses in this category will automatically go to that savings category.',
      };

  String get gotIt => switch (language) {
        AppLanguage.ru => 'Понятно',
        AppLanguage.en => 'Got it',
      };

  String get linkedToSavings => switch (language) {
        AppLanguage.ru => 'Привязать к накоплению',
        AppLanguage.en => 'Link to savings category',
      };

  String get save => switch (language) {
        AppLanguage.ru => 'Сохранить',
        AppLanguage.en => 'Save',
      };

  String get editCategory => switch (language) {
        AppLanguage.ru => 'Редактировать категорию',
        AppLanguage.en => 'Edit category',
      };

  String get addCategory => switch (language) {
        AppLanguage.ru => 'Добавить категорию',
        AppLanguage.en => 'Add category',
      };

  String get editSavings => switch (language) {
        AppLanguage.ru => 'Редактировать накопление',
        AppLanguage.en => 'Edit savings',
      };

  String get addSavings => switch (language) {
        AppLanguage.ru => 'Добавить накопление',
        AppLanguage.en => 'Add savings',
      };

  String get editExpense => switch (language) {
        AppLanguage.ru => 'Редактировать категорию',
        AppLanguage.en => 'Edit expense category',
      };

  String get editSavingsCategory => switch (language) {
        AppLanguage.ru => 'Редактировать накопление',
        AppLanguage.en => 'Edit savings category',
      };

  String get name => switch (language) {
        AppLanguage.ru => 'Название',
        AppLanguage.en => 'Name',
      };

  String get weeklyLimit => switch (language) {
        AppLanguage.ru => 'Недельный лимит (₽)',
        AppLanguage.en => 'Weekly limit (₽)',
      };

  String get currentBalance => switch (language) {
        AppLanguage.ru => 'Текущий баланс (₽)',
        AppLanguage.en => 'Current balance (₽)',
      };

  String get initialBalance => switch (language) {
        AppLanguage.ru => 'Базовый баланс (₽)',
        AppLanguage.en => 'Base balance (₽)',
      };

  String get spendingLimit => switch (language) {
        AppLanguage.ru => 'Недельный лимит (₽)',
        AppLanguage.en => 'Weekly limit (₽)',
      };

  String get limit => switch (language) {
        AppLanguage.ru => 'Лимит',
        AppLanguage.en => 'Limit',
      };

  String get weekExpenses => switch (language) {
        AppLanguage.ru => 'Фактические траты по категориям:',
        AppLanguage.en => 'Actual expenses by category:',
      };

  String get addExpense => switch (language) {
        AppLanguage.ru => 'Добавить расход',
        AppLanguage.en => 'Add expense',
      };

  String get periodExpenses => switch (language) {
        AppLanguage.ru => 'Период трат',
        AppLanguage.en => 'Expense period',
      };

  String get weekStart => switch (language) {
        AppLanguage.ru => 'Начало недели',
        AppLanguage.en => 'Week start',
      };

  String get weekEnd => switch (language) {
        AppLanguage.ru => 'Конец недели',
        AppLanguage.en => 'Week end',
      };

  String get chooseDateRange => switch (language) {
        AppLanguage.ru => 'Выбрать период',
        AppLanguage.en => 'Choose date range',
      };

  String get enterValidNumber => switch (language) {
        AppLanguage.ru => 'Введите корректное число',
        AppLanguage.en => 'Enter a valid number',
      };

  String get noExpensesYet => switch (language) {
        AppLanguage.ru => 'На этой неделе еще нет трат',
        AppLanguage.en => 'No expenses for this week yet',
      };

  String get noHistoryYet => switch (language) {
        AppLanguage.ru =>
          'История пуста.\nДобавьте первую запись в разделе «Расход».',
        AppLanguage.en =>
          'History is empty.\nAdd your first entry in the Expense section.',
      };

  String get historyTitle => switch (language) {
        AppLanguage.ru => 'История',
        AppLanguage.en => 'History',
      };

  String get exportCsv => switch (language) {
        AppLanguage.ru => 'Экспорт CSV',
        AppLanguage.en => 'Export CSV',
      };

  String get deleteRecord => switch (language) {
        AppLanguage.ru => 'Удалить запись?',
        AppLanguage.en => 'Delete record?',
      };

  String get confirmDeleteRecord => switch (language) {
        AppLanguage.ru => 'Вы уверены, что хотите удалить запись за период',
        AppLanguage.en =>
          'Are you sure you want to delete the record for the period',
      };

  String get recordDeleted => switch (language) {
        AppLanguage.ru => 'Запись удалена',
        AppLanguage.en => 'Record deleted',
      };

  String get entryAdded => switch (language) {
        AppLanguage.ru => 'Запись успешно добавлена!',
        AppLanguage.en => 'Entry added successfully!',
      };

  String get entryUpdated => switch (language) {
        AppLanguage.ru => 'Запись успешно обновлена!',
        AppLanguage.en => 'Entry updated successfully!',
      };

  String get emptySavings => switch (language) {
        AppLanguage.ru =>
          'Нет категорий накоплений.\nДобавьте их во вкладке "Категории".',
        AppLanguage.en =>
          'No savings categories yet.\nAdd them in the "Categories" tab.',
      };

  String get targetAmount => switch (language) {
        AppLanguage.ru => 'Целевая сумма (₽)',
        AppLanguage.en => 'Target amount (₽)',
      };

  String get noTarget => switch (language) {
        AppLanguage.ru => '0 - без цели',
        AppLanguage.en => '0 - no target',
      };

  String get removed => switch (language) {
        AppLanguage.ru => 'Удалено',
        AppLanguage.en => 'Removed',
      };

  String get baseBalance => switch (language) {
        AppLanguage.ru => 'Базовый баланс',
        AppLanguage.en => 'Base balance',
      };

  String get spent => switch (language) {
        AppLanguage.ru => 'Потрачено',
        AppLanguage.en => 'Spent',
      };

  String get remaining => switch (language) {
        AppLanguage.ru => 'Остаток',
        AppLanguage.en => 'Remaining',
      };

  String get changedCategory => switch (language) {
        AppLanguage.ru => 'Категория была удалена',
        AppLanguage.en => 'Category was deleted',
      };

  String get redirectedToSavings => switch (language) {
        AppLanguage.ru => 'Направлено в',
        AppLanguage.en => 'Transferred to',
      };

  String get edit => switch (language) {
        AppLanguage.ru => 'Редактировать',
        AppLanguage.en => 'Edit',
      };

  String get deleteEntryTitle => switch (language) {
        AppLanguage.ru => 'Удалить запись?',
        AppLanguage.en => 'Delete entry?',
      };

  String get entryDeleted => switch (language) {
        AppLanguage.ru => 'Запись удалена',
        AppLanguage.en => 'Entry deleted',
      };

  String get userInSystem => switch (language) {
        AppLanguage.ru => 'Вы вошли в систему',
        AppLanguage.en => 'You are signed in',
      };

  String get expenseType => switch (language) {
        AppLanguage.ru => 'Траты',
        AppLanguage.en => 'Expenses',
      };

  String get savingsType => switch (language) {
        AppLanguage.ru => 'Накопления',
        AppLanguage.en => 'Savings',
      };
}
