$(document).ready ->
  $('.js-bids').on 'change', 'input', ->
    if $('#bid_name').val() && $('#bid_phone').val() && $('#bid_email').val() && $('#bid_contract_number').val() && ($('#bid_installation_payment').val() && $('#bid_installation_payment_for_vendor').val())
      if ($('#bid_service_payment').val() && !$('#bid_service_payment_for_vendor').val()) || (!$('#bid_service_payment').val() && $('#bid_service_payment_for_vendor').val())
        $('.js-send-bid').attr("disabled", true)
      else
        $('.js-send-bid').attr("disabled", false)  
    else
      $('.js-send-bid').attr("disabled", true)

  $('.js-bids').on 'change', 'select', ->
    if $('#bid_name').val() && $('#bid_phone').val() && $('#bid_email').val() && $('#bid_contract_number').val() && ($('#bid_installation_payment').val() && $('#bid_installation_payment_for_vendor').val())
      if ($('#bid_service_payment').val() && !$('#bid_service_payment_for_vendor').val()) || (!$('#bid_service_payment').val() && $('#bid_service_payment_for_vendor').val())
        $('.js-send-bid').attr("disabled", true)
      else
        $('.js-send-bid').attr("disabled", false)  
    else
      $('.js-send-bid').attr("disabled", true)
