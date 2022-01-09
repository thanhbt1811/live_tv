import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:live_tv/bloc/give_star_bloc/give_star_state.dart';
import 'package:live_tv/bloc/snackbar_bloc/bloc.dart';
import 'package:live_tv/bloc/snackbar_bloc/snackbar_type.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/key_constants.dart';
import 'package:live_tv/services/live_stream_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiveStarBloc extends Cubit<GiveStarState> {
  final StreamServices streamServices;
  final SnackbarBloc snackbarBloc;

  GiveStarBloc(this.streamServices, this.snackbarBloc)
      : super(GiveStarState.initial());

  Future<void> getclientSecret(int amount, int streamId) async {
    emit(
      state.copyWith(
        status: GiveStarStatus.loading,
      ),
    );
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final accessToken = preferences.getString(KeyConstnants.accessToken);
    final clientSecret = await streamServices.giveStars(
      Configuration.getBearerAuth(accessToken ?? ''),
      streamId,
      {'amount': amount},
    );
    emit(
      state.copyWith(status: GiveStarStatus.getted),
    );
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          style: ThemeMode.dark,
          merchantCountryCode: 'US',
          merchantDisplayName: 'United States'),
    );
    try {
      await Stripe.instance.presentPaymentSheet();
      emit(
        state.copyWith(status: GiveStarStatus.success),
      );
    } catch (e) {
      snackbarBloc.add(
        ShowSnackbar(type: SnackBarType.error, translationKey: e.toString()),
      );
    }
  }
}
