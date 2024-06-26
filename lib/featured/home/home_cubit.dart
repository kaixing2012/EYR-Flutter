part of 'home_view.dart';

class HomeCubit extends Cubit<HomeState> with CommonFuncable {
  HomeCubit() : super(HomeState.init());

  void onInit() {
    FirebaseMessaging.onMessage.listen((event) {
      emit(
        state.copyWith(
          title: event.notification?.title,
          body: event.notification?.body,
        ),
      );
    });
  }

  Future<void> onNavigateToNetwork() async {
    router.pushNamed(AppRoutes.network.name);
  }

  Future<void> onTry() async {
    await sendToDecrypt();

    // ScaffoldMessenger.of(AppNavigator.context).showSnackBar(
    //   SnackBar(
    //     backgroundColor: Colors.white,
    //     content: const Text(
    //       'content',
    //       style: TextStyle(color: Colors.black),
    //     ),
    //     behavior: SnackBarBehavior.floating,
    //     margin: EdgeInsets.only(
    //       bottom: MediaQuery.of(AppNavigator.context).size.height - 100,
    //       right: 20,
    //       left: 20,
    //     ),
    //   ),
    // );

    // showDialog(
    //   context: AppNavigator.key.currentContext!,
    //   builder: (_) => BlocProvider.value(
    //     value: this,
    //     child: DecisionDialog(
    //       content: 'Test',
    //       onConfirm: () => logger.d('onConfirm'),
    //       onCancel: () => logger.d('onCancel'),
    //     ),
    //   ),
    // );
  }

  Future<void> sendToDecrypt() async {
    final frontendKeyPair = GetIt.I<CryptoService>().genRSAKeyPair(
      seed: 'YourSeedString',
    );

    final res000003 = await GetIt.I<Api000Service>().api000003(
      base64.encode(frontendKeyPair.public),
    );

    GetIt.I<CryptoService>().setBackendPublicKeyByte(
      base64.decode(res000003.data.pubKey),
    );

    const data = '''
Hello, Backend! Hello, Backend! Hello, Backend! Hello, Backend!
Hello, Backend! Hello, Backend! Hello, Backend! Hello, Backend!
    ''';

    final res000004 = await GetIt.I<Api000Service>().api000004(
      data,
    );

    const encrypted = 'test';

    // utf8.decode(
    //   GetIt.I<CryptoService>().doAESDecryption(
    //     base64.decode(res000004.data.encryptedData),
    //     key,
    //   ),
    // );

    // --------

    final decrypted = res000004.data.decryptedData;

    logger.d('Edward Test\n\n$encrypted\n$decrypted');
  }
}
