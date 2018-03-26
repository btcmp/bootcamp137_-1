<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/resources/js/jquery-3.3.1.min.js" var="jq"></spring:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Entry Employee</title>
<link rel="stylesheet" href="resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="resources/css/bootstrap.css" />
<link rel="stylesheet" href="resources/css/dataTables.bootstrap4.min.css" />
<script type="text/javascript" src="${jq }"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/parsley.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/parsley.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/jquery.dataTables.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/resources/js/dataTables.bootstrap4.min.js"/>"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>


<style type="text/css">
	input.parsley-error
		{
		  color: #B94A48 !important;
		  background-color: #F2DEDE !important;
		  border: 1px solid #EED3D7 !important;
		}
		th{
			text-align: center;
		}
</style>

<script type="text/javascript">
	jQuery(document).ready(function(){
		/* create new item */
		$('#btn-create').on('click', function(){
			$('#modal-create-item').modal('show');
		});
		
		 $(document).on('click','#btn-save', function(){		 	
			 var variants=[];
			 var inventory=[];
			 $('#tbody-add-variant-create-item>.row-add-variant').each(function(index,data){
				 var inventory = {
						 beginning :$(data).find('td').eq(3).text(),
					     alertAtQty :$(data).find('td').eq(4).text()
				 }
				 var variant={
							name: $(data).find('td').eq(0).text(),
							price : $(data).find('td').eq(1).text(),
							sku: $(data).find('td').eq(2).text(),
							active:0,
							inventories:[inventory]
					}
				variants.push(variant);
			});
			
			//console.log(variants);
			 
			 var item = {
					//id:$('#input-item-id').val(),
					name: $('#input-item-name').val(),
					categoryId : {
						id:$('#input-item-category').val(),					
					},
					variants:variants,
			 		active: 0
			};
		 	
		 	console.log(item);
		 	
		 	 $.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/item/save',
				data : JSON.stringify(item),
				contentType : 'application/json',
				success : function(){
					window.location = '${pageContext.request.contextPath}/item';
				}, error : function(){
					alert('save failed');
				} 		
			}); 
	 	//var id=$(this).attr('id');
		 	/* var row=$('#tbody-add-variant-create-item').parent().parent().find(".row-add-variant");//select one row;
			var len=row.length; */
	
		});
		 
		 /* btn show form add variant */
		 $('#btn-add-variant').on('click', function(){
			 $('#modal-add-variant').modal('show');
			
		});
		 
		 /* create add variant */
		 $('#btn-add-item-variant').on('click', function(){
			 
			 	var name= $('#input-variant-name').val();
				var sku= $('#input-variant-sku').val();
				var price= $('#input-variant-price').val();
				var beginning= $('#input-beginning-stock').val();
				var alert= $('#input-alert-at').val();
			 		
				var markup = "<tr class='row-add-variant'><td>" + name + "</td><td><center>" + price + "</td><td>" + sku + "</td><td>" + beginning + "</td><td style='display:none'>" + alert + "</td><td><a id='btn-edit' class='btn btn-info btn-sm' href='#'>Edit</a></center></td></tr>";
				$("#tbody-add-variant-create-item").append(markup);
				
				$('#modal-add-variant').modal('hide');

				//console.log(inventory);
		});
		
	
		/* edit item */
		$('.btn-item-edit').on('click', function(evt){
			evt.preventDefault();
					
			var id = $(this).attr('id');
			
			//console.log(id);
			$.ajax({
				url:'${pageContext.request.contextPath}/item/get-one/'+id,
				type:'PUT',
				contentType:'application/json',
				success : function(item){
					$('#modal-edit-item').modal('show');
					 $('#edit-item-id').val(item.id);
					 $('#edit-item-name').val(item.name);
					 $('edit-variant-category').val(item.categoryId);
				}, error : function(){
					alert ('update failed'); 
				}
			});
			
		});
		
		/* save edit */
		$('#btn-save-edit').on('click', function(){
			 //var category=  parseInt($('#input-item-category').val());
		 	 var variants=[];
			 $('#tbody-variant>.row-edit-add-variant').each(function(index,data){
				 var variant={
							name: $(data).find('td').eq(0).text(),
							price : $(data).find('td').eq(1).text(),
							sku: $(data).find('td').eq(2).text(),
							active:0
					};  
				variants.push(variant);
			});
			
			//console.log(variants);
		
			 var item = {
		 		id:$('#edit-item-id').val(),
				name: $('#edit-item-name').val(),
				categoryId : {
					id:$('#edit-item-category').val()
							
				},
				variants:variants,
		 		active: 0
			};
		 	console.log(item);
			//console.log(category);
		 	 $.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/item/update',
				data : JSON.stringify(item),
				contentType : 'application/json',
				success : function(){
					window.location = '${pageContext.request.contextPath}/item';
				}, error : function(){
					alert('save failed');
				} 
			});  
		});
		
		$('#btn-edit-add-variant').on('click', function(){
			$('#modal-edit-item').modal('hide');
			$('#modal-edit-add-variant').modal('show');
		});
		
		/* edit add variant  */
		 
		 $('#btn-add-edit-item-variant').on('click', function(){
			 	var name= $('#input-edit-variant-name').val();
				var sku= $('#input-edit-variant-sku').val();
				var price= $('#input-edit-variant-price').val();
				var beginning= $('#input-edit-beginning-stock').val();
			 
				var variant={
					name: name,
					sku: sku,
					price:price
				};	
				
				var inventory={
						beginning: $('#input-edit-beginning-stock').val()
						
					};
				
				var markup = "<tr class='row-edit-add-variant'><td>" + name + "</td><td><center>" + price + "</td><td>" + sku + "</td><td>" + beginning + "</td><td><a class='btn-edit-edit-variant tbtn btn-info btn-sm' href='#'>Edit</a></center></td></tr>";
				$("#tbody-variant").append(markup);
				
				$('#modal-edit-item').modal('show');
	
				console.log(variant);
				//console.log(inventory);
			});
		
		/* btn edit varian dari modal edit item */
		 $(document).on('click','.btn-edit-edit-variant', function(){
				//var id=$(this).attr('id');
				var element=$(this).parent().parent().find("td");
				var varname=element.eq(0);
				var uprice=element.eq(1);
				var sku=element.eq(2);
				var bstock=element.eq(3);
				
				var variant={
						name: varname.text(),
						sku: sku.text(),
						price : uprice.text(),
						
						active:0
				};
				console.log(variant);
				
			});
		
		$('#btn-cancel-add').on('click', function(){
			$('#modal-edit-item').modal('show');
		});
		
		
	});
