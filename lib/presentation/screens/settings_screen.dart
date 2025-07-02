import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_mate/applications/state_management/settings_provider.dart';
import 'package:teacher_mate/infrastructure/data/calendar_type.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                margin: EdgeInsets.zero,
                elevation: 0,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.brightness_6_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(AppLocalizations.of(context)!.themeModeTitle),
                      subtitle: Text(
                        AppLocalizations.of(
                          context,
                        )!.themeMode(ref.watch(themeModeSettingProvider).name),
                      ),
                      onTap: () {
                        ThemeMode themeMode = ref.read(
                          themeModeSettingProvider,
                        );
                        showDialog<String>(
                          context: context,
                          builder:
                              (BuildContext context) => StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.themeModeTitle,
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RadioListTile<ThemeMode>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.themeMode(ThemeMode.light.name),
                                          ),
                                          value: ThemeMode.light,
                                          groupValue: themeMode,
                                          onChanged: (value) {
                                            setState(() {
                                              themeMode = value!;
                                            });
                                          },
                                        ),
                                        RadioListTile<ThemeMode>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.themeMode(ThemeMode.dark.name),
                                          ),
                                          value: ThemeMode.dark,
                                          groupValue: themeMode,
                                          onChanged: (value) {
                                            setState(() {
                                              themeMode = value!;
                                            });
                                          },
                                        ),
                                        RadioListTile<ThemeMode>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.themeMode(ThemeMode.system.name),
                                          ),
                                          value: ThemeMode.system,
                                          groupValue: themeMode,
                                          onChanged: (value) {
                                            setState(() {
                                              themeMode = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => context.pop(),
                                        child: Text(
                                          AppLocalizations.of(context)!.cancel,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.pop();
                                          ref
                                              .read(
                                                themeModeSettingProvider
                                                    .notifier,
                                              )
                                              .changeTheme(themeMode);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.confirm,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                        );
                      },
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.surface,
                      height: 0,
                      thickness: 2,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.color_lens_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.themeColorTitle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context)!.themeColor(
                          ref.watch(themeColorSettingProvider.notifier).name(),
                        ),
                      ),
                      onTap: () {
                        Color themeColor = ref.read(themeColorSettingProvider);
                        showDialog<String>(
                          context: context,
                          builder:
                              (BuildContext context) => StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.themeColorTitle,
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RadioListTile<Color>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.themeColor('yellow'),
                                          ),
                                          value: Colors.yellow,
                                          groupValue: themeColor,
                                          onChanged: (value) {
                                            setState(() {
                                              themeColor = value!;
                                            });
                                          },
                                        ),
                                        RadioListTile<Color>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.themeColor('pink'),
                                          ),
                                          value: Colors.pinkAccent,
                                          groupValue: themeColor,
                                          onChanged: (value) {
                                            setState(() {
                                              themeColor = value!;
                                            });
                                          },
                                        ),
                                        RadioListTile<Color>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.themeColor('green'),
                                          ),
                                          value: Colors.green,
                                          groupValue: themeColor,
                                          onChanged: (value) {
                                            setState(() {
                                              themeColor = value!;
                                            });
                                          },
                                        ),
                                        RadioListTile<Color>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.themeColor('purple'),
                                          ),
                                          value: Colors.purple,
                                          groupValue: themeColor,
                                          onChanged: (value) {
                                            setState(() {
                                              themeColor = value!;
                                            });
                                          },
                                        ),
                                        RadioListTile<Color>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.themeColor('red'),
                                          ),
                                          value: Colors.red,
                                          groupValue: themeColor,
                                          onChanged: (value) {
                                            setState(() {
                                              themeColor = value!;
                                            });
                                          },
                                        ),
                                        RadioListTile<Color>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.themeColor('blue'),
                                          ),
                                          value: Colors.lightBlue,
                                          groupValue: themeColor,
                                          onChanged: (value) {
                                            setState(() {
                                              themeColor = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => context.pop(),
                                        child: Text(
                                          AppLocalizations.of(context)!.cancel,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.pop();
                                          ref
                                              .read(
                                                themeColorSettingProvider
                                                    .notifier,
                                              )
                                              .changeColor(themeColor);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.confirm,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                margin: EdgeInsets.zero,
                elevation: 0,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.language,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(AppLocalizations.of(context)!.language),
                      subtitle: Text(
                        AppLocalizations.of(context)!.languageMode(
                          ref.watch(localeSettingProvider).toString(),
                        ),
                      ),
                      onTap: () {
                        Locale locale = ref.read(localeSettingProvider);
                        showDialog<String>(
                          context: context,
                          builder:
                              (BuildContext context) => StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      AppLocalizations.of(context)!.language,
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RadioListTile<Locale>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.languageMode('en'),
                                          ),
                                          value: L10n.en,
                                          groupValue: locale,
                                          onChanged: (value) {
                                            setState(() {
                                              locale = value!;
                                            });
                                          },
                                        ),
                                        RadioListTile<Locale>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.languageMode('fa'),
                                          ),
                                          value: L10n.fa,
                                          groupValue: locale,
                                          onChanged: (value) {
                                            setState(() {
                                              locale = value!;
                                            });
                                          },
                                        ),
                                        RadioListTile<Locale>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.themeMode('system'),
                                          ),
                                          value: L10n.system,
                                          groupValue: locale,
                                          onChanged: (value) {
                                            setState(() {
                                              locale = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => context.pop(),
                                        child: Text(
                                          AppLocalizations.of(context)!.cancel,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.pop();
                                          ref
                                              .read(
                                                localeSettingProvider.notifier,
                                              )
                                              .changeLocale(locale);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.confirm,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                        );
                      },
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.surface,
                      height: 0,
                      thickness: 2,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.calendar_month_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(AppLocalizations.of(context)!.calendar),
                      subtitle: Text(
                        AppLocalizations.of(context)!.calendarType(
                          ref.watch(calendarTypeSettingProvider).name,
                        ),
                      ),
                      onTap: () {
                        CalendarType type = ref.read(
                          calendarTypeSettingProvider,
                        );
                        showDialog<String>(
                          context: context,
                          builder:
                              (BuildContext context) => StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      AppLocalizations.of(context)!.calendar,
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RadioListTile<CalendarType>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.calendarType(
                                              CalendarType.gregorian.name,
                                            ),
                                          ),
                                          value: CalendarType.gregorian,
                                          groupValue: type,
                                          onChanged: (value) {
                                            setState(() {
                                              type = value!;
                                            });
                                          },
                                        ),
                                        RadioListTile<CalendarType>(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.calendarType(
                                              CalendarType.persian.name,
                                            ),
                                          ),
                                          value: CalendarType.persian,
                                          groupValue: type,
                                          onChanged: (value) {
                                            setState(() {
                                              type = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => context.pop(),
                                        child: Text(
                                          AppLocalizations.of(context)!.cancel,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.pop();
                                          ref
                                              .read(
                                                calendarTypeSettingProvider
                                                    .notifier,
                                              )
                                              .changeType(type);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.confirm,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _openInstagram,
                  icon: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                IconButton(
                  onPressed: _openTelegram,
                  icon: FaIcon(
                    FontAwesomeIcons.telegram,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                IconButton(
                  onPressed: _sendMail,
                  icon: FaIcon(
                    FontAwesomeIcons.solidEnvelope,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Teacher Mate Beta",
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
            Text(
              "Copyright © 2025 Timothy F. Turner. All Rights Reserved",
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMail() async {
    final Uri url = Uri.parse(
      'mailto:TiimmyFTurner@gmail.com?subject=TeacherMate',
    );
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _openTelegram() async {
    final Uri url = Uri.parse('https://T.me/TiimmyFTurner');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _openInstagram() async {
    final Uri url = Uri.parse('https://www.instagram.com/teachermateapp');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
