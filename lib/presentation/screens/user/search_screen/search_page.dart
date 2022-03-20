import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/station.dart';
import '../../../../logic/cubit/search_trains_cubit/search_trains_cubit.dart';
import 'widget/result_card.dart';
import 'widget/search_box.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  String startStation = "";
  String endStation = "";

  @override
  void dispose() {
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchTrainsCubit>(context).loadSearchSuggestions();
    return Scaffold(
      backgroundColor: AppColors.lightElv1,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              color: AppColors.lightElv0,
              child: Row(
                children: [
                  SizedBox(
                    width: 3.w,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SearchBox(
                          searchController: startController,
                          hintText: "Start",
                          onChanged: (startText) =>
                              BlocProvider.of<SearchTrainsCubit>(context)
                                  .showSuggestions(
                                      searchText: startText, isStart: true),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        SearchBox(
                          searchController: endController,
                          hintText: "End",
                          onChanged: (endText) =>
                              BlocProvider.of<SearchTrainsCubit>(context)
                                  .showSuggestions(
                                      searchText: endText, isStart: false),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  TextButton(
                    onPressed: () => BlocProvider.of<SearchTrainsCubit>(context)
                        .showResults(start: startStation, end: endStation),
                    child: Icon(
                      Icons.search_rounded,
                      color: AppColors.primaryColor,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<SearchTrainsCubit, SearchTrainsState>(
                listener: (context, state) {
                  if (state is SearchTrainsFailed) {
                    SnackBar snackBar = SnackBar(content: Text(state.errorMsg));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  if (state is SearchTrainsNoResults) {
                    SnackBar snackBar =
                        const SnackBar(content: Text("No results found!"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  if (state is SearchTrainsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }

                  if (state is SearchTrainsResults) {
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.trainDetailsList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          itemBuilder: (context, index) => ResultCard(
                              trainDetails: state.trainDetailsList[index]),
                        ),
                      ],
                    );
                  }
                  if (state is SearchTrainsSuggestions) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.stations.length,
                        itemBuilder: (context, index) {
                          final Station station = state.stations[index];
                          return InkWell(
                            splashColor:
                                AppColors.primaryColor.withOpacity(0.1),
                            onTap: () {
                              if (state.isStart) {
                                startController.text = station.name;
                                startStation = station.value;
                              } else {
                                endController.text = station.name;
                                endStation = station.value;
                              }
                            },
                            child: Container(
                              color: AppColors.lightElv0,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 2.h),
                              child: Text(
                                station.name,
                                style: TextStyle(
                                  color: AppColors.darkElv0,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          );
                        });
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
