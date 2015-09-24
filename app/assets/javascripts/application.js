// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require handlebars.runtime
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.de.js
//= require_tree ./templates
//= require_tree .

// Adds array difference functionality, source: http://stackoverflow.com/questions/1187518/javascript-array-difference
//Array.prototype.diff = function(a) {
//    return this.filter(function(i) {return a.indexOf(i) < 0;});
//};

// Deletes empty values in array, source: http://stackoverflow.com/questions/281264/remove-empty-elements-from-an-array-in-javascript
Array.prototype.clean = function(deleteValue) {
  for (var i = 0; i < this.length; i++) {
    if (this[i] == deleteValue) {         
      this.splice(i, 1);
      i--;
    }
  }
  return this;
};