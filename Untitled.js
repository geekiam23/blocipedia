
function changeVisibility(rowIdNum, radioIdNum, checkIdNum){
  $(rowIdNum).hide()
  $(radioIdNum).click(function() {
      var answer = $(radioIdNum).val();
        if (answer == "Yes") {
          if ($(checkIdNum).click(function() {
              if ($(this).is(':checked')) {
                $(rowIdNum).show()
                  if (parent.sizeIFrame != null) { parent.sizeIFrame();}
              }else {$(rowIdNum).hide()
              }
          }));
        }else {$(rowIdNum).hide()
        }
  })
}
