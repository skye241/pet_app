import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/calendar_slide/calendar_slide_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonthPickerWidget extends StatefulWidget {
  const MonthPickerWidget({Key? key, this.numberOfMonth, this.onMonthSelect})
      : super(key: key);

  final int? numberOfMonth;
  final Function(DateTime startDate)? onMonthSelect;

  @override
  _MonthPickerWidgetState createState() => _MonthPickerWidgetState();
}

class _MonthPickerWidgetState extends State<MonthPickerWidget> {
  final MonthPickerCubit cubit = MonthPickerCubit();
  DateTime currentMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  @override
  void initState() {
    cubit.initEvent(widget.numberOfMonth, currentMonth);
    widget.onMonthSelect!(currentMonth);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonthPickerCubit, MonthPickerState>(
        bloc: cubit,
        builder: (BuildContext context, MonthPickerState state) {
          if (state is MonthPickerInitial) {
            return monthPicker(state);
          } else
            return Container();
        });
  }

  Widget monthPicker(MonthPickerInitial state) {
    return Container(
      height: 36,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Container(width: 16,),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  cubit.chooseMonth(
                      state.listDateTime[index], state.listDateTime);
                  widget.onMonthSelect!(state.listDateTime[index]);
                },
                child: Text(
                  'Tháng ' + state.listDateTime[index].month.toString(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: state.dateTime.month ==
                              state.listDateTime[index].month
                          ? AppThemeData.color_primary_90
                          : AppThemeData.color_black_40),
                ),
              ),
          itemCount: state.listDateTime.length),
    );
  }
}
