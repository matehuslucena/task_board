// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

function refresh_table(board_id){
	$.ajax({
		dataType: "json",
		type: "POST",
		url: "/tasks/"+board_id.value,
		success: function(data){
			$('.table tbody tr').remove();
			var html = '';
			$.each(data, function(index, element) {
	            html += '<tr>'+
	            			'<td>'+ element.title + '</td>'+
	            			'<td>' + element.priority + '</td>'+
	             		   	'<td>' + element.status_id + '</td>'+
	            			'<td>' + element.board_id + '</td>'+
	            			'<td class="acoes"><a href="/tasks/'+element.id+'"  class="btn btn-primary">Show</a></td>'+
        					'<td class="acoes"><a href="/tasks/'+element.id+'/edit"  class="btn btn-primary">Edit</a></td>'+
        					'<td class="acoes"><a href="#" class="btn btn-danger" onclick="apagaRegistro('+element.id+')">Destroy</a></td>'
	            		'</tr>';
	        });
			$('.table').append(html);
	    }
	});
}

function apagaRegistro(id){
	var answer = confirm ("Are you sure you want to delete?");
	if(answer){
		$.ajax({
			dataType: "html",
			type: "DELETE",
			url: "/tasks/"+id,
			success: function(data){
				$('#notice').prepend('<%=j notice %>');
			}
		});
	}
}