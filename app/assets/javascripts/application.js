// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require jquery.turbolinks
//= require popper
//= require bootstrap-sprockets
//= require turbolinks

//= require_tree .

// Delete confirmation modals

$(document).ready(() => {
  
    $('[data-toggle="tooltip"]').tooltip()
    
    $(".btn-delete").click(function(e) {
      e.preventDefault()
      $btn = $("#delete-confirm").find(".btn-danger")
      $href = $btn.attr("href")
      $slice = $(this).data("slice")
      console.log($(this).data("id"))
      $new = $href.replace($href.slice($slice), $(this).data("id"))
      $btn.attr("href", $new)
      $("#delete-confirm").modal("show")
    })
  })