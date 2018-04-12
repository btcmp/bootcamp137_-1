
<script type="text/javascript">
	jQuery(document).ready(function(){
		
//////////////////========================search-=================////
		
		$('input[name="daterange"]').daterangepicker(
			      {
			        ranges   : {
			          'Today'       : [moment(), moment()],
			          'Yesterday'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
			          'Last 7 Days' : [moment().subtract(6, 'days'), moment()],
			          'Last 30 Days': [moment().subtract(29, 'days'), moment()],
			          'This Month'  : [moment().startOf('month'), moment().endOf('month')],
			          'Last Month'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
			        },
			        startDate: moment().subtract(29, 'days'),
			        endDate  : moment()
			      },
			      function (start, end) {
			        $('input[name="daterange"]').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
			        awal = start.format('YYYY-MM-DD');
			        akhir = end.format('YYYY-MM-DD');
			        $.ajax({
						type : 'GET',
						url : '${pageContext.request.contextPath}/t/adjustment/src-rg-date?awal='+awal+'&akhir='+akhir,
						success : function(data){
							$('#tbody-adj').empty();
							console.log(data);
							$(data).each(function(key, val){
								
								var json_data = '/Date('+val.createdOn+')/';
								var asAMoment = moment(json_data);
								var tanggal = asAMoment.format('DD-MM-YYYY HH:mm:ss');
								
								$('#tbody-adj').append('<tr><td>'+tanggal+'</td>'
									+'<td>'+val.notes+'</td>'
									+'<td>'+val.status+'</td>'
									+'<td><a href="${pageContext.request.contextPath}/t/adjustment/detail/'+val.id+'" class="view btn btn-success btn-sm" key-id="'+val.id+'">View</a></td>');
							})
						},
						error : function(){
							$('#tbody-adj').empty();
							console.log('search failed');
						}
					});
			      }
			    )
				
				$(function() {
					var today = new Date();
					var dd = today.getDate();
					var mm = today.getMonth()+1; //January is 0!
					var yyyy = today.getFullYear();

					if(dd<10) {
					    dd = '0'+dd
					} 
					if(mm<10) {
					    mm = '0'+mm
					} 
					today = yyyy + '-' + mm + '-' + dd;
					
					$('#insert-target').daterangepicker({
				        singleDatePicker: true,
				        minDate: new Date(today),
				        showDropdowns: true
				    });
				});
		
		
		
		/* =================export pdf============= */
		$('#btn-export').on('click', function(){
			window.location = '${pageContext.request.contextPath}/generate/adjustment';
		});
		
		/* $('#dt-table').DataTable( {
	        "searching":   false,
	        "info":     false
	    }); */
		
		/* $(function() {
		    $('input[name="daterange"]').daterangepicker();
		});
		  */
		$(function() {
		    $('#insert-target').daterangepicker({
		        singleDatePicker: true,
		        showDropdowns: true,
		        dateFormat: 'dd-mm-yyyy'
		    });
		});
		
		$('#btn-create').on('click', function(){
			$('#modal-adj-input').modal();
		});
		
		$('#btn-add-item').on('click', function(){
			$('#modal-adj-input').modal('hide');
			$('#modal-adj-add-item').modal();
		});
 
		$('#btn-add-item-var').on('click', function(){
			$('#modal-adj-add-item').modal('hide');
			$('#modal-adj-input').modal('show');
			$('#btn-submit').show();
		});
		
		$('#btn-cancel-add').on('click', function(){
			$('#modal-adj-input').modal();
			clearFormSrc();
			//$('#btn-submit').hide();
		});
		
		$('#btn-cancel-input').on('click', function(){
			$('#btn-submit').hide();
			clearForm();
		});
		
		//save
		$('#btn-save').on('click', function(){
			
			var adjDet = [];
			var adjHis = [];
			
			$('#tbl-adj-add-item > tbody > tr').each(function(index, data) {
				var detail = {
						"inStock" : $(this).find('td').eq(1).text(),
						"actualStock" : $(this).find('td').eq(2).text(),
						"variant" : {
							"id" : $(this).attr('id-var')
						}
				};
				adjDet.push(detail);
				
				var history = {
						"status" :"Submitted"
						
				};
				adjHis.push(history);
				//console.log('tes');
			});
			
			
			//console.log(adjDet);
			
			var adj = {
				id : $('#input-id').val(),
				notes : $('#input-note').val(),
				status : "Submitted",
				outlet : {
					id : $('#input-outlet').val(),
				},
				adjustmentDetails : adjDet,
				adjustmentHistory: adjHis
			};
			console.log(adj);

			 $.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/t/adjustment/save',
				data : JSON.stringify(adj),
				contentType : 'application/json',
				success : function(data) {
					window.location = '${pageContext.request.contextPath}/t/adjustment';
					console.log(data)
				},
				error : function() {
					alert('save failed');
				}

			});  
		});
		
		//view detail
		$('.view').on('click', function(){
			var id = $(this).attr('id');
			console.log(id);
			window.location = '${pageContext.request.contextPath}/t/adjustment/detail?id=' + id;
			console.log(data);
		});
		
		var added = [];
		var addedQty = [];
		
		// search variant
		$('#src-item-variant').on('input',function(e){
			var word = $(this).val();
			if (word=="") {
				$('#tbl-add-item-purchase').empty();
			} else {
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/t/adjustment/search-item?search='+word,
					dataType: 'json',
					success : function(data){
						console.log(data);
						$('#tbl-add-item-purchase').empty();
						$.each(data, function(key, val) {
							var oTableItem = "<tr>"+
								'<td>'+ val.variant.item.name +'-'+ val.variant.name +'</td>' +
								'<td id="inStock'+ val.id +'">'+ val.beginning +'</td>' +
								'<td id="td-qty'+ val.id +'"><input type="number" id="add-qty'+ val.id +'" value="1" /></td>' +
								'<td><button type="button" id="'+ val.id +'" class="btn-add-item'+val.id +' btn-add-item btn btn-primary" id-var="'+val.variant.id+'">Add</button></td>' +
								"</tr>";
							
							$('#tbl-add-item-purchase').append(oTableItem);
						});
					}, 
					error : function(){
						$('#tbl-add-item-purchase').empty();
					}
				});
			}
		});
		
		//tambah tabel item ke modal create Adjustment
		$('#tbl-add-item-purchase').on('click', '.btn-add-item', function(){
			var element = $(this).parent().parent();
			var id = $(this).attr('id');
			var idVar = $(this).attr('id-var');
			var itemVar = element.find('td').eq(0).text();
			var inStock = element.find('td').eq(1).text();
			var reqQty = $('#add-qty'+id).val();
			
			if(added.indexOf(id.toString()) == -1) {
				var oTableAddItem = '<tr id-var="'+idVar+'" id="'+id+'"><td>'+itemVar+'</td>' +
					'<td>'+inStock+'</td>' +
					'<td>'+reqQty+'</td>' +
					'<td><button type="button" class="btn-cancel-item btn btn-danger" id="btn-del'+id+'" id-var="'+id+'">&times;</button>'
					'</tr>';
				$('#tbody-add-item').append(oTableAddItem);
				added.push(id);
			}else{
				var trItem = $('#tbody-add-item > #'+id+'');
				var oldReqQty = trItem.find('td').eq(2).text();
				var newReqQty = parseInt(oldReqQty)+parseInt(reqQty);
				trItem.find('td').eq(2).text(newReqQty);
			}
		});
		
		
		//cancel item
		$('#tbl-adj-add-item').on('click', '.btn-cancel-item', function(){
			var id = $(this).attr('id-var');
			console.log(id);
			$(this).parent().parent().remove();
			var index = added.indexOf(id.toString());
			if(index > -1){
				added.splice(index, 1);
			}
		});
		
		
		//edit Adjustment
		$('#dt-table').on('click', '.update', function(){
			var id = $(this).attr('id');
			//console.log(id);
			 $('#tbody-add-item').empty();
			$.ajax({
				type : 'GET',
				url : '${pageContext.request.contextPath}/mst/adjustment/get-one/'+id,
				dataType: 'json',
				success : function(data){
					console.log(data);
					$('#input-id').val(data.id);
					$('#input-note').val(data.notes);
					var date = data.readyTime.split('-');
					var dates = date[1]+'/'+date[2]+'/'+date[0];
					$('#insert-target').val(dates);
					
					$(data.prDetails).each(function(key, val){
						$('#tbody-add-item').append(
							'<tr id-var="'+val.variant.id+'"><td>'+val.variant.item.name+'-'+val.variant.name+'</td>'
							+'<td>12</td>'
							+'<td>'+val.requestQty+'</td>'
							+'<td><button type="button" class="btn btn-danger btn-cancel-item" id="btn-del'+id+'" id-var="'+id+'">&times;</button>'
						);
					})
					$('#modal-adj-input').modal();
				},
				error : function(){
					console.log('get data failed');
				}
			}); 
		});
		
		function clearForm() {
			$('#input-note').val('');
			$('#tbody-add-item').empty();
		}
		
		function clearFormSrc() {
			$('#src-item-variant').val('');
			$('#tbl-add-item-purchase').empty();
		}
	});
</script>