import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart' as a;
import 'package:dailyremember/domain/core/interfaces/word_repository.dart';
import 'package:dailyremember/domain/core/model/local_storage/vocabulary.dart';
import 'package:dailyremember/domain/core/model/word_model.dart';
import 'package:dailyremember/domain/core/model/word_param.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/home/widget/add_target.dart';
import 'package:dailyremember/presentation/home/widget/detail_word.dart';
import 'package:dailyremember/presentation/home/widget/dialog_confirmation_remembered.dart';
import 'package:dailyremember/utils/extension/get_beetwen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

import '../../../infrastructure/navigation/routes.dart';
// import '../widget/player_bar.dart';

enum HomeStatus { initial, loading, success, failed }

class HomeController extends GetxController {
  final WordRepository _wordRepository;
  HomeController(this._wordRepository);

  TextEditingController targetController = TextEditingController();
  var homeStatus = Rx<HomeStatus>(HomeStatus.initial);

  a.AudioPlayer audioPlayer = a.AudioPlayer();

  final box = GetStorage();
  late Box<VocabularyModel> storage;

  // ignore: prefer_final_fields
  var _words = <WordModel>[].obs;
  // ignore: unused_field, prefer_final_fields
  var _initialWordsEnglish = <WordModel>[].obs;
  // ignore: prefer_final_fields, unused_field
  var _initialWordsIndonesia = <WordModel>[].obs;
  RxList<WordModel> get wordsEnglish => _words;
  RxList<WordModel> get wordsIndonesia => _words;

  var listSort = ["Abjad", "Remember", "No Remember"].obs;
  var listAction = ["Remember", "Edit", "Delete"].obs;

  var selectedSortOnEnglish = 0.obs;
  var selectedSortOnIndonesia = 0.obs;
  var selectedActionOnEnglish = 4.obs;
  var selectedActionOnIndonesia = 4.obs;
  var countRememberEnglish = 0.obs;
  var countRememberIndonesia = 0.obs;
  var countNoRememberEnglish = 0.obs;
  var countNoRememberIndonesia = 0.obs;

  var seconds = 0.obs;
  var minutes = 0.obs;
  var isRunning = false.obs;
  var isStop = false.obs;
  var isPlaying = <bool>[].obs;
  var isSave = false.obs;
  var playingDuration = 0.0.obs;
  var maxDuration = 0.0.obs;

  setWord(List<WordModel> data) {
    _words.assignAll(data);
    _initialWordsEnglish.assignAll(data);
    _initialWordsIndonesia.assignAll(data);
  }

  Future<void> getWord() async {
    selectedSortOnEnglish.value = 0;
    selectedSortOnIndonesia.value = 0;
    selectedActionOnEnglish.value = 4;
    selectedActionOnIndonesia.value = 4;
    homeStatus(HomeStatus.loading);
    final data = await _wordRepository.getWord();
    if (data != null) {
      setWord(data);
      countOfRemember(data);
      homeStatus(HomeStatus.success);
    }
    homeStatus(HomeStatus.failed);
  }

  Future<void> deleteWord(int id) async {
    homeStatus(HomeStatus.loading);
    final data = await _wordRepository.deleteWord(id);
    if (data == 200) {
      getWord();
    }
    homeStatus(HomeStatus.failed);
  }

  changeSortEnglish(int value) {
    selectedSortOnEnglish.value = value;
  }

  selectActionOnEnglish(int value, WordModel data) {
    selectedActionOnEnglish.value = value;
    if (selectedActionOnEnglish.value == 0) {
      openDialogRemembered(data);
      selectedActionOnIndonesia.value = 4;
    } else if (selectedActionOnEnglish.value == 1) {
      selectedActionOnIndonesia.value = 4;
      Get.toNamed(Routes.ADD_WORD, arguments: {"type": "update", "data": data});
    } else {
      selectedActionOnIndonesia.value = 4;
      deleteWord(data.id ?? 0);
    }
  }

