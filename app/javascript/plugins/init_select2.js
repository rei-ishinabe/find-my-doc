import 'select2';

const initSelect2 = () => {
 $('select2').select2({
      theme: 'bootstrap4',
      width: 'style',
      placeholder: $(this).attr('placeholder'),
      allowClear: Boolean($(this).data('allow-clear')),
  }); // (~ document.querySelectorAll)
};

export { initSelect2 };
