
$(document).on('ready page:load', function () {
  $(document).ready(function() {
    var addStreakTooltip = function() {
      $.getJSON( "/pages/streak_tooltip?user=" +  "<%= @user.id %>" ).done(function( response ) {
        console.log(response)
      // $('.' + '<%=  %>')
      for(i = 0; i < response.length; i++) {
        var public_answer_content = function() {
          var public_answer = response[i].public_answer
          if(public_answer == true) {
            return '<span>Esta respuesta es <strong>pública</strong>.</span>'
          } else {
            return '<span>Esta respuesta es <strong>privada</strong>.</span>'
          }
        }
        $('.' + response[i].answer + '.tooltip').tooltipster({
          content: $(' <span><strong>Pregunta: </strong>' + response[i].question + '</span><br><span><strong>Fecha: </strong>' + response[i].day + '</span> <br>' + public_answer_content() + '<br><span>Para ver tu respuesta haz click </span> <a href="/answers/'+ response[i].answer +'">aquí.</a>'),
          interactive: true
        })
      }
    }).fail(function( jqxhr, textStatus, error ) {
      var err = textStatus + ", " + error;
      console.log( "Request Failed: " + err );
    });
  }

  addStreakTooltip();

  $('i.public-private').on('click', function() {
    console.log('clicked');
    var className = $(this).hasClass('fa-unlock-alt');
    var answer_id = $(this).find('div').text();
    if (className == true) {
      console.log("De verde a rojo")
      $.getJSON( "/pages/public_private_switch?answer_id=" +  answer_id ).done(function( response ) {
        $('.public-private').removeClass('fa-unlock-alt')
        $('.public-private').addClass('fa-lock')
        $('*').filter(function() {
          return $(this).data('tooltipsterNs');
        }).tooltipster('destroy');
        addStreakTooltip();
      }).fail(function( jqxhr, textStatus, error ) {
        var err = textStatus + ", " + error;
        console.log( "Request Failed: " + err );
      });
    } else {
      console.log("De rojo a verde")
      $.getJSON( "/pages/public_private_switch?answer_id=" +  answer_id ).done(function( response ) {
        $('.public-private').removeClass('fa-lock')
        $('.public-private').addClass('fa-unlock-alt')
        $('*').filter(function() {
          return $(this).data('tooltipsterNs');
        }).tooltipster('destroy');
        addStreakTooltip();
      }).fail(function( jqxhr, textStatus, error ) {
        var err = textStatus + ", " + error;
        console.log( "Request Failed: " + err );
      });
    }
  })

});
$( ".answer .options a.btn-toggle-1" ).on( "click", function( event ) {event.preventDefault();});



jQuery(function() {
  return $("[data-behavior='delete']").on("click", function(e) {
    e.preventDefault();
    _this = $(this).attr('href');
    console.log(_this);

    return swal({
      title: '¿ Estás seguro ?',
      type: 'info',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: 'Sí, borrar',
      cancelButtonText: 'No',
      closeOnConfirm: false,
      closeOnCancel: true,
      showLoaderOnConfirm: true,
      allowOutsideClick: true
    }, (function(_this) {
      console.log(_this);
      return function(confirmed) {
        if (confirmed) {
          $.ajax({
            url: $(_this).attr("href"),
            dataType: "JSON",
            method: "DELETE",
            success: function() {
              location.reload();
              // return swal( 'Tu respuesta ha sido borrada.');
            }
          });
        } else {
          swal('Tu respuesta no fue borrada.');
        }
      };
    })(this));
  });
});



});
