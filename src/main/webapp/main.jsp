<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 4/24/2022
  Time: 9:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>File Upload </title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script
            src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>

<body>
<div class="container">
    <div class="col-md-8 col-md-offset-2">
        <h3>File Upload</h3>
        <form id="sampleUploadFrm" method="POST" action="#" enctype="multipart/form-data">
            <!-- COMPONENT START -->
            <div class="form-group">
                <div class="input-group input-file" name="file">
						<span class="input-group-btn">
							<button class="btn btn-default btn-choose" type="button">Choose</button>
						</span> <input type="text" id="form-upload" class="form-control"
                                       placeholder='Choose a file...' /> <span class="input-group-btn">
							<button class="btn btn-warning btn-reset" type="button">Reset</button>
						</span>
                </div>
                <p id="output"></p>
            </div>
            <!-- COMPONENT END -->
            <div class="form-group">
                <button type="button" class="btn btn-primary pull-right" id="uploadBtn">Submit</button>
                <button type="reset" class="btn btn-danger">Reset</button>
            </div>
        </form>
    </div>
</div>

<script>
    $(document).ready(function() {
        /*function file_validation() {
          $(".input-file").on("change", function () {
            /!* current this object refer to input element *!/
            var $input = $(this);
            /!* collect list of files choosen *!/
            var files = $input[0].files;
            var filename = files[0].name;
            /!* getting file extenstion eg- .jpg,.png, etc *!/
            var extension = filename.substr(filename.lastIndexOf("."));
            /!* define allowed file types *!/
            var allowedExtensionsRegx = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
            /!* testing extension with regular expression *!/
            var isAllowed = allowedExtensionsRegx.test(extension);
            if (isAllowed) {
              alert("File type is valid for the upload");
              /!* file upload logic goes here... *!/
            } else {
              alert("Invalid File Type.");
              return false;
            }
          });
        }

        file_validation();*/

        function bs_input_file() {
            $(".input-file").before(
                function() {
                    if ( ! $(this).prev().hasClass('input-ghost') ) {
                        var element = $("<input type='file' class='input-ghost' style='visibility:hidden; height:0'>");
                        element.attr("name",$(this).attr("name"));
                        element.change(function(){
                            element.next(element).find('input').val((element.val()).split('\\').pop());
                        });
                        $(this).find("button.btn-choose").click(function(){
                            element.click();
                        });
                        $(this).find("button.btn-reset").click(function(){
                            element.val(null);
                            $(this).parents(".input-file").find('input').val('');
                        });
                        $(this).find('input').css("cursor","pointer");
                        $(this).find('input').mousedown(function() {
                            $(this).parents('.input-file').prev().click();
                            return false;
                        });
                        return element;
                    }
                }
            );
        }

        bs_input_file();



        $("#uploadBtn").on("click", function() {
            var url = "uploader";
            var form = $("#sampleUploadFrm")[0];
            var data = new FormData(form);
            /* var data = {};
            data['key1'] = 'value1';
            data['key2'] = 'value2'; */
            $.ajax({
                type : "POST",
                encType : "multipart/form-data",
                url : url,
                cache : false,
                processData : false,
                contentType : false,
                data : data,
                success : function(msg) {
                    var response = JSON.parse(msg);
                    var status = response.status;
                    if (status == 1) {
                        //alert("File has been uploaded successfully");
                        $("#output").html('<b>' + "File has been uploaded successfully" + '</b>').delay(3000).fadeOut();
                    } else {
                        alert("Couldn't upload file");
                    }
                },
                error : function(msg) {
                    alert("Couldn't upload file");
                }
            });
        });
    });
</script>

</body>
</html>
