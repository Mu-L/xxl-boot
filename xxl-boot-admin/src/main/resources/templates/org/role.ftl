<!DOCTYPE html>
<html>
<head>
	<#-- import macro -->
	<#import "../common/common.macro.ftl" as netCommon>

	<!-- 1-style start -->
	<@netCommon.commonStyle />
	<link rel="stylesheet" href="${request.contextPath}/static/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" href="${request.contextPath}/static/plugins/zTree/css/metroStyle/metroStyle.css">
	<!-- 1-style end -->

</head>
<body class="hold-transition" style="background-color: #ecf0f5;">
<div class="wrapper">
	<section class="content">

		<#-- 2-biz start -->

		<#-- 查询区域 -->
		<div class="box" style="margin-bottom:9px;">
			<div class="box-body">
				<div class="row" id="data_filter" >
					<div class="col-xs-3">
						<div class="input-group">
							<span class="input-group-addon">${I18n.role_tips}${I18n.role_name}</span>
							<input type="text" class="form-control name" autocomplete="on" >
						</div>
					</div>
					<div class="col-xs-1">
						<button class="btn btn-block btn-primary searchBtn" >${I18n.system_search}</button>
					</div>
				</div>
			</div>
		</div>

		<#-- 数据表格区域 -->
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header pull-left" id="data_operation" >
						<button class="btn btn-sm btn-info add" type="button"><i class="fa fa-plus" ></i>${I18n.system_opt_add}</button>
						<button class="btn btn-sm btn-warning selectOnlyOne update" type="button"><i class="fa fa-edit"></i>${I18n.system_opt_edit}</button>
						<button class="btn btn-sm btn-danger selectAny delete" type="button"><i class="fa fa-remove "></i>${I18n.system_opt_del}</button>
						<button class="btn btn-sm btn-primary selectOnlyOne allocateResource" type="button">分配资源</button>
					</div>
					<div class="box-body" >
						<table id="data_list" class="table table-bordered table-striped" width="100%" >
							<thead></thead>
							<tbody></tbody>
							<tfoot></tfoot>
						</table>
					</div>
				</div>
			</div>
		</div>

		<!-- 分配资源.模态框 -->
		<div class="modal fade" id="roleResourceModal" tabindex="-1" role="dialog"  aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" >分配资源</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal form" role="form" >
							<div class="form-group">
								<div class="col-sm-12">
									<#-- demo tree -->
									<ul id="tree" class="ztree" style="width:260px; "></ul>
								</div>
							</div>

							<div class="form-group" style="text-align:center;border-top: 1px solid #e4e4e4;">
								<div style="margin-top: 10px;" >
									<button type="button" class="btn btn-primary save"  >${I18n.system_save}</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">${I18n.system_cancel}</button>
								</div>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- 新增.模态框 -->
		<div class="modal fade" id="addModal" tabindex="-1" role="dialog"  aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" >${I18n.system_opt_add}${I18n.user_tips}</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal form" role="form" >
							<div class="form-group">
								<label for="lastname" class="col-sm-2 control-label">${I18n.role_tips}${I18n.role_name}<font color="red">*</font></label>
								<div class="col-sm-8"><input type="text" class="form-control" name="name" placeholder="${I18n.system_please_input}${I18n.role_name}" maxlength="10" ></div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-sm-2 control-label">${I18n.role_tips}${I18n.role_order}<font color="red">*</font></label>
								<div class="col-sm-8"><input type="text" class="form-control" name="order" placeholder="${I18n.system_please_input}${I18n.role_name}" maxlength="10" ></div>
							</div>

							<div class="form-group" style="text-align:center;border-top: 1px solid #e4e4e4;">
								<div style="margin-top: 10px;" >
									<button type="submit" class="btn btn-primary"  >${I18n.system_save}</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">${I18n.system_cancel}</button>
								</div>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- 更新.模态框 -->
		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"  aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" >${I18n.system_opt_edit}${I18n.user_tips}</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal form" role="form" >
							<div class="form-group">
								<label for="lastname" class="col-sm-2 control-label">${I18n.role_tips}${I18n.role_name}<font color="red">*</font></label>
								<div class="col-sm-8"><input type="text" class="form-control" name="name" placeholder="${I18n.system_please_input}${I18n.role_name}" maxlength="10" ></div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-sm-2 control-label">${I18n.role_tips}${I18n.role_order}<font color="red">*</font></label>
								<div class="col-sm-8"><input type="text" class="form-control" name="order" placeholder="${I18n.system_please_input}${I18n.role_name}" maxlength="10" ></div>
							</div>

							<div class="form-group" style="text-align:center;border-top: 1px solid #e4e4e4;">
								<div style="margin-top: 10px;" >
									<button type="submit" class="btn btn-primary"  >${I18n.system_save}</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">${I18n.system_cancel}</button>
									<input type="hidden" name="id" >
								</div>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>

		<#-- 2-biz end -->

	</section>
