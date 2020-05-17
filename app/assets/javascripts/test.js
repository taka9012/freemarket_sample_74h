$(document).on('turbolinks:load', ()=> {
  let index = [1,2,3,4,5,6,7,8,9,10];
  let wid = 127;
  $(".createMain__createContents__uploadImage__fileUp").on("click", ".delete-btn", function(){
    let targetIndex = Number($(this).attr("index"));
    index.push(targetIndex);
    if($(this).parent().parent().attr("class") == "image-preview-first"){
      $(".image-preview .image-preview__image:first").appendTo(".image-preview-first");
    }
    if(index.length > 6){
      $("#image-label").css("width",(index.length-5)*wid);
    }else if(index.length == 6){
      $("#image-field-second").remove();
      $(".image-preview").remove();
      $(".image-preview-first").attr("class", "image-preview");
      $(".image-field").css("display","flex");
    }else if(index.length == 1){
      $("#image-field-second").css("display","flex");
      $("#image-field-second").css("width",index.length*wid);
    }else{
      $("#image-field-second").css("width",index.length*wid);
    }
    $("#image-label").attr("for",`item_images_attributes_${targetIndex}_src`);
    $(this).parent().remove();
    $(`#item_images_attributes_${targetIndex}_src`).remove();
    $(".createMain__createContents__uploadImage__fileUp").append(`<input class="file-field" type="file" name="item[images_attributes][${targetIndex}][src]" id="item_images_attributes_${targetIndex}_src">`);

  });
  let buildImage = function(url){
    if(index.length != 0){
      $(".image-preview").append(`
        <div class="image-preview__image">
        <img class="image-preview__image__img" src="${url}">
        <div class="delete-btn" index=${index[0]}><ul>削除</ul></div>
      `);
      $(".createMain__createContents__uploadImage__fileUp").append(`<input class="file-field" type="file" name="item[images_attributes][${index[0]}][src]" id="item_images_attributes_${index[0]}_src">`);
      $("#image-label").attr("for",`item_images_attributes_${index[0]}_src`);
      index.shift();
      if(index.length > 5){
        $("#image-field-second").remove();
        $(".image-field__text").remove();
        $(".image-field").css("display","flex");
        $("#image-label").css("width",(index.length-5)*wid);
      }else if(index.length == 5){
        $(".image-field").css("display","none");
        $("#image-label").append(`
          <div class="image-field" id="image-field-second">
            <i class="fas fa-camera"></i>
            <div class="image-field__text">
              クリックしてファイルをアップロード
            </div>
          </div>
        `);
        $(".image-preview").attr("class", "image-preview-first");
        $(".image-preview-first").after(`<div class="image-preview"></div>`);

      }else if(index.length == 0){
        $("#image-field-second").css("display","none");
      }else if(index.length < 5){
        $(".image-field__text").remove();
      }
      $("#image-field-second").css("width",index.length*wid);
    }
  }
  $(".createMain__createContents__uploadImage__fileUp").on("change", function(e){
    let blob = window.URL.createObjectURL(e.target.files[0]);
    buildImage(blob);
  });
});