  selectActionOnIndonesia(int value, WordModel data) {
    selectedActionOnIndonesia.value = value;
    if (selectedActionOnIndonesia.value == 0) {
      openDialogRemembered(data);
      selectedActionOnIndonesia.value = 4;
    } else if (selectedActionOnIndonesia.value == 1) {
      selectedActionOnIndonesia.value = 4;
      Get.toNamed(Routes.ADD_WORD, arguments: {"type": "update", "data": data});
    } else {
      selectedActionOnIndonesia.value = 4;
      deleteWord(data.id ?? 0);
    }
  }

  changeSortIndonesia(int value) {
    selectedSortOnIndonesia.value = value;
  }

  countOfRemember(List<WordModel> data) {
    countRememberEnglish.value = 0;
    countRememberIndonesia.value = 0;
    countNoRememberEnglish.value = 0;
    countNoRememberIndonesia.value = 0;
    for (var item in data) {
      if (item.remember == true) {
        countRememberEnglish.value++;
        countRememberIndonesia.value++;
      }
      if (item.remember == false) {
        countNoRememberEnglish.value++;
        countNoRememberIndonesia.value++;
      }
    }
  }

  List<WordModel> sortEnglishWordByAlphabet(List<WordModel> word) {
    word.sort((a, b) {
      final firstLetterA = a.verbOne?[0].toUpperCase() ?? '';
      final firstLetterB = b.verbOne?[0].toUpperCase() ?? '';
      return firstLetterA.compareTo(firstLetterB);
    });
    return word;
  }

  List<WordModel> sortIndonesiaWordByAlphabet(List<WordModel> word) {
    word.sort((a, b) {
      final firstLetterA = a.indonesia?[0].toUpperCase() ?? '';
      final firstLetterB = b.indonesia?[0].toUpperCase() ?? '';

      return firstLetterA.compareTo(firstLetterB);
    });
    return word;
  }

  void searchWordOnEnglish(String query) {
    if (query.isEmpty) {
      wordsEnglish.value = _initialWordsEnglish
          .toList(); // Kembalikan data awal jika query kosong
    } else {
      wordsEnglish.value = _initialWordsEnglish.where((word) {
        final lowercaseWord = word.verbOne!.toLowerCase();
        return lowercaseWord.contains(query.toLowerCase());
      }).toList();
    }
  }

  void searchWordOnIndonesia(String query) {
    if (query.isEmpty) {
      wordsIndonesia.value = _initialWordsIndonesia
          .toList(); // Kembalikan data awal jika query kosong
    } else {
      wordsIndonesia.value = _initialWordsIndonesia.where((word) {
        final lowercaseWord = word.verbOne!.toLowerCase();
        return lowercaseWord.contains(query.toLowerCase());
      }).toList();
    }
  }

  openDialogRemembered(WordModel data) {
    var param = WordParam(indonesia: data.indonesia ?? '', remember: true);
    Get.dialog(DialogConfirmationRemembered(
      data: param,
      id: data.id ?? 0,
      onPressed: () => confirmationRemembered(param, data.id ?? 0),
    ));
  }

  confirmationRemembered(WordParam data, int id) async {
    int? lastRemember = box.read('remember-vocab');

    Get.back();
    final res = await _wordRepository.updateWord(data, id);
    await box.write('remember-vocab', lastRemember ?? 0 + 1);
    await getWord();
    if (res != null) {}
  }

  openDetailWord(WordModel data) {
    isPlaying.clear();
    isPlaying.value = List.generate(5, (index) => false);
    Get.bottomSheet(
        enterBottomSheetDuration: 400.milliseconds,
        exitBottomSheetDuration: 400.milliseconds,
        isScrollControlled: true,
        DetailWord(data: data));
  }

