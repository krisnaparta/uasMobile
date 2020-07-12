import 'package:flutter/material.dart';
import './components/indonesia.dart';
import './components/world.dart';
import 'package:provider/provider.dart';
import 'package:covid_track/providers/covid_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Corona Track'),
      ),
      //PENERAPAN REFRESH INDICATOR AGAR KETIKA LAYAR DITARIK DARI ATAS KE BAWAH, MAKA SECARA OTOMATIS AKAN MELOAD DATA BARU
      body: RefreshIndicator(
        //MENGGUNAKAN ATTRIBUTENYA YAKNI ONREFRESH
        //DAN AKAN MEMANGGIL FUNGSI GETDATA YANG SUDAH DIBUAT PADA COVID PROVIDER
        onRefresh: () =>
            Provider.of<CovidProvider>(context, listen: false).getData(),
        child: Container(
          margin: const EdgeInsets.all(10),
          //KEMUDIAN KETIKA APP DIBUKA, MAKA FUNGSI FUTURE BUILDER AKAN DIJALANKAN
          child: FutureBuilder(
            //DAN MELOAD DATA DARI API MENGGUNAKAN FUNGSI YANG SAMA
            future:
                Provider.of<CovidProvider>(context, listen: false).getData(),
            builder: (context, snapshot) {
              //JIKA MASIH LOADING
              if (snapshot.connectionState == ConnectionState.waiting) {
                //MAKA TAMPILKAN LOADING INDIKATOR
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<CovidProvider>(
                builder: (context, data, _) {
                  return Column(
                    children: <Widget>[
                      //MENAMPILKAN DATA INDONESIA YANG WIDGETNYA KITA PISAHKAN KE FILE TERSENDIRI
                      Flexible(
                        flex: 1,
                        child: Indonesia(
                          height: height,
                          data: data,
                        ),
                      ),
                      //MENAMPILKAN DATA DUNIA DENGAN CARA YANG SAMA
                      Flexible(
                        flex: 1,
                        child: World(
                          height: height,
                          data: data,
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
