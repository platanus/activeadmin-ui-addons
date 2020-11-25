var initializer = function() {
  configureSelect2(document);

  $(document).on('has_many_add:after', function(event, container) {
    configureSelect2(container);
  });

  function configureSelect2(container) {
    if (ActiveadminAddons.config.defaultSelect == 'select2') {
      $('select:not(.default-select)', container).each(function(i, el) {
        setupSelect2(el);
      });
    }

    $('select.select2', container).each(function(i, el) {
      setupSelect2(el);
    });

    function setupSelect2(select) {
      var selectConfig = {
        placeholder: '',
        width: '80%',
        allowClear: true,
      };

      function isFilter(path) {
        return $(select).closest(path).length > 0;
      }

      if (isFilter('.select_and_search')) {
        selectConfig.width = 'resolve';
        selectConfig.allowClear = false;
      } else if (isFilter('.filter_select')) {
        selectConfig.width = 'resolve';
      }

      $(select).select2(selectConfig);

      // Related with https://github.com/select2/select2/issues/3320
      $(select).on('select2:unselecting', function() {
        $(this).data('unselecting', true);
      }).on('select2:open', function() {
        if ($(this).data('unselecting')) {
          $(this).select2('close').removeData('unselecting');
        }
      });
    }
  }
};

$(initializer);
$(document).on('turbolinks:before-visit', function(){
  $('.select2-hidden-accessible').select2('destroy');
});
$(document).on('turbolinks:load', initializer);
