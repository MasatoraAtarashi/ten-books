(function($){
  $(function(){

    $('.sidenav').sidenav();

  }); // end of document ready
})(jQuery); // end of jQuery name space

// eventをDOMContentLoaded => turbolinks:loadに変更
document.addEventListener('turbolinks:load', function() {
  // querySelectorでdropdownの要素を取得
  var elems = document.querySelectorAll('.dropdown-trigger');
  // オプションを指定。今回はなし
  var options = {};
  // 初期化を行う
  M.Dropdown.init(elems, options);
});