  void playAudioRecord(String name, int index) {
    final vocabulary = storage.values.toList().cast<VocabularyModel>();

    bool isCheck = vocabulary.any((e) {
      switch (index) {
        case 0:
          return e.verbOne.getTextBetween("vocabulary-", ".acc") == name;
        case 1:
          return e.verbTwo.getTextBetween("vocabulary-", ".acc") == name;
        case 2:
          return e.verbThree.getTextBetween("vocabulary-", ".acc") == name;
        case 3:
          return e.verbIng.getTextBetween("vocabulary-", ".acc") == name;
        default:
          return false;
      }
    });

    if (isCheck) {
      log("Nama ada dalam data vocabulary: true");
      resetTimer();
      playAudio(name, index);
    } else {
      // ignore: unused_local_variable, unnecessary_null_comparison
      String initialName = name == '' || name == null ? "-" : name;
      log("Nama tidak ada dalam data vocabulary: false");
      Get.showSnackbar(GetSnackBar(
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        backgroundColor: Colors.red,
        message: "$initialName Belum direkam",
        duration: 1.seconds,
      ));
    }
  }

  void openDialogTarget() {
    final target = box.read('target-vocab');
    targetController = TextEditingController(text: target);
    Get.defaultDialog(
        title: "Buat target hafalan harian!",
        titleStyle: titleBold,
        radius: 8,
        content: AddTarget(
          onPressed: () {
            box.write('target-vocab', targetController.text);
            Get.back();
          },
        )).whenComplete(() {
      targetController.clear();
    });
  }

  Future<void> playAudio(String name, int index) async {
    String path =
        "/data/user/0/com.dailyremember/app_flutter/vocabulary-$name.aac";
    isPlaying[index] = true;
    if (isPlaying[index] == false) {
      await audioPlayer.stop();
    } else {
      DeviceFileSource source = DeviceFileSource(path);
      await audioPlayer.play(source);
      final duration = await audioPlayer.getDuration(); // Dapatkan durasi audio
      maxDuration.value = duration?.inMilliseconds.toDouble() ?? 0;
      int audioDurationSeconds =
          (maxDuration.value / 1000).floor(); // Konversi ke detik
      int audioDurationMinutes = (audioDurationSeconds / 60).floor();
      minutes.value = audioDurationMinutes;
      seconds.value = audioDurationSeconds % 60;
      startCountdownTimer();
      audioPlayer.onPositionChanged.listen((event) {
        playingDuration.value = event.inMilliseconds.toDouble();
      });
      audioPlayer.onPlayerComplete.listen((event) {
        log("Selesai------");
        playingDuration.value = maxDuration.value;
        isPlaying[index] = false;
        isStop.value = false;
      });
    }
  }

  stopPlayingAudio() {
    isStop.value = false;
    audioPlayer.stop();
    // isPlaying[index] = false;
  }

  pauseResumeAudio() {
    isStop.value = !isStop.value;
    if (isRunning.value) {
      stopTimer();
      audioPlayer.pause();
    } else {
      audioPlayer.resume();
      startCountdownTimer();
    }
  }

  void resetTimer() {
    isRunning.value = false;
    seconds.value = 0;
    minutes.value = 0;
  }

  void startCountdownTimer() {
    if (!isRunning.value && minutes.value > 0 || seconds.value > 0) {
      isRunning.value = true;
      Duration duration = 1.seconds;
      Timer.periodic(duration, (Timer timer) {
        if (isRunning.value) {
          if (seconds.value > 0) {
            seconds.value--;
          } else {
            if (minutes.value > 0) {
              minutes.value--;
              seconds.value = 59;
            } else {
              isRunning.value = false; // Timer selesai
              timer.cancel();
            }
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

  autoValueIfNull() {
    box.writeIfNull('target-vocab', "0");
    box.writeIfNull('speaking-target', 0);
  }

  void printFilesInDirectory() {
    String path = '/data/user/0/com.dailyremember/app_flutter/';
    final directory = Directory(path);
    if (directory.existsSync()) {
      final files = directory.listSync();

      if (files.isNotEmpty) {
        print("Daftar file dalam direktori $path:");
        for (var file in files) {
          if (file is File) {
            print(file.uri.path);
          }
        }
      } else {
        print("Direktori kosong: $path");
      }
    } else {
      print("Direktori tidak ditemukan: $path");
    }
  }

  @override
  void onInit() {
    storage = Hive.box<VocabularyModel>('vocabulary');
    autoValueIfNull();
    getWord();
    super.onInit();
  }
}
