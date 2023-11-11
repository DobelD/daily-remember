import 'dart:async';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dailyremember/domain/core/model/word_model.dart';
import 'package:dailyremember/domain/core/model/word_param.dart';
import 'package:dailyremember/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../../domain/core/interfaces/word_repository.dart';
import '../../../domain/core/model/local_storage/vocabulary.dart';

enum AddWordStatus { initial, loading, success, failed }

class AddWordController extends GetxController {
  final WordRepository _wordRepository;
  AddWordController(this._wordRepository);

  WordModel? data;
  RecorderController recordController = RecorderController();
  PlayerController playerController = PlayerController();
  late Box<VocabularyModel> box;
  var recordingDuration = 0.obs;
  final audioPlayer = AudioPlayer();
  TextEditingController titleController = TextEditingController();
  late TextEditingController indonesia;
  late TextEditingController remember;
  late TextEditingController verbOne;
  late TextEditingController verbTwo;
  late TextEditingController verbThree;
  late TextEditingController verbIng;

  var listTextController = <TextEditingController?>[];
  var listHintText = [
    "Verb One",
    "Verb Two",
    "Verb Three",
    "Verb Ing",
  ];

  var addWordStatus = Rx<AddWordStatus>(AddWordStatus.initial);
  var doneAction = false.obs;

  var seconds = 0.obs;
  var minutes = 0.obs;
  var isRunning = false.obs;
  var isStop = false.obs;
  var recordVerOne = false.obs;
  var recordVerTwo = false.obs;
  var recordVerThree = false.obs;
  var recordVerIng = false.obs;
  var isSave = false.obs;
  var currentIndex = 0.obs;
  var isActiveRecording = <bool>[].obs;
  var isRedordingDone = <bool>[].obs;
  bool isDoneAction = false;

  Uint8List? audioData;

  Future<void> createWord() async {
    addWordStatus(AddWordStatus.loading);
    var params = WordParam(
        indonesia: indonesia.text.trim(),
        remember: data?.remember ?? false,
        verbOne: verbOne.text.trim(),
        verbTwo: verbTwo.text.trim(),
        verbThree: verbThree.text.trim(),
        verbIng: verbIng.text.trim());

    final res = Get.arguments['type'] != "update"
        ? await _wordRepository.createWord(params)
        : await _wordRepository.updateWord(params, data?.id ?? 0);
    // if (verbOne.text.isNotEmpty ||
    //     verbTwo.text.isNotEmpty ||
    //     verbThree.text.isNotEmpty ||
    //     verbIng.text.isNotEmpty) {
    //   saveRecording();
    // }
    if (res != null) {
      addWordStatus(AddWordStatus.success);
      isDoneAction = true;
      clearForm();
    }
    // if (isRedordingDone.every((element) => element)) {

    // } else {
    //   AppSnackbar.error(message: "Audio is required!");
    // }

    addWordStatus(AddWordStatus.failed);
  }

  clearForm() {
    for (int i = 0; i < listTextController.length; i++) {
      listTextController[i]?.clear();
    }
  }

  setDictionaryData() {
    if (Get.arguments['data'] != null) {
      data = Get.arguments['data'];
    }
    if (Get.arguments['type'] == "update") {
      indonesia = TextEditingController(text: data?.indonesia);
      verbOne = TextEditingController(text: data?.verbOne);
      verbTwo = TextEditingController(text: data?.verbTwo);
      verbThree = TextEditingController(text: data?.verbThree);
      verbIng = TextEditingController(text: data?.verbIng);
      listTextController.addAll([verbOne, verbTwo, verbThree, verbIng]);
      isActiveRecording.value = listTextController
          .map((controller) =>
              controller?.text != null && controller?.text != '' ? true : false)
          .toList();
    } else {
      indonesia = TextEditingController(text: "");
      verbOne = TextEditingController(text: "");
      verbTwo = TextEditingController(text: "");
      verbThree = TextEditingController(text: "");
      verbIng = TextEditingController(text: "");
      listTextController.addAll([verbOne, verbTwo, verbThree, verbIng]);
      isActiveRecording.value =
          List.generate(listTextController.length, (index) => false);
    }
  }

  refreshHome() {
    if (isDoneAction) {
      final controllerHome = Get.find<HomeController>();
      controllerHome.getWord();
    }
  }

  @override
  void onInit() {
    box = Hive.box<VocabularyModel>('vocabulary');
    isRedordingDone.value = List.generate(4, (index) => false);
    setDictionaryData();
    super.onInit();
  }

  @override
  void onClose() {
    recordController.stop();
    refreshHome();
    super.onClose();
  }
}
