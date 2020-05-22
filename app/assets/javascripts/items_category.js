$(document).on('turbolinks:load', function(){   //ターボリンク読んだら下記実行
  $(function(){

    function appendOption(category){
      let html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }

    function appendChildrenBox(insertHTML){
      let childSelectHtml = '';
      childSelectHtml = `<div class="margin-top" id="children_wrapper">
      <div class="createMain__createContents__uploadItemDetail__categorySelect">
      <select class="tag" name="item[category_id]" id="child_category">
      <option value="選択して下さい" data-category="---">選択して下さい</option>
      ${insertHTML}
      </select>
      <i class="fas fa-chevron-down tag-icon"></i>
      </div></div>`;
      $('.createMain__createContents__uploadItemDetail__box').append(childSelectHtml);
    }

    function appendGrandchildrenBox(insertHTML){
      let grandchildSelectHtml = '';
      grandchildSelectHtml = `<div class="margin-top" id="grandchildren_wrapper">
      <div class="createMain__createContents__uploadItemDetail__categorySelect">
      <select class="tag" name="item[category_id]" id="grandchild_category">
      <option value="選択して下さい" data-category="---">選択して下さい</option>
      ${insertHTML}
      </select>
      <i class="fas fa-chevron-down tag-icon"></i>
      </div></div>`;
      $('.createMain__createContents__uploadItemDetail__box').append(grandchildSelectHtml);
    }


    // 親カテゴリー選択時のイベント
    $('#item_category_id').on('change', function(){
      // 選択された親カテゴリのidを取得
      let parent_category_id = document.getElementById('item_category_id').value;
      if (parent_category_id != ""){
        $.ajax({
          url: '/items/category/get_category_children',
          type: 'GET',
          data: { parent_id: parent_category_id },
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove();
          $('#grandchildren_wrapper').remove();
          let insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
      }
    });

    // 小カテゴリー選択時のイベント
    $('.createMain__createContents__uploadItemDetail__box').on('change', '#child_category', function(){
      let child_category_id = $('#child_category option:selected').data('category');
      if (child_category_id != "---"){
        $.ajax({
          url: '/items/category/get_category_grandchildren',
          type: 'GET',
          data: { child_id: child_category_id },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0){
            $('#grandchildren_wrapper').remove();
            let insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchildrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#grandchildren_wrapper').remove();
      }
    });
  });
});