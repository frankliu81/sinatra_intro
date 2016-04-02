$(document).ready(function(){
    $(".task-container").click(function(e){
        //$(this).hide();
        var $taskItemNote =  $(".task-item-note");
        // if ($taskItemNote.is(":visible") == true)
        // {
        //   $taskItemNote.hide();
        // }
        // else
        // {
          // truncate "task-container-id-""
          // "data-123".replace('data-','');
          taskContainerId = $(this).attr('id').replace('task-container-id-', '');
          // alert(taskId)
          $.ajax({
              type: "GET",
              url: "/view_task_note",
              data: { taskId: taskContainerId },
              }).done(function(data) {

                $taskItemNote.html(data.note)
                $taskItemNote.show();

              e.preventDefault();
          });
        //}
    });

  $(".task-item-note").click(function(){
    var $this = $(this);
    $this.hide()
  });

});
