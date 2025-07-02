import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_mate/applications/state_management/classes_providers.dart';
import 'package:teacher_mate/applications/state_management/quizzes_providers.dart';
import 'package:teacher_mate/applications/state_management/sessions_providers.dart';
import 'package:teacher_mate/applications/state_management/settings_provider.dart';
import 'package:teacher_mate/infrastructure/router/router_consts.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/presentation/screens/welcome_screen.dart';
import 'package:teacher_mate/presentation/widgets/class_card_widget.dart';
import 'package:teacher_mate/presentation/widgets/upcoming_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(allClassesProvider);
    final upcomingSessionsAsync = ref.watch(upcomingSessionsProvider);
    final upcomingQuizAsync = ref.watch(upcomingQuizzesProvider);
    bool seenWelcome = ref.watch(seenWelcomeScreenProvider);
    return !seenWelcome
        ? WelcomeScreen()
        : Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icon/icon.png', width: 50, height: 50),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.teacherMate,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 8),
                Chip(
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                  label: Text(AppLocalizations.of(context)!.beta),
                  visualDensity: VisualDensity.compact,
                  labelPadding: EdgeInsets.zero,
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => context.pushNamed(Routes.settings),
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed(Routes.addClass);
            },
            child: const Icon(Icons.add),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                upcomingSessionsAsync.when(
                  data: (sessionsList) {
                    if (sessionsList.isEmpty) {
                      return Container();
                    }
                    return Column(
                      children: [
                        SizedBox(height: 16),
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: sessionsList.length,
                            itemBuilder: (context, index) {
                              final session = sessionsList[index].session;
                              final classData = sessionsList[index].classData;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: UpcomingCard(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.sessionNumber(session.number),
                                  classTitle: classData.title,
                                  date: session.date,
                                  icon: Icons.class_outlined,
                                  onTap:
                                      () => context.pushNamed(
                                        Routes.sessionDetail,
                                        pathParameters: {
                                          'sessionId': session.id.toString(),
                                        },
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => Container(),
                  error: (e, st) {
                    return Center(
                      child: Text(
                        'error: $e', // Generic error message
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    );
                  },
                ),

                upcomingQuizAsync.when(
                  data: (quizzesList) {
                    if (quizzesList.isEmpty) {
                      return Container();
                    }
                    return Column(
                      children: [
                        SizedBox(height: 16),
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: quizzesList.length,
                            itemBuilder: (context, index) {
                              final quiz = quizzesList[index].quiz;
                              final classData = quizzesList[index].classData;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: UpcomingCard(
                                  title: quiz.title,
                                  classTitle: classData.title,
                                  date: quiz.date,
                                  icon: Icons.quiz_outlined,
                                  onTap:
                                      () => context.pushNamed(
                                        Routes.quizDetail,
                                        pathParameters: {
                                          'quizId': quiz.id.toString(),
                                        },
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => Container(),
                  error: (e, st) {
                    return Center(
                      child: Text(
                        'error: $e', // Generic error message
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                classesAsync.when(
                  data: (classes) {
                    final activeClasses = [
                      for (var c in classes)
                        if (c.isActive) c,
                    ];
                    final inactiveClasses = [
                      for (var c in classes)
                        if (!c.isActive) c,
                    ];

                    final hasNoClasses =
                        activeClasses.isEmpty && inactiveClasses.isEmpty;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child:
                          hasNoClasses
                              ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 100),

                                    Image.asset(
                                      'assets/images/home_empty_state.png',
                                      width: 250,
                                      height: 250,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.emptyClassesCaption,
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (activeClasses.isNotEmpty) ...[
                                    Text(
                                      AppLocalizations.of(context)!.classes,
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                    ),
                                    SizedBox(height: 8),

                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(26),
                                      ),

                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      child: ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: activeClasses.length,
                                        itemBuilder: (context, index) {
                                          final classItem =
                                              activeClasses[index];
                                          return ClassCard(
                                            classData: classItem,
                                          );
                                        },
                                        separatorBuilder: (_, __) => Divider(
                                          color: Theme.of(context).colorScheme.surface,
                                          thickness: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                  if (inactiveClasses.isNotEmpty) ...[
                                    SizedBox(height: 16),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.inactiveClasses,
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                    ),
                                    SizedBox(height: 8),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(26),
                                      ),

                                      margin: EdgeInsets.zero,
                                      elevation: 0,
                                      child: ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: inactiveClasses.length,
                                        itemBuilder: (context, index) {
                                          final classItem =
                                              inactiveClasses[index];
                                          return ClassCard(
                                            classData: classItem,
                                          );
                                        },
                                        separatorBuilder: (_, __) => Divider(
                                          color: Theme.of(context).colorScheme.surface,
                                          thickness: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                    );
                  },
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Error: $e')),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        );
  }
}
