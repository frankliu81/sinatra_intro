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
