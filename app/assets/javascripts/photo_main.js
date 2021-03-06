/*
 * jQuery File Upload Plugin JS Example 6.5.1
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *                                       
 * https://github.com/blueimp/jQuery-File-Upload/wiki/Basic-plugin
 * https://github.com/blueimp/jQuery-File-Upload/wiki/API
 * https://github.com/blueimp/jQuery-File-Upload/wiki/Upload-directly-to-S3
 * https://github.com/blueimp/jQuery-File-Upload/wiki/Rails-setup-for-V6
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/*jslint nomen: true, unparam: true, regexp: true */
/*global $, window, document */

$(function () {

    function update(coords)
    {
      $('#photo_crop_x').val(coords.x)
      $('#photo_crop_y').val(coords.y)
      $('#photo_crop_w').val(coords.w)
      $('#photo_crop_h').val(coords.h)
    };

    $('#cropbox').Jcrop({
      boxWidth: 770,
      boxHeight: 433,
      onSelect: update,
      onChange: update
    });


    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
      autoUpload: true,
      uploadTemplate: function (o) {
        var rows = $();
        console.log("Inside photo_main.uploadTemplate");
        $.each(o.files, function (index, file) {
          console.log(file);
            var row = $('<li class="span3 card">' +
                '<div class="thumbnail">' +
                  '<div class="preview" style="text-align: center;"></div>' +
                  '<div class="progress progress-success progress-striped active">' +
                    '<div class="bar" style="width:0%;"></div>' +
                  '</div>' +
                '</div>');
            rows = rows.add(row);
        });
        return rows;
    },

    completed: function(e, data) {
      console.log(data, e);
      console.log("Inside photo_main.completed");
      $('a[href^="' + data.result[0].url + '"]').slimbox();
    },
    downloadTemplate: function (o) {
        var rows = $();     
        console.log("photo_main.downloadTemplate");
        $.each(o.files, function (index, file) {
            var row = $('<li class="span3 card" id="photo_' + file.photo_id + '">' +
                (file.error ? '<div class="name"></div>' +
                    '<div class="size"></div><div class="error" ></div>' :
                      '<div class="thumbnail">' +
                        '<a href="' + file.url +'" rel="lightbox-pictures" class="photo_' + file.id + '" title="'+file.name+'">' +
                          '<img src="" alt="">') +
                        '</a>' +
                        '<div class="caption">' +
                          '<div class="card_edit pull-right">' +
                            '<div class="btn-group">' +
                              '<a href="#" class="btn btn-mini dropdown-toggle" data-toggle="dropdown">' +
                                '<i class="icon-edit "></i>' +
                                  'Edit' +
                              '</a>' +
                                '<ul class="dropdown-menu">' +
                                '<li><a href="" class="btn-show" style="margin-right: 4px;">' +
                                  '<i class="icon-edit "></i>' +
                                  'Edit' +
                                '</a></li>' +
                                '<li><a class="btn-delete" confirm="Are you Sure?" data-remote=true data-method="delete" href="" >' +
                                  '<i class="icon-trash"></i>' +
                                  'Delete' +
                                '</a></li>' +
                                '</ul>' +
                            '</div>' +
                          '</div>' +
                        '</div>' +
                      '</div>');

            console.log("photo_main.downloadTemplate with new row")
            if (file.error) {
                row.find('.name').text(file.name);
                row.find('.error').text(
                    locale.fileupload.errors[file.error] || file.error
                );
            } else {
                if (file.thumbnail_url) {
                    row.find('img').prop('src', file.small_url);
                }
                row.find('.btn-delete')
                    .attr('href', '/photos/' + file.photo_id);
                row.find('.btn-show')
                    .attr('href', '/photos/' + file.photo_id + '/edit');
            }            
            rows = rows.add(row);
        });
        console.log("photo_main.downloadTemplate complete all rows");
        return rows;
        
    }

  });
});
