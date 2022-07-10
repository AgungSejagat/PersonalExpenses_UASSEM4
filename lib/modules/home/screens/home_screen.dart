import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_made/modules/home/providers/home_provider.dart';
import 'package:uas_made/widget/month_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Personal Expenses'),
      ),
      body: FutureBuilder<void>(
        future: context.read<HomeProvider>().findAllAmount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Consumer<HomeProvider>(
            builder: (context, value, child) {
              final double itemHeight = (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
              final double itemWidth = MediaQuery.of(context).size.width / 1.5;

              return Container(
                margin: const EdgeInsets.all(12),
                child: GridView.count(
                  primary: false,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: itemHeight / itemWidth,
                  children: [
                    MonthCard(
                      month: value.datas[0]['month'],
                      spending: value.datas[0]['spend'],
                    ),
                    MonthCard(
                      month: value.datas[1]['month'],
                      spending: value.datas[1]['spend'],
                    ),
                    MonthCard(
                      month: value.datas[2]['month'],
                      spending: value.datas[2]['spend'],
                    ),
                    MonthCard(
                      month: value.datas[3]['month'],
                      spending: value.datas[3]['spend'],
                    ),
                    MonthCard(
                      month: value.datas[4]['month'],
                      spending: value.datas[4]['spend'],
                    ),
                    MonthCard(
                      month: value.datas[5]['month'],
                      spending: value.datas[5]['spend'],
                    ),
                    MonthCard(
                      month: value.datas[6]['month'],
                      spending: value.datas[6]['spend'],
                    ),
                    MonthCard(
                      month: value.datas[7]['month'],
                      spending: value.datas[7]['spend'],
                    ),
                    MonthCard(
                      month: value.datas[8]['month'],
                      spending: value.datas[8]['spend'],
                    ),
                    MonthCard(
                      month: value.datas[9]['month'],
                      spending: value.datas[9]['spend'],
                    ),
                    MonthCard(
                      month: value.datas[10]['month'],
                      spending: value.datas[10]['spend'],
                    ),
                    MonthCard(
                      month: value.datas[11]['month'],
                      spending: value.datas[11]['spend'],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