</script>
</head>
<body>
<div class="container">
	<div>
		<b>Items</b>
	</div>
	<div id="save-form" style="margin-top:20px; margin-bottom:20px;">
		<form action="#">
			<input type="text" id="search" placeholder="Search" />
			<button type="button" id="btn-create" class="btn btn-primary" style="float:right; margin-right: 0px; width:150px;">Create</button>
			<button type="button" id="btn-export" class="btn btn-primary" style="float:right; margin-right: 50px; width: 150px;">Export</button>
			
		</form>
	</div>
	
	<table id="emp-table" class="table table-sm table-striped table-bordered" cellspacing="0" width="100%">
		<thead class="thead-dark">
			<th>Name</th>
			<th>Category</th>
			<th>Unit Price</th>
			<th>In Stock</th>
			<th>Stock Alert</th>
			<th>#</th>
		</thead>
		<tbody>
			<c:forEach items="${inventories}" var="inv">
				<tr>
				<td>${inv.variant.item.name}</td>
				<td><center>${inv.variant.item.categoryId.name }</center></td>
				<td><center>${inv.variant.price}</center></td>
				<td><center>${inv.beginning }</center></td>
				<td><center>${inv.variant.sku }</center></td>
				<td><center>
					<a id="${inv.variant.item.id}" class="btn-item-edit btn btn-info btn-sm" href="#">Edit</a></center>
				</td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
</div>

<!-- call modal -->
	<%@ include file="modal/item/create-edit-item.jsp" %>

</body>
</html>