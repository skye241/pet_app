import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/resources/register_pet/select_pet_type/select_pet_type_cubit.dart';
import 'package:family_pet/genaral/components/expandedWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPetTypeWidget extends StatefulWidget {
  const SelectPetTypeWidget({Key? key, @required this.onPetTypeSelected})
      : super(key: key);
  final ValueChanged<PetType>? onPetTypeSelected;



  @override
  _SelectPetTypeWidgetState createState() => _SelectPetTypeWidgetState();
}

class _SelectPetTypeWidgetState extends State<SelectPetTypeWidget> {
  final SelectPetTypeCubit cubit = SelectPetTypeCubit();

  @override
  void initState() {
    cubit.getListPet();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectPetTypeCubit, SelectPetTypeState>(
        bloc: cubit,
        builder: (BuildContext context, SelectPetTypeState state) {
          if (state is SelectPetTypeStateLoaded) {
            widget.onPetTypeSelected!(state.selectedPetType);
            return _loadedWidget(context, state);
          } else if (state is SelectPetTypeStateLoading) {
            return _loadingWidget(context);
          } else if (state is SelectPetTypeStateError) {
            return _errorWidget(context, state);
          }
          return Container();
        });
  }

  Widget _loadingWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(AppThemeData.color_primary_90),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppThemeData.color_black_10, width: 0.8)),
    );
  }

  Widget _errorWidget(BuildContext context, SelectPetTypeStateError state) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Text(
          state.message,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppThemeData.color_black_10, width: 0.8)),
    );
  }

  Widget _loadedWidget(BuildContext context, SelectPetTypeStateLoaded state) {
    return CustomExpansionTile(
      collapsedIconColor: AppThemeData.color_black_80,
      iconColor: AppThemeData.color_black_80,
      tilePadding: const EdgeInsets.only(left: 0, right: 12),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: _textWidget(context, state, state.selectedPetType),
      children: state.listPetType.map((PetType petType) {
        if (petType.id != state.selectedPetType.id) {
          return _textWidget(context, state, petType);
        } else
          return Container();
      }).toList(),
    );
  }

  Widget _textWidget(
      BuildContext context, SelectPetTypeStateLoaded state, PetType petType) {
    return InkWell(
      onTap: () {
        cubit.selectPetType(petType, state.listPetType);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                petType.name ?? '',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
