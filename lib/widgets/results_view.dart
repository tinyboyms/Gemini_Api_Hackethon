import 'package:quize/models/animal.dart';
import 'package:quize/notifiers/ui_state_notifier.dart';
import 'package:quize/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ResultsView extends ConsumerWidget {
  final bool correct;
  // final Fruit fruit;
  final Animal animal;

  const ResultsView({
    required this.correct,
    // required this.fruit,
    super.key, required this.animal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        width: double.infinity,
        height: double.infinity,
        color: correct ? animal.color : Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            animal.lottie,
            Text(
              correct ? 'Bingo!' : 'Sorry',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            Text(
              correct
                  ? 'You picked ${animal.name}.'
                  : 'The answer was ${animal.name}...',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const Gap(32),
            // ElevatedButton(
            //   onPressed: () {
            //     ref
            //         .read(Providers.uiStateNotifier.notifier)
            //         .updateState(UIState.notStarted);
            //   },
            //   child: const Text('Try New'),
            // ),
            //
            // ElevatedButton(
            //   onPressed: () {
            //     ref
            //         .read(Providers.uiStateNotifier.notifier)
            //         .updateState(UIState.notStarted);
            //   },
            //   child: const Text('Try Again'),
            // )
            if (ref.watch(Providers.uiStateNotifier) == UIState.correct)
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(Providers.uiStateNotifier.notifier)
                      .updateState(UIState.notStarted);
                },
                child: const Text('Try New'),
              ),

            // Display the second button if the answer is incorrect
            if (ref.watch(Providers.uiStateNotifier) == UIState.incorrect)
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(Providers.uiStateNotifier.notifier)
                      .updateState(UIState.notStarted);
                },
                child: const Text('Try Again'),
              ),
          ],
        ),
      );
}