</div>

<!-- 3-script start -->
<@netCommon.commonScript />
<script src="${request.contextPath}/static/plugins/bootstrap-table/bootstrap-table.min.js"></script>
<script src="${request.contextPath}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="${request.contextPath}/static/plugins/zTree/js/jquery.ztree.core.js"></script>
<script src="${request.contextPath}/static/plugins/zTree/js/jquery.ztree.excheck.js"></script>
<script>
$(function() {

	// ---------- ---------- ---------- main table  ---------- ---------- ----------

	var mainDataTable = $("#data_list").bootstrapTable({
		url: base_url + "/org/role/pageList",
		method: "post",
		contentType: "application/x-www-form-urlencoded",
		queryParamsType: "limit",
		queryParams: function (params) {
			var obj = {};
			obj.name = $('#data_filter .name').val();
			obj.start = params.offset;
			obj.length = params.limit;
			return obj;
		},
		sidePagination: "server",		// server side page
		responseHandler: function (result) {
			return {
				"total": result.data.totalCount,
				"rows": result.data.pageData
			};
		},
		columns: [
			{
				checkbox: true,
				field: 'state',
				width: '5%',
				align: 'center',
				valign: 'middle'
			}, {
				title: I18n.role_tips + I18n.role_name,
				field: 'name',
				width: '40%',
				align: 'left'
			},{
				title: I18n.role_tips + I18n.role_order,
				field: 'order',
				width: '30%',
				align: 'left'
			}
		],
		uniqueId: "id", 				// 每一行的唯一标识，一般为主键列
		clickToSelect: true, 			// 是否启用点击选中行
		sortable: false, 				// 是否启用排序
		align: "left",					// 列的标题对齐方式
		pagination: true, 				// 是否显示分页
		pageNumber: 1, 					// 默认第一页
		pageList: [10, 25, 50, 100] , 	// 可供选择的每页的行数（*）
		smartDisplay: false,			// 当总记录数小于分页数，是否显示可选项
		paginationPreText: '<<',		// 跳转页面的 上一页按钮
		paginationNextText: '>>',		// 跳转页面的 下一页按钮
		showRefresh: true,				// 显示刷新按钮
		showColumns: true,				// 显示/隐藏列
		minimumCountColumns: 2,			// 最少允许的列数
		onAll: function(name, args) {
			// filter
			if (!(['check.bs.table', "uncheck.bs.table", "check-all.bs.table", "uncheck-all.bs.table"].indexOf(name) > -1)) {
				return false;
			}
			var rows = mainDataTable.bootstrapTable('getSelections');
			var selectLen = rows.length;

			if (selectLen > 0) {
				$("#data_operation .selectAny").removeClass('disabled');
			} else {
				$("#data_operation .selectAny").addClass('disabled');
			}
			if (selectLen === 1) {
				$("#data_operation .selectOnlyOne").removeClass('disabled');
			} else {
				$("#data_operation .selectOnlyOne").addClass('disabled');
			}
		}
	});
	document.querySelector('.fixed-table-toolbar').classList.remove('fixed-table-toolbar');

	// search btn
	$('#data_filter .searchBtn').on('click', function(){
		mainDataTable.bootstrapTable('refresh');
	});

	// ---------- ---------- ---------- delete operation ---------- ---------- ----------
	// delete
	$("#data_operation").on('click', '.delete',function() {
		// get select rows
		var rows = mainDataTable.bootstrapTable('getSelections');

		// find select ids
		const selectIds = (rows && rows.length > 0) ? rows.map(row => row.id) : [];
		if (selectIds.length <= 0) {
			layer.msg(I18n.system_please_choose + I18n.system_data);
			return;
		}

		// do delete
		layer.confirm( I18n.system_ok + I18n.system_opt_del + '?', {
			icon: 3,
			title: I18n.system_tips ,
			btn: [ I18n.system_ok, I18n.system_cancel ]
		}, function(index){
			layer.close(index);

			$.ajax({
				type : 'POST',
				url : base_url + "/org/role/delete",
				data : {
					"ids" : selectIds
				},
				dataType : "json",
				success : function(data){
					if (data.code == 200) {
						layer.msg( I18n.system_opt_del + I18n.system_success );
						// refresh table
						$('#data_filter .searchBtn').click();
					} else {
						layer.msg( data.msg || I18n.system_opt_del + I18n.system_fail );
					}
				},
				error: function(xhr, status, error) {
					// Handle error
					console.log("Error: " + error);
					layer.open({
						icon: '2',
						content: (I18n.system_opt_del + I18n.system_fail)
					});
				}
			});
		});
	});

	// ---------- ---------- ---------- add operation ---------- ---------- ----------
	// add
	$("#data_operation .add").click(function(){
		$('#addModal').modal({backdrop: false, keyboard: false}).modal('show');
	});
	var addModalValidate = $("#addModal .form").validate({
		errorElement : 'span',
		errorClass : 'help-block',
		focusInvalid : true,
		rules : {
			name : {
				required : true,
				rangelength:[2, 20]
			},
			order : {
				required : true,
				digits : true
			}
		},
		messages : {
			name : {
				required : I18n.system_please_input + I18n.role_name,
				rangelength: I18n.system_lengh_limit + "[2-10]"
			},
			order : {
				required : I18n.system_please_input + I18n.role_order,
				digits: I18n.role_order_valid
			}
		},
		highlight : function(element) {
			$(element).closest('.form-group').addClass('has-error');
		},
		success : function(label) {
			label.closest('.form-group').removeClass('has-error');
			label.remove();
		},
		errorPlacement : function(error, element) {
			element.parent('div').append(error);
		},
		submitHandler : function(form) {

			// request
			var paramData = {
				"name": $("#addModal .form input[name=name]").val(),
				"order": $("#addModal .form input[name=order]").val()
			};

			// invoke
			$.ajax({
				type : 'POST',
				url : base_url + "/org/role/insert",
				data : paramData,
				dataType : "json",
				success : function(data){
					if (data.code == "200") {
						$('#addModal').modal('hide');
						layer.msg( I18n.system_opt_add + I18n.system_success );

						// refresh table
						$('#data_filter .searchBtn').click();
					} else {
						layer.open({
							title: I18n.system_tips ,
							btn: [ I18n.system_ok ],
							content: (data.msg || I18n.system_opt_add + I18n.system_fail ),
							icon: '2'
						});
					}
				},
				error: function(xhr, status, error) {
					// Handle error
					console.log("Error: " + error);
					layer.open({
						icon: '2',
						content: (I18n.system_opt_add + I18n.system_fail)
					});
				}
			});

		}
	});
	$("#addModal").on('hide.bs.modal', function () {
		// reset
		$("#addModal .form")[0].reset();
		$("#addModal .form .form-group").removeClass("has-error");
		// reset
		addModalValidate.resetForm();
	});

	// ---------- ---------- ---------- update operation ---------- ---------- ----------
	$("#data_operation .update").click(function(){
		// get select rows
		var rows = mainDataTable.bootstrapTable('getSelections');

		// find select row
		if (rows.length !== 1) {
			layer.msg(I18n.system_please_choose + I18n.system_one + I18n.system_data);
			return;
		}
		var row = rows[0];

		// base data
		$("#updateModal .form input[name='id']").val( row.id );
		$("#updateModal .form input[name='name']").val( row.name );
		$("#updateModal .form input[name='order']").val( row.order );

		// show
		$('#updateModal').modal({backdrop: false, keyboard: false}).modal('show');
	});
	var updateModalValidate = $("#updateModal .form").validate({
		errorElement : 'span',
		errorClass : 'help-block',
		focusInvalid : true,
		highlight : function(element) {
			$(element).closest('.form-group').addClass('has-error');
		},
		success : function(label) {
			label.closest('.form-group').removeClass('has-error');
			label.remove();
		},
		errorPlacement : function(error, element) {
			element.parent('div').append(error);
		},
		rules : {
			name : {
				required : true,
				rangelength:[2, 20]
			},
			order : {
				required : true,
				digits : true
			}
		},
		messages : {
			name : {
				required : I18n.system_please_input + I18n.role_name,
				rangelength: I18n.system_lengh_limit + "[2-10]"
			},
			order : {
				required : I18n.system_please_input + I18n.role_order,
				digits: I18n.role_order_valid
			}
		},
		submitHandler : function(form) {

			// request
			var paramData = {
				"id": $("#updateModal .form input[name=id]").val(),
				"name": $("#updateModal .form input[name=name]").val(),
				"order": $("#updateModal .form input[name=order]").val()
			};

			// invoke
			$.ajax({
				type : 'POST',
				url : base_url + "/org/role/update",
				data : paramData,
				dataType : "json",
				success : function(data){
					if (data.code == "200") {
						$('#updateModal').modal('hide');
						layer.msg( I18n.system_opt_edit + I18n.system_success );

						// refresh table
						$('#data_filter .searchBtn').click();
					} else {
						layer.open({
							title: I18n.system_tips ,
							btn: [ I18n.system_ok ],
							content: (data.msg || I18n.system_opt_edit + I18n.system_fail ),
							icon: '2'
						});
					}
				},
				error: function(xhr, status, error) {
					// Handle error
					console.log("Error: " + error);
					layer.open({
						icon: '2',
						content: (I18n.system_opt_edit + I18n.system_fail)
					});
				}
			});

		}
	});
	$("#updateModal").on('hide.bs.modal', function () {
		updateModalValidate.resetForm();

		$("#updateModal .form")[0].reset();
		$("#updateModal .form .form-group").removeClass("has-error");
	});

	// ---------- ---------- ---------- allocate resource ---------- ---------- ----------
	$("#data_operation .allocateResource").click(function(){
		// get select rows
		var rows = mainDataTable.bootstrapTable('getSelections');

		// find select row
		if (rows.length !== 1) {
			layer.msg(I18n.system_please_choose + I18n.system_one + I18n.system_data);
			return;
		}
		var row = rows[0];
		var roleId = row.id;

		// base data
		initTree();

		// 设置 tree 选中
		currentRoleId = roleId;
		$.ajax({
			type : 'POST',
			url : base_url + "/org/role/loadRoleRes",
			data: {
				"roleId":roleId
			},
			dataType : "json",
			async: false,
			success : function(data){
				if (data.code == "200") {
					var checkedIds = data.data;
					if (checkedIds && checkedIds.length >0) {
						checkedIds.forEach(function(nodeId) {
							var nodes = zTreeObj.getNodesByParam("id", nodeId, null);
							if (nodes && nodes.length > 0) {
								var node = nodes[0];
								zTreeObj.checkNode(node, true, false);	// checkTypeFlag: 是否父子节点联动
							}
						});
						//console.log("checked: "+ zTreeObj.getCheckedNodes(true).map(item => item.id));
					}
				} else {
					layer.msg( data.msg || '系统异常' );
				}
			}
		});

		// show
		$('#roleResourceModal').modal({backdrop: false, keyboard: false}).modal('show');
	});

	// ———————————— save
	$("#roleResourceModal .save").click(function(){
		var checkedIds = zTreeObj.getCheckedNodes(true).map(item => item.id);

		$.ajax({
			type : 'POST',
			url : base_url + "/org/role/updateRoleRes",
			data : {
				"roleId":currentRoleId,
				"resourceIds":checkedIds
			},
			dataType : "json",
			success : function(data){
				if (data.code == "200") {
					$('#updateModal').modal('hide');
					layer.msg( '操作成功' );

					// refresh table
					$('#data_filter .searchBtn').click();
				} else {
					layer.open({
						title: I18n.system_tips ,
						btn: [ I18n.system_ok ],
						content: (data.msg || '操作失败' ),
						icon: '2'
					});
				}

				// hide
				$('#roleResourceModal').modal('hide');
			}
		});

	});

	// ———————————— ztree
	var zTreeObj;
	var currentRoleId;
	function initTree(){
		var setting = {
			check: {
				enable: true,
				chkboxType : {
					"Y" : "ps",	// ps
					"N" : "ps"	// ps
				}
			},
			data: {
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "parentId",
					rootPId: "0"
				}
			}
		};

		// post
		$.ajax({
			type : 'POST',
			url : base_url + "/org/resource/simpleTreeList",
			dataType : "json",
			async: false,
			success : function(data){
				if (data.code == "200") {
					var zNodes = data.data;

					zTreeObj = $.fn.zTree.init($("#tree"), setting, zNodes); //初始化树
					zTreeObj.expandAll(true);    //true 节点全部展开、false节点收缩

				} else {
					layer.msg( data.msg || '系统异常' );
				}
			}
		});
	}


});

</script>
<!-- 3-script end -->

</body>
</html>