jQuery(document).ready(function(){
		
		//setup datatables
		$('#emp-table').DataTable();
		
		//event listener delete
		$('.delete').on('click',function(){
			var id = $(this).attr('id');
			var conf = confirm("Delete this data?");
			if(conf==true){
				//delete data
				window.location = "${pageContext.request.contextPath}/employee/delete/"+id;
			}
			return false;
		});
		
		//onClick submit ajax
		$('#save').on('click',function(evt){
			evt.preventDefault();
			var name = $('#name').val();
			var email = $('#email').val();
			var address = $('#address').val();
			var salary = $('#salary').val();
			var employee = {
				'name' : name,
				'email' : email,
				'address' : address,
				'salary' : salary
			};
			console.log(employee);
			//ajax
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/ajax-emp/save',
				data : JSON.stringify(employee),
				contentType : 'application/json',
				success : function(){
					window.location = '${pageContext.request.contextPath}/ajax-emp';
				}, error : function(){
					alert('save failed');
				}
				
			});
			
		});
	});