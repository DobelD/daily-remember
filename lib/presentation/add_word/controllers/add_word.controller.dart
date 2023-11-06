import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dailyremember/domain/core/model/word_model.dart';
import 'package:dailyremember/domain/core/model/word_param.dart';
import 'package:dailyremember/presentation/add_word/widget/menu_record.dart';
import 'package:dailyremember/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
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
  late TextEditingController english;
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

  Uint8List? audioData;

  Future<void> createWord() async {
    addWordStatus(AddWordStatus.loading);
    var params = WordParam(
        indonesia: indonesia.text.trim(),
        english: english.text.trim(),
        remember: data?.remember ?? false,
        verbOne: verbOne.text.trim(),
        verbTwo: verbTwo.text.trim(),
        verbThree: verbThree.text.trim(),
        verbIng: verbIng.text.trim());
    if (isRedordingDone.every((element) => element)) {
      print("Semua elemen adalah true");
    } else {
      print("Tidak semua elemen adalah true");
    }
    // final res = Get.arguments['type'] != "update"
    //     ? await _wordRepository.createWord(params)
    //     : await _wordRepository.updateWord(params, data?.id ?? 0);
    // if (verbOne.text.isNotEmpty ||
    //     verbTwo.text.isNotEmpty ||
    //     verbThree.text.isNotEmpty ||
    //     verbIng.text.isNotEmpty) {
    //   saveRecording();
    // }
    // if (res != null) {
    //   addWordStatus(AddWordStatus.success);
    //   doneAction.value = true;

    //   clearForm();
    // }
    // addWordStatus(AddWordStatus.failed);
  }

  clearForm() {
    indonesia.clear();
    english.clear();
    verbOne.clear();
    verbTwo.clear();
    verbThree.clear();
    verbIng.clear();
  }

  setDictionaryData() {
    if (Get.arguments['data'] != null) {
      data = Get.arguments['data'];
    }
    if (Get.arguments['type'] == "update") {
      indonesia = TextEditingController(text: data?.indonesia);
      english = TextEditingController(text: data?.english);
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
      english = TextEditingController(text: "");
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
    final controllerHome = Get.find<HomeController>();
    controllerHome.getWord();
  }

  openMenuRecord(int index) async {
    currentIndex.value = index;
    isSave.value = false;
    isStop.value = false;
    final hasPermission = await recordController.checkPermission();
    if (hasPermission) {
      startRecording(index);
      startTimer();
      Get.bottomSheet(const MenuRecord()).whenComplete(() {
        log("---------Stop Recording---------");
        recordController.stop();
        resetTimer();
      });
    }
  }

  Future<void> startRecording(int index) async {
    print(listTextController[index]?.text ?? '');
    print(index);
    final hasPermission = await recordController.checkPermission();
    if (hasPermission) {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      String fileName = 'vocabulary-${listTextController[index]?.text}.aac';
      print("File NAme : $fileName");
      await recordController.record(
          path: '${appDocDirectory.path}/$fileName',
          androidEncoder: AndroidEncoder.aac,
          bitRate: 256000);
      // Bit Rate Sedang : 128000
      // Bit Rate Tinggi : 256000

      bool isRecording = recordController.isRecording;
      if (isRecording) {
        // ignore: avoid_print
        print("Merekam");
      }
    } else {
      // ignore: avoid_print
      print("Tidak dapat merekam, periksa izin mikrofon.");
    }
  }

  // openSaveDialog() {
  //   onResumeStopRecord();
  //   Get.defaultDialog(
  //       radius: 8,
  //       title: "Save Recording?",
  //       content: SaveDialog(
  //         onPressed: () => saveRecording(),
  //       )).whenComplete(() {
  //     if (isSave.value == false) {
  //       onResumeStopRecord();
  //     }
  //   });
  // }

  Future<void> saveRecording() async {
    isSave.value = true;
    recordController.stop();
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox<VocabularyModel>('vocabulary');
    var vocabularyModel = VocabularyModel(
        "${appDocDirectory.path}/vocabulary-${listTextController[0]?.text}.acc",
        "${appDocDirectory.path}/vocabulary-${listTextController[1]?.text}.acc",
        "${appDocDirectory.path}/vocabulary-${listTextController[2]?.text}.acc",
        "${appDocDirectory.path}/vocabulary-${listTextController[3]?.text}.acc");

    box.add(vocabularyModel);
    // ignore: avoid_print
    print("Rekaman disimpan.");
    // Bersihkan nilai saat ini
    titleController.clear();
    listTextController.clear();
  }

  void startTimer() {
    if (!isRunning.value) {
      isRunning.value = true;
      Duration duration = 1.seconds;
      Timer.periodic(duration, (Timer timer) {
        if (isRunning.value) {
          if (seconds.value < 59) {
            seconds.value++;
          } else {
            seconds.value = 0;
            minutes.value++;
          }
        } else {
          timer.cancel();
        }
      });
    }
  }

  void stopTimer() {
    isRunning.value = false;
  }

  void resetTimer() {
    isRunning.value = false;
    seconds.value = 0;
    minutes.value = 0;
  }

  void onSaveRecord() {
    // saveRecording();
    Get.back();
  }

  void onDeleteRecord() {
    Get.back();
  }

  void onResumeStopRecord() {
    isStop.value = !isStop.value;
    if (isRunning.value) {
      stopTimer();
      recordController.pause();
    } else {
      startRecording(currentIndex.value);
      startTimer();
    }
  }

  void checkValueForm(String value, int index) {
    isActiveRecording[index] = value.isNotEmpty;
  }

  void messageRequeredValue() {
    Get.showSnackbar(GetSnackBar(
      margin: const EdgeInsets.all(12),
      backgroundColor: Colors.red,
      borderRadius: 8,
      message: "Isi form untuk melakukan record",
      duration: 1.seconds,
    ));
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
    // refreshHome();
    super.onClose();
  }
}
