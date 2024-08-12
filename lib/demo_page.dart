import 'dart:math';
import 'package:quize/constants/globals.dart';
import 'package:quize/models/animal.dart';
import 'package:quize/notifiers/ui_state_notifier.dart';
import 'package:quize/providers.dart';
import 'package:quize/widgets/results_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemoPage extends ConsumerStatefulWidget {
  const DemoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DemoPageState();
}

class _DemoPageState extends ConsumerState<DemoPage> {
  final gemini = Gemini.instance;
  final controller = TextEditingController();

  // late Fruit fruit;
  late Animal animal;

  Widget _buildButton(UIState uiState) {
    switch (uiState) {
      case UIState.notStarted:
        return ElevatedButton(
           // Set the text color
          onPressed: () {
            ref
                .read(Providers.uiStateNotifier.notifier)
                .updateState(UIState.loading);

            _streamGenerateContent();
          },
          style:ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blue),
          child: const Text('Let\'s Get Started',style: TextStyle(),),
        );
      case UIState.loading:
        return const ElevatedButton(
          onPressed: null,
          child: Text('Loading...'),
        );
      case UIState.loaded:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Which Animal is this rap about?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              prefix: IconButton(
                onPressed: () => controller.clear(),
                icon: const Icon(
                  Icons.cancel,
                ),
              ),
              suffix: IconButton(
                onPressed: () {
                  if (controller.text.toLowerCase() == animal.name.toLowerCase()) {
                    ref
                        .read(Providers.uiStateNotifier.notifier)
                        .updateState(UIState.correct);
                  } else {
                    ref
                        .read(Providers.uiStateNotifier.notifier)
                        .updateState(UIState.incorrect);
                  }

                  controller.clear();
                },
                icon: const Icon(
                  Icons.send,
                ),
              ),
            ),
          ),
        );
      case UIState.correct:
      case UIState.incorrect:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final uiState = ref.watch(Providers.uiStateNotifier);

    if (uiState == UIState.correct) {
      return ResultsView(
        correct: true,
        // fruit: fruit,
        animal:animal

      );
    }

    if (uiState == UIState.incorrect) {
      return ResultsView(
        correct: false,
        // fruit: fruit,
        animal:animal
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          // 'Fruit Rap',
          'Animal Rap',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: GeminiResponseTypeView(
                    builder: (context, child, response, loading) {
                      if (loading) {
                        // return Globals.lottieFruitBasket;
                        return Globals.lottieLoading;
                      }

                      if (response != null) {
                        return Text(
                          response,
                          style: const TextStyle(fontSize: 20),
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ),
            _buildButton(uiState),
          ],
        ),
      ),
    );
  }

  void _streamGenerateContent() {
    // fruit = Globals.fruits[Random().nextInt(Globals.fruits.length)];
    animal = Globals.animal[Random().nextInt(Globals.animal.length)];

    final prompt =
        'Give me a short rap about the animal ${animal.name}, but do not use the word ${animal.name} in the rap.';
         // animal.name fruit.name
    gemini.streamGenerateContent(
      prompt,
      generationConfig: GenerationConfig(
        temperature: 1,
        maxOutputTokens: 500,
      ),
      safetySettings: [
        SafetySetting(
          category: SafetyCategory.hateSpeech,
          threshold: SafetyThreshold.blockLowAndAbove,
        ),
      ],
    ).listen((event) {
      ref.read(Providers.uiStateNotifier.notifier).updateState(UIState.loaded);
    });
  }
}
