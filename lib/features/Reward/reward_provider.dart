import 'package:apps_skripsi/core/models/reward_api.dart';
import 'package:apps_skripsi/core/service/reward_models.dart';
import 'package:apps_skripsi/core/theme/button_app.dart';
import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/core/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class RewardProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _hasError;
  RewardApi? _rewardApi;
  final RewardModels _rewardModels = RewardModels();

  bool get isLoading => _isLoading;
  String? get hasError => _hasError;
  RewardApi? get rewardApi => _rewardApi;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _hasError = value;
    notifyListeners();
  }

  void setReward(RewardApi? value) {
    _rewardApi = value;
    notifyListeners();
  }

  Future<void> showDialogRedeem(BuildContext context, String imageItem,
      String title, int poin, String description, String term) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset(imageItem),
              ),
              const SizedBox(width: 10),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tipografi().s2(
                      isiText: title,
                      warnaFont: Warna.netral1,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Tipografi().C(
                          isiText: 'Poin',
                          warnaFont: Warna.netral1,
                        ),
                        Tipografi().C(
                          isiText: poin.toString(),
                          warnaFont: Warna.netral1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tipografi().s2(
                  isiText: 'Description Item',
                  warnaFont: Warna.netral1,
                ),
                const SizedBox(height: 8),
                Tipografi().C(
                  isiText: description,
                  warnaFont: Warna.netral1,
                ),
                const SizedBox(height: 8),
                Tipografi().s2(
                  isiText: 'Term Item',
                  warnaFont: Warna.netral1,
                ),
                const SizedBox(height: 8),
                Tipografi().C(
                  isiText: term,
                  warnaFont: Warna.netral1,
                ),
              ],
            ),
          ),
          actions: [
            Tombol().TextLarge(
                teksTombol: 'Tutup',
                lebarTombol: double.infinity,
                navigasiTombol: () {
                  Navigator.pop(context);
                }),
            Tombol().primarySmall(
                teksTombol: 'Redeem',
                lebarTombol: double.infinity,
                navigasiTombol: () {}),
          ],
        );
      },
    );
  }

  Future<void> reward() async {
    setLoading(true);
    setError(null);

    try {
      final token = await Token().getToken();
      final rewardData =
          await _rewardModels.rewardModels(token ?? 'Token Not Found!');
      if (rewardData != null) {
        setReward(rewardData);
      } else {
        setReward(null);
      }
    } catch (e) {
      setError(e.toString());
      cleanData();
    } finally {
      setLoading(false);
    }
  }

  void cleanData() {
    setError(null);
    setReward(null);
  }
}
