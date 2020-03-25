$(function(){
  $("#apply_confirm").click(function(){
    $.confirm({
      'title'     : '確認',
      'message'   : '1度応募するとキャンセルできません。',
      'buttons'   : {
         '参加する': function() {
           //OKボタンの処理
           $(this).dialog('close');
         },
         'キャンセル': function() {
           //キャンセルボタンの処理
           $(this).dialog('close');
         }
      }
   });
 });
});