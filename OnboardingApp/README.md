iOS приложение с онбордингом, построенное на архитектуре MVVM.


Приложение демонстрирует реализацию экрана онбординга с использованием:
- Архитектуры MVVM
- Программного UI (без Storyboard)
- UIPageViewController для слайдов
- UserDefaults для сохранения состояния
- Анимаций и эффектов параллакса
- Поддержки Dark Mode

Структура проекта

```
OnboardingApp/
├── Application/
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Core/
│   ├── Extensions/
│   │   ├── UIView+Extensions.swift
│   │   └── UIColor+Extensions.swift
│   └── Services/
│       ├── UserDefaultsServiceProtocol.swift
│       └── UserDefaultsService.swift
├── Models/
│   └── OnboardingPage.swift
└── Modules/
    ├── Main/
    │   ├── View/
    │   │   └── MainViewController.swift
    │   └── ViewModel/
    │       └── MainViewModel.swift
    └── Onboarding/
        ├── View/
        │   ├── OnboardingViewController.swift
        │   ├── OnboardingPageViewController.swift
        │   └── OnboardingSlideView.swift
        └── ViewModel/
            └── OnboardingViewModel.swift
```

Требования

- iOS 15.0+
- Xcode 14.0+
- Swift 5.0+



Использование

Первый запуск

При первом запуске приложения автоматически отображается экран онбординга.

Навигация

- Свайп влево/вправо для переключения между слайдами
- Кнопка "Далее" для перехода на следующий слайд
- На последнем слайде кнопка меняется на "Начать работу"
- Кнопка "Закрыть" в правом верхнем углу для выхода

Сброс онбординга

На главном экране есть кнопка "Сбросить онбординг" для повторного прохождения онбординга.

Архитектура

MVVM

- **Model**: `OnboardingPage` - модель данных для страницы онбординга
- **View**: `OnboardingViewController`, `OnboardingSlideView` - UI компоненты
- **ViewModel**: `OnboardingViewModel` - бизнес-логика и состояние

Dependency Injection

Используется протокол `UserDefaultsServiceProtocol` для инверсии зависимостей, что упрощает тестирование.

Основные компоненты

OnboardingPage

Модель данных для страницы онбординга с поддержкой:
- Изображений из Assets
- SF Symbols
- Кастомных цветов фона

OnboardingViewModel

Управляет:
- Текущей страницей
- Навигацией между страницами
- Сохранением состояния завершения
- Callbacks для обновления UI

OnboardingPageViewController

Контейнер на основе `UIPageViewController` для отображения слайдов с поддержкой:
- Свайпа между страницами
- Эффекта параллакса
- Отслеживания прогресса скролла

Особенности

- Адаптивный дизайн для разных размеров экранов
- Поддержка Dynamic Type
- Анимации с пружинным эффектом
- Эффект параллакса при скролле
- Поддержка Dark Mode
- Автоматический показ онбординга при первом запуске

- `main` - стабильная версия
- `develop` - ветка разработки
- `feature/*` - feature-ветки


