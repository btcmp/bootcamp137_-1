<script type="text/javascript">
	jQuery(document).ready(function(){
		/*=================search item=====================  */
		$(document).on('input','#insert-search',function(e){
			var word = $(this).val();
			var idOut=$('#list-by-outlet').val();
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/mst/item-outlet/search-item?search='+word+'&idOut='+idOut,
					dataType: 'json',
					success : function(data){
						$('.tbody-item-list').empty();
						 var idInv=[];
						 $.each(data, function(key, inventory){		
							var idInv=inventory.id;
							var idIn=inventory.variant.item.id;
							var item=inventory.variant.item.name;
							var category=inventory.variant.item.categoryId.id;
							
							var markup = "<tr ><td style='text-align:center;'>"+ inventory.variant.item.name+
																				" - "+inventory.variant.name +
								"</td><td style='text-align:center;'>" + inventory.variant.item.categoryId.name + 
								"</td><td style='text-align:center;'>" + inventory.variant.price + 
								"</td><td style='text-align:center;'>" + inventory.beginning+ 
								"</td><td style='text-align:center;'>" + inventory.alertAtQty+ 
			 					"</td><td style='text-align:center;'><a id='"+inventory.variant.item.id+"' class='btn-item-edit btn btn-info btn-sm' href='#'>Edit</a></td></tr>";
						
							$(".tbody-item-list").append(markup);
							//console.log(idIn);
						}); 
						console.log(data);
		 			}, 
					error : function(){
						$
					}
				});
			
		});
		
		
		/* =======================LIST ITEM =========================*/
		/*list By outlet  */
		 $('#list-by-outlet').on('input',function(e){
			e.preventDefault();
			var id = $(this).val();
				$.ajax({
					type : 'PUT',
					url : '${pageContext.request.contextPath}/mst/item-outlet/get-item/'+id,
					contentType:'application/json',
					success : function(result){
						$('.tbody-item-list').empty();
						 var idInv=[];
						 $.each(result, function(key, inventory){		
							var idInv=inventory.id;
							var idIn=inventory.variant.item.id;
							var item=inventory.variant.item.name;
							var category=inventory.variant.item.categoryId.id;
							
							var markup = "<tr ><td style='text-align:center;'>"+ inventory.variant.item.name+" - "+inventory.variant.name +
								"</td><td style='text-align:center;'>" + inventory.variant.item.categoryId.name + 
								"</td><td style='text-align:center;'>" + inventory.variant.price + 
								"</td><td style='text-align:center;'>" + inventory.beginning+ 
								"</td><td style='text-align:center;'>" + inventory.alertAtQty+ 
			 					"</td><td style='text-align:center;'><a id='"+inventory.variant.item.id+"' class='btn-item-edit btn btn-info btn-sm' href='#'>Edit</a></td></tr>";
						
							$(".tbody-item-list").append(markup);
							//console.log(idIn);
						}); 
		 			}, 
					error : function(){
						$
					}
				});	
		});
		
		
		/* =================export pdf============= */
			$('#btn-export-item').on('click', function(){
				window.location = '${pageContext.request.contextPath}/generate/item';
			});
		 
		/* ============================================New ITEM=============================== */
		/* create new item */
		$('#btn-create').on('click', function(){
			$('#modal-create-item').modal('show');
		});
		
		
		
		/* btn show form add variant */
		 $('#btn-add-variant').on('click', function(){
			 $('#modal-add-variant').modal('show');
			
		});
		 
		 /* add variant */
		 $('#btn-add-item-variant').on('click', function(){
			 var form = $('#form-variant');
				var valid = form.parsley().validate();
				var markup = "<tr class='row-add-variant'><td>" + $('#input-variant-name').val()+ 
					"</td><td style='text-align:center;'>" + $('#input-variant-price').val() + 
					"</td><td style='text-align:center;'>" + $('#input-variant-sku').val() + 
					"</td><td style='text-align:center;'>" + $('#input-beginning-stock').val() + 
					"</td><td>"+ $('#input-alert-at').val() + 
					"</td><td style='display:none'>"+ $('#input-beginning-stock').val() + 
					"</td><td style='display:none'>"+ $('#input-outlet').val() + 
					"</td><td style='text-align:center;'><a class='btn-add-edit-variant btn btn-info btn-sm' href='#'>Edit</a>|<a class='btn-add-remove-variant btn btn-danger btn-sm' href='#'>X</a></td></tr>";
				
					if (valid== true){
						$("#tbody-add-variant-create-item").append(markup);
						
						 document.getElementById("form-variant").reset();
					$('#modal-add-variant').modal('hide');
					} else { 
						alert ('complete your form'); 
					}
					
 
				//console.log(inventory);
		});
		 
		 
		 /* edit variant row before save  */
		 $('#variant-table').on('click','.btn-add-edit-variant', function(){
			 $('#modal-create-item').modal('hide');
				var element=$(this).parent().parent().find("td");
				var varname=element.eq(0).text();
				var uprice=element.eq(1).text();
				var sku=element.eq(2).text();
				var bstock=element.eq(3).text();
				var alert=element.eq(4).text()
				var outlet=element.eq(6).text(); 
			 $('#modal-add-edit-variant').modal('show');
			 $(this).parent().parent().remove();
			$('#input-edit-variant-name').val(varname);
			$('#input-edit-variant-price').val(uprice);
			$('#input-edit-variant-sku').val(sku);
			$('#input-edit-beginning-stock').val(bstock);
			$('#input-edit-alert-at').val(alert);
			$('#input-edit-outlet').val(outlet);
			
		 });
		 
		 $(document).on('click','.btn-add-edit-update-variant', function(){
			 var form = $('#form-edit-variant');
				var valid = form.parsley().validate();
			 
			 $('#modal-add-edit-variant').modal('hide');
			 
				$('#modal-create-item').modal('show');
				var markup = "<tr class='row-add-variant'><td>" + $('#input-edit-variant-name').val() + 
				"</td><td style='text-align:center;'>" + $('#input-edit-variant-price').val() + 
				"</td><td style='text-align:center;'>" + $('#input-edit-variant-sku').val() + 
				"</td><td style='text-align:center;'>" + $('#input-edit-beginning-stock').val() + 
				"</td><td>"+ $('#input-edit-alert-at').val() +
				"</td><td style='text-align:center; display:none;'>" + $('#input-edit-beginning-stock').val() + 
				"</td><td style='display:none'>"+ $('#input-edit-outlet').val() + 
				"</td><td style='text-align:center;'><a class='btn-add-edit-variant btn btn-info btn-sm' href='#'>Edit</a>|<a class='btn-add-remove-variant btn btn-danger btn-sm' href='#'>X</a></td></tr>";
				
				
				if (valid== true){
					$("#tbody-add-variant-create-item").append(markup);
					$('#modal-create-item').modal('show');
				
				} else { 
					alert ('complete your form'); 
					$('#modal-add-edit-variant').modal('show');
					
				}
				
				
		 });
		 
		 $(document).on('click','#btn-add-edit-cancel-update', function(){
			 $('#modal-create-item').modal('show');
			 document.getElementById("form-edit-variant").reset();
		 });
	
		 /* remove row */ 
		 $(document).on('click','.btn-add-remove-variant', function(){
			//alert("delete");
			$(this).parent().parent().remove();
		 });
	 	 
		 
		/* save */
		 $(document).on('click','#btn-save', function(){		 	
			 var variants=[];
			 var inventory=[];
			 var outlet="";
			 var form = $('#target');
				var valid = form.parsley().validate();
			 $('#tbody-add-variant-create-item>.row-add-variant').each(function(index,data){
				 var inventory = {
						 beginning :$(data).find('td').eq(3).text(),
					     alertAtQty :$(data).find('td').eq(4).text(),
					     endingQty: $(data).find('td').eq(3).text(),
					     outlet:{
								id:$(data).find('td').eq(6).text()
							}
					     
				 }
				 var variant={
							name: $(data).find('td').eq(0).text(),
							price : $(data).find('td').eq(1).text(),
							sku: $(data).find('td').eq(2).text(),
							active:0,
							inventories:[inventory]
					}
				variants.push(variant);
				 outlet=$(data).find('td').eq(6).text();
			});
			
			//console.log(variants);
			 
			 var item = {
					//id:$('#input-item-id').val(),
					name: $('#input-item-name').val(),
					categoryId : {
						id:$('#input-item-category').val(),					
					},
					variants:variants,
					outlet:{
						id:parseInt(outlet)
					},
			 		active: 0
			};
			 
		
		 	
		 	if (valid== true){
		 		 $.ajax({
						type : 'POST',
						url : '${pageContext.request.contextPath}/mst/item-outlet/save',
						data : JSON.stringify(item),
						contentType : 'application/json',
						success : function(){
							window.location = '${pageContext.request.contextPath}/mst/item-outlet';
							
						}, error : function(){
							alert('save failed');
						} 		
					}); 
		 	} else {
		 		alert ('complete your form'); 
		 	}
		 	
	 	//var id=$(this).attr('id');
		 	/* var row=$('#tbody-add-variant-create-item').parent().parent().find(".row-add-variant");//select one row;
			var len=row.length; */
	
		});
		
		
		 
	/*=========================================EDIT ITEM===================================  */
	
	/* edit item */
	$(document).on('click','.btn-item-edit', function(evt){
	evt.preventDefault();
	var id = $(this).attr('id');
	//console.log(id);
	 $.ajax({
		url:'${pageContext.request.contextPath}/mst/item-outlet/getOne/'+id,
		type:'PUT',
		contentType:'application/json',
		success : function(result){
			 $('#modal-edit-item').modal('show');
			 $('#tbody-variant').empty();
			 var idInv=[];
				$.each(result, function(key, inventory){		
					idInv=inventory.id;
					var id=inventory.variant.item.id;
					var item=inventory.variant.item.name;
					var category=inventory.variant.item.categoryId.id;
					
					var markup = "<tr data-id-inv='"+inventory.id+"' class='row-edit-add-variant'><td>" + inventory.variant.name +
						"</td><td style='text-align:center;'>"+ inventory.variant.price + 
						"</td><td style='text-align:center;'>" + inventory.variant.sku + 
						"</td><td style='text-align:center;'>" + inventory.beginning + 
						"</td><td style='display:none'>" + inventory.alertAtQty+ 
						"</td><td style='display:none'>" + inventory.endingQty+ 
						"</td><td style='display:none'>" + inventory.variant.id+
						"</td><td style='display:none'>"+ inventory.outlet.id+
						"</td><td style='text-align:center;'><a class='btn-edit-edit-variant btn btn-info btn-sm' href='#'>Edit</a>|<a class='btn-edit-remove-variant btn btn-danger btn-sm' href='#'>X</a></td></tr>";
				
					$("#tbody-variant").append(markup);
					$(".btn-edit-delete-item").val(id);
					//console.log(id);
					$('#edit-item-id').val(id); 
					$('#edit-item-name').val(item); 
					$('#edit-item-category').val(category); 
				});
			 //console.log(inventory);
			}, error : function(){
				alert ('update failed'); 
			}
		});
	});
		
	/* edit add variant  */
	 
	 $(document).on('click', '#btn-edit-add-add-item-variant',function(){
			var markup = "<tr class='row-edit-add-variant' ><td>" + $('#input-edit-add-variant-name').val() + 
				"</td><td style='text-align:center;'>" + $('#input-edit-add-variant-price').val() + 
				"</td><td style='text-align:center;'>" + $('#input-edit-add-variant-sku').val() + 
				"</td><td style='text-align:center;'>" + $('#input-edit-add-beginning-stock').val() + 
				"</td><td style='display:none'>"+ $('#input-edit-add-alert-at').val() + 
				"</td><td style='display:none'>" + $('#input-edit-add-beginning-stock').val() + 
				"</td><td style='display:none'>"+" "+ 
				"</td><td style='display:none'>"+ $('#edit-add-outlet').val() + 
				"</td><td style='text-align:center;'><a class='btn-edit-edit-variant btn btn-info btn-sm' href='#'>Edit</a><a class='btn-edit-remove-variant btn btn-danger btn-sm' href='#'>X</a></center></td></tr>";
			$("#tbody-variant").append(markup);
			$('#modal-edit-add-variant').modal('hide');
			$('#modal-edit-item').modal('show');

			//console.log(variant);
			//console.log(inventory);
		});
		
		 /***** edit-edit variant model  *****/
		$('#btn-cancel-edit-edit').on('click', function(){
			$('#modal-edit-edit-variant').modal('hide');
			$('#modal-edit-item').modal('show');
		});
		
		 $('#edit-variant-table').on('click','.btn-edit-edit-variant', function(){
			 
				var element=$(this).parent().parent().find("td");
				var varname=element.eq(0).text();
				var uprice=element.eq(1).text();
				var sku=element.eq(2).text();
				var bstock=element.eq(3).text();
				var alert=element.eq(4).text(); 
				var outlet=element.eq(7).text(); 
			$('#modal-edit-item').modal('hide');
			$('#modal-edit-edit-variant').modal('show');
			$(this).parent().parent().remove();
			$('#edit-edit-variant-name').val(varname);
			$('#edit-edit-variant-price').val(uprice);
			$('#edit-edit-variant-sku').val(sku);
			$('#edit-edit-beginning-stock').val(bstock);
			$('#edit-edit-alert-at').val(alert);
			$('#edit-edit-outlet').val(outlet);
			
		 });
		 
		 $(document).on('click','#btn-edit-edit-update-variant', function(){
			 $('#modal-edit-edit-variant').modal('hide');
				$('#modal-edit-item').modal('show');
				var markup = "<tr class='row-edit-add-variant' ><td>" + $('#edit-edit-variant-name').val() + 
				"</td><td style='text-align:center;'>" + $('#edit-edit-variant-price').val() + 
				"</td><td style='text-align:center;'>" + $('#edit-edit-variant-sku').val() + 
				"</td><td style='text-align:center;'>" + $('#edit-edit-beginning-stock').val() + 
				"</td><td style='display:none'>"+ $('#edit-edit-alert-at').val() + 
				"</td><td style='display:none'>" + $('#edit-edit-beginning-stock').val() +
				"</td><td style='display:none'>" +
				"</td><td style='display:none'>"+ $('#edit-edit-outlet').val() + 
				"</td><td style='text-align:center;'><a class='btn-edit-edit-variant btn btn-info btn-sm' href='#'>Edit</a>|<a class='btn-add-remove-variant btn btn-danger btn-sm' href='#'>X</a></td></tr>";
				
				$("#tbody-variant").append(markup);
				$('#modal-edit-item').modal('show');
		 });
		
		
		/* edit remove variant*/
		$(document).on('click','.btn-edit-remove-variant', function(){
			//alert("delete");
			$(this).parent().parent().remove();
		 });
		
		$('#btn-cancel-add').on('click', function(){
			$('#modal-create-item').modal('show');
			 document.getElementById("form-variant").reset();
		});
		
		/* save edit */
		$('#btn-save-edit').on('click', function(){
			 	 var variants=[];
			 	 /* var inventories=[]; */
			 	 var i=0;
				 $('#tbody-variant>.row-edit-add-variant').each(function(index,data){
					 var inventory = {
							 id: $(this).parent().find('tr').eq(i++).attr('data-id-inv'),
							 beginning :$(data).find('td').eq(3).text(),
						     alertAtQty :$(data).find('td').eq(4).text(),
						     endingQty :$(data).find('td').eq(5).text(),
						     outlet:{
					    	 	id:$(data).find('td').eq(7).text()
					     	}
					 };
					 console.log($(data).find('td').eq(7).text());
					 //inventories.push(inventory);
					  var variant={
								name: $(data).find('td').eq(0).text(),
								price : $(data).find('td').eq(1).text(),
								sku: $(data).find('td').eq(2).text(),
								active:0,
								inventories:[inventory],
								id: parseInt($(data).find('td').eq(5).text())
						}
					variants.push(variant);
				});
				
				 var item = {
						id:parseInt($('#edit-item-id').val()),
						name: $('#edit-item-name').val(),
						categoryId : {
							id:parseInt($('#edit-item-category').val()),					
						},
						variants:variants,
				 		active: 0
				};
		 	
		 	console.log(item);
			 //console.log(category);
		 	    $.ajax({
				type : 'PUT',
				url : '${pageContext.request.contextPath}/mst/item-outlet/edit',
				data : JSON.stringify(item),
				contentType : 'application/json',
				success : function(item){
					alert("sukses edit");
					window.location = '${pageContext.request.contextPath}/mst/item-outlet';
				}, error : function(){
					alert('save failed');
				} 
			});
		});
		
		$('#btn-edit-add-variant').on('click', function(){
			$('#modal-edit-item').modal('hide');
			$('#modal-edit-add-variant').modal('show');
		});
		
		$('.btn-edit-delete-item').on('click', function(){
			idItem=$(".btn-edit-delete-item").val();
			var sumEndingQty=[];
			$.ajax({
				url:'${pageContext.request.contextPath}/mst/item-outlet/getOne/'+idItem,
				type:'PUT',
				contentType:'application/json',
				success : function(result){
					$.each(result,function(k,v){
						sumEndingQty.push(v.endingQty)
					});
					
					var gTotal=sumEndingQty.reduce(function(a,b){return a+b},0);
					if(gTotal==0){
						 $.ajax({
								type : 'PUT',
								url : '${pageContext.request.contextPath}/mst/item-outlet/update-status/'+idItem,
								contentType : 'application/json',
								success : function(item){
									alert("sukses delete");
									
								}, error : function(){
									alert('delete failed');
								} 
						 });
					};
					if(gTotal!=0){
						console.log("stock masih ada");
					};
				}
			});
			
		});
		
	});
	
	/////////////////////////////////function/////////////////////////////////

	
	
	function resetModalCreateItem() {
	    document.getElementById("target").reset();
	}
</script>