import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher_mate/applications/state_management/settings_provider.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool tosAccepted = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 1.25;
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.welcomeTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  localizations.welcomeAppName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/welcome.png', width: size, height: size),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Text(
                localizations.welcomeDescription,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: tosAccepted,
                  onChanged: (value) {
                    setState(() {
                      tosAccepted = value ?? false;
                    });
                  },
                ),
                Text(
                  localizations.iAgreeTo,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text(localizations.termsTitle),
                              content: SingleChildScrollView(
                                child: Text(
                                  localizations.termsDialogContent,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(localizations.close),
                                ),
                              ],
                            ),
                      );
                    },
                    child: Text(
                      localizations.termsTitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed:
                      tosAccepted
                          ? () =>
                              ref
                                  .read(seenWelcomeScreenProvider.notifier)
                                  .toggle()
                          : null,
                  child: Text(localizations.getStarted),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
