// import 'package:cubit/features/todo/cubit/Todo_state.dart';
// import 'package:cubit/model/Todo_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class TodoCubit extends Cubit<TodoState>{
//   TodoCubit():super(TodoInitial()){
//     getallTodos();
//   }



//  void getallTodos(){
// emit(TodoLoaded([]));
//  } 

//  void addTodo(TodoModel toDo){ 
//   final currentState=state;
//   if(currentState is TodoLoaded){
//     final newlist= [...currentState.todoList,toDo];
//     emit(TodoLoaded(newlist));
//   }
//  }

//  void deleteTodo(int id){
//   final currentState=state;
//   if(currentState is TodoLoaded){

// final newlist=currentState.todoList.where((element) => element.id!=id).toList();

// emit(TodoLoaded(newlist));

//   }
//   updateTodoList();
//  }
// void updateTodoList(){
//   final currentState=state;

//   if(currentState is TodoLoaded){
//     emit(TodoLoaded([]));
//   }
// }
//  void changeIscomplete(int productId){
// final currentState=state;

//   if(currentState is TodoLoaded){
// final fav =currentState.todoList.firstWhere((e)=>e.id==productId);
//   fav.iscomplete=!fav.iscomplete;

//   emit(TodoLoaded(List.from(currentState.todoList)));

//   }
//  }
// }