// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// import "jquery";
// import "popper.js";
// import "bootstrap";

import '@fortawesome/fontawesome-free/js/all'
import "../stylesheets/application"
import "../stylesheets/layouts/footer.scss"
import "../stylesheets/layouts/header.scss"
import "../stylesheets/public/homes.scss"
import "../stylesheets/admin/a_users.scss"
import "../stylesheets/public/favorites.scss"
import "../stylesheets/public/post_comments.scss"
import "../stylesheets/public/relationships.scss"
import "../stylesheets/public/posts.scss"
import "../stylesheets/public/users.scss"
import "../stylesheets/public/notifications.scss"


Rails.start()
Turbolinks.start()
ActiveStorage.start()

/* global $*/
$(document).on('turbolinks:load', function () {
    // .openbtnをクリックした際の設定
  $(".openbtn").click(function () {
      $(this).toggleClass('active');//ボタン自身に activeクラスを付与し
      $(".area_nav_header").toggleClass('panelactive');//ナビゲーションにpanelactiveクラスを付与
  });
//   .page-topをクリックした際の設定
  $('.footer .page-top').click(function () {
      $('body,html').animate({
          scrollTop: 0//ページトップまでスクロール
      }, 800);//ページトップスクロールの速さ。数字が大きいほど遅くなる
      return false;//リンク自体の無効化
  });
// スクロールの表示
 $(window).scroll(function () {
     let scrollTopValue = $(document).scrollTop();
    //  スクロールの量が500を超えたら
     if (scrollTopValue > 150) {
        //  アイコンを表示
     $('.footer .page-top').fadeIn();
     } else {
        //  スクロールの量が150を超えてなければ
     $('.footer .page-top').fadeOut();
     }
　});
});
