import 'package:flutter/material.dart';
import 'package:question_one/view/home/homeViewModel.dart';
import 'package:stacked/stacked.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Assignment Question One')),
          body: Center(
              child: viewModel.isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Center(
                              child: Text(
                                  'Total Images = ${viewModel.listOfPhotos.length}')),
                          Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5.0,
                                    mainAxisSpacing: 5.0,
                                  ),
                                  itemCount: viewModel.listOfPhotos.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0,
                                                scrollable: true,
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height: 600,
                                                      child: ListView(
                                                        children: <Widget>[
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Center(
                                                            child:
                                                                Image.network(
                                                              viewModel
                                                                  .listOfPhotos[
                                                                      index]
                                                                  .url,
                                                              height: 500,
                                                              width: 500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: Image.network(viewModel
                                            .listOfPhotos[index].thumbnailUrl),
                                      ),
                                    );
                                  }))
                        ],
                      ),
                    )),
        );
      },
    );
  }
}
