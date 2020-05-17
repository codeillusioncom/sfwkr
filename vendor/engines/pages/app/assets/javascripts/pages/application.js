function openFragmentEditor(e) {
  e.preventDefault();
  var url = e.currentTarget.href;
  $('#fragmentEditor').modal('show').find('.modal-content').load(url);
}

function syncronizeJSON(object) {
  var fragmentName = object.target.id.split("_")[1];
  var originalJson = JSON.parse($('#fragment_value').val());
  originalJson[fragmentName] = object.target.value;
  $('#fragment_value').val(JSON.stringify(originalJson));
}

$(document).on("turbolinks:load", function() {
  $('.fragmentEditorButton').on('click', function(e){
    openFragmentEditor(e);
  });
  $('#input_title').on('input', syncronizeJSON);
})
