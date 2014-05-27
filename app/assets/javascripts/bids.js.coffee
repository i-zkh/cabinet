$(document).ready ->

  $('body').on 'change', '#bid_installation_payment', ->
    if $('#bid_installation_payment').val() && $('#bid_installation_payment_for_vendor').val()
      if !$('#bid_service_payment').val() && $('#bid_service_payment_for_vendor').val() || $('#bid_service_payment').val() && !$('#bid_service_payment_for_vendor').val()
        $('.js-send-bid').attr("disabled", true)
      else
        $('.js-send-bid').attr("disabled", false) 
    else
        $('.js-send-bid').attr("disabled", true) 

  $('body').on 'change', '#bid_installation_payment_for_vendor', ->
    if $('#bid_installation_payment').val() && $('#bid_installation_payment_for_vendor').val()
      if !$('#bid_service_payment').val() && $('#bid_service_payment_for_vendor').val() || $('#bid_service_payment').val() && !$('#bid_service_payment_for_vendor').val()
        $('.js-send-bid').attr("disabled", true)
      else
        $('.js-send-bid').attr("disabled", false) 
    else
        $('.js-send-bid').attr("disabled", true) 

  $('body').on 'change', '#bid_service_payment', ->
    if $('#bid_service_payment').val() && $('#bid_service_payment_for_vendor').val()
      if !$('#bid_installation_payment').val() && $('#bid_installation_payment_for_vendor').val() || $('#bid_installation_payment').val() && !$('#bid_installation_payment_for_vendor').val()
        $('.js-send-bid').attr("disabled", true)
      else
        $('.js-send-bid').attr("disabled", false) 
    else
        $('.js-send-bid').attr("disabled", true) 

  $('body').on 'change', '#bid_service_payment_for_vendor', ->
    if $('#bid_service_payment').val() && $('#bid_service_payment_for_vendor').val()
      if !$('#bid_installation_payment').val() && $('#bid_installation_payment_for_vendor').val() || $('#bid_installation_payment').val() && !$('#bid_installation_payment_for_vendor').val()
        $('.js-send-bid').attr("disabled", true)
      else
        $('.js-send-bid').attr("disabled", false) 
    else
        $('.js-send-bid').attr("disabled", true) 