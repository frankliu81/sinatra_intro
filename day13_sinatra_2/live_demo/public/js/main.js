// polling
function doPoll(){
  // $.post('ajax/test.html', function(data) {
  //     alert(data);  // process results here
  //     setTimeout(doPoll,5000);
  // });

  // Tries refresh whole page if in list_task view every 3 secs:
  // this will constantly refresh
  // http://stackoverflow.com/questions/7694619/how-to-send-a-get-request-with-params-without-ajax
  // if (window.location.pathname == "/list_task")
  // {
  //   console.log("doPoll list_task");
  //   $('html').load('/list_task');
  //   setTimeout(doPoll,3000);
  // }

  // ajax call (TODO: define /list_task_api)
  // $.ajax({
  //     type: "GET",
  //     url: "/list_task_api",
  //     data: { },
  //     }).done(function(data) {
  //       console.log(data.taskList);
  //     });
  //
  //     setTimeout(doPoll,3000);
  // });

}

// Refresh page every three seconds, this will wipe out the note though:
// setTimeout(function(){
//   if (window.location.pathname == "/list_task")
//   {
//     window.location.reload(1);
//   }
// }, 3000);

$(document).ready(function(){


    $(".task-item").click(function(e){
      var $taskItemNote =  $(".task-item-note");
      taskItemIndex = $(this).attr('id').replace('task-item-', '');
      taskId = parseInt(taskItemIndex) + 1

      taskItemPosition = $(this).position();
      console.log("taskItem top: " + taskItemPosition.top);
      deleteBtnPosition = $(".btn-task-delete").position();

      // alert(taskItemId);
      $.ajax({
          type: "GET",
          url: "/view_task_note",
          data: { taskIndex: taskItemIndex },
          }).done(function(data) {

            $taskItemNote.html("Notes " + taskId + ": <br>" + data.note)
            // show and hide works with display:none, but i'm using
            // display: flex
            // $taskItemNote.show
            $taskItemNote.css('visibility', 'visible');
            // fadeIn requires element to be hidden (ie. display: none)
            // http://stackoverflow.com/questions/3398882/jquery-fadein-not-working
            $taskItemNote.hide().fadeIn(300);

            console.log(taskItemPosition.top.toString());
            //console.log("before setting top")
            //console.log($taskItemNote.css('top'));
            $taskItemNote.css('top', taskItemPosition.top.toString() + "px");
            $taskItemNote.css('left', (deleteBtnPosition.left + 50).toString() + "px");
            //console.log("after setting top")
            //console.log($taskItemNote.css('top'));


          e.preventDefault();
      });

  });

  $(".task-item-note").click(function(){
    var $this = $(this);
    // show and hide works with display:none
    // $this.hide()
    $this.fadeOut(300, 0);
    $this.css('visibility', 'hidden');

  });

  $( window ).resize(function() {
    var $taskItemNote =  $(".task-item-note");
    deleteBtnPosition = $(".btn-task-delete").position();
    $taskItemNote.css('left', (deleteBtnPosition.left + 50).toString() + "px");
  });

});
