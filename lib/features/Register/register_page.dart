import 'package:apps_skripsi/core/theme/button_app.dart';
import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/text_filed.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/features/Register/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegisterProvider>(builder: (context, registerProvider, _) {
        return SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 56.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                      width: 178,
                      height: 57,
                      child: Image(
                        image: AssetImage("assets/images/LearnLingo.png"),
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                      width: 178,
                      child: Image(
                        image: AssetImage("assets/images/rafiki2.png"),
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  AreaTeks().normal(
                    editingController: registerProvider.namaController,
                    keamanan: false,
                    iconIsi: const Icon(Icons.person),
                    textIsi: "Nama Lengkap",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AreaTeks().normal(
                    editingController: registerProvider.emailController,
                    keamanan: false,
                    iconIsi: const Icon(Icons.email),
                    textIsi: "Email",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AreaTeks().normal(
                      editingController: registerProvider.passwordController,
                      keamanan: registerProvider.keamananPass,
                      iconIsi: const Icon(Icons.key),
                      textIsi: "Password",
                      iconBelakang: IconButton(
                          onPressed: () {
                            registerProvider.toggleKeamananPass();
                          },
                          icon: Icon(registerProvider.keamananPass
                              ? Icons.remove_red_eye
                              : Icons.visibility_off))),
                  const SizedBox(
                    height: 15,
                  ),
                  AreaTeks().normal(
                      editingController:
                          registerProvider.confPasswordController,
                      keamanan: registerProvider.keamananConfPass,
                      iconIsi: const Icon(Icons.key),
                      textIsi: "Konfirmasi Password",
                      iconBelakang: IconButton(
                          onPressed: () {
                            registerProvider.toggleKeamananConfPass();
                          },
                          icon: Icon(registerProvider.keamananConfPass
                              ? Icons.remove_red_eye
                              : Icons.visibility_off))),
                  const SizedBox(
                    height: 15,
                  ),
                  Tombol().primaryLarge(
                    teksTombol: "Daftar",
                    lebarTombol: double.maxFinite,
                    navigasiTombol: () {
                      registerProvider.register(
                          context,
                          registerProvider.emailController.text,
                          registerProvider.passwordController.text,
                          registerProvider.namaController.text);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Tipografi().s2(
                          isiText: "Sudah Punya Akun?",
                          warnaFont: Warna.netral1),
                      Tombol().TextLarge(
                        teksTombol: "Masuk",
                        lebarTombol: double.infinity,
                        navigasiTombol: () {
                          registerProvider.moveLogin(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
