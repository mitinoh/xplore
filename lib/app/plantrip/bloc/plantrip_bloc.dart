import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'plantrip_event.dart';
part 'plantrip_state.dart';

class PlantripBloc extends Bloc<PlantripEvent, PlantripState> {
  PlantripBloc() : super(PlantripInitial()) {
    on<PlantripEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
