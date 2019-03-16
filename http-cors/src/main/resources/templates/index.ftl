<!DOCTYPE html>
<html>
    <title>HTTP-CORS测试</title>
    <#include "./common/head.ftl">
  	
<body>

	<div id="app">
	
		<div class="page-header">
			<h3 class="text-center text-info"> GET示例 </h3>
		</div>
		<div class="panel panel-info">
			<div class="panel-footer form-inline">
				<label style="width:150px">
					请输入URL
				</label>
				<input type="text" class="form-control" v-model="get_request" placeholder="如默认：http://geojson.io">
				&nbsp; <input type="button" value="请求" class="btn btn-primary" @click="searchGet">
				&nbsp; <span class="text-muted">{{get_request}}</span>
			</div>
			<div class="panel-footer form-inline">
				<span class="label label-info">{{default_get_request}}</span>
				<span class="label label-info">{{default_get_response}}</span>
			</div>
		</div>
		<!--
		<div class="span12">
			<blockquote>
				<span class="label label-info">{{default_get_request}}</span>
				<span class="label label-info">{{default_get_response}}</span>
			</blockquote>
		</div>
		-->
		<div class="panel panel-info">
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th> URL请求 </th>
						<th> 响应结果 </th>
					</tr>
				</thead>
				<tbody>
					<tr class="success" v-if="flag">
						<td> {{default_get_request}} </td>
						<td> {{get_response}} </td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="page-table">
			<h3 class="text-center text-info"> POST-JSON示例 </h3>
		</div>
		<div class="panel panel-info">
			<div class="panel-footer form-inline">
				<label style="width:150px">
					请输入URL
				</label>
				<input type="text" class="form-control" v-model="post_request" placeholder="如默认：http://geojson.io">
				&nbsp; <input type="button" value="请求" class="btn btn-primary" @click="searchPost">
			</div>
			<div class="panel-footer form-inline">
				<label style="width:150px">
					JSON参数
				</label>
				<input type="text" style="width:600px" class="form-control" v-model="post_param" placeholder='如：{"paramName":"paramValue"}' >
			</div>
		</div>
		<div class="panel panel-info">
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th> URL请求 </th>
						<th> 响应结果 </th>
					</tr>
				</thead>
				<tbody>
					<tr class="success" v-if="post_flag">
						<td> {{default_post_request}} </td>
						<td> {{post_response}} </td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="page-table">
			<h3 class="text-center text-info"> POST-FILE示例 </h3>
		</div>
		<div class="panel panel-info">
			<div class="panel-footer form-inline">
				<label style="width:150px">
					请输入URL
				</label>
				<input type="text" class="form-control" v-model="postfile_request" placeholder="如默认：http://geojson.io">
			</div>
			<div class="panel-footer form-inline">
				<label style="width:150px">
					FILE上传
				</label>
				KEY <input type="text" style="width:100px" class="form-control" v-model="postfile_param_key" placeholder='如默认：file' >&nbsp;&nbsp;
				<button type="button" v-on:click="importData($event)" class="btn btn-info" >上传文件并请求</button>
				<form>
					<input type="file" id="uploadEventFile" v-on:change="fileChange($event)" style="display:none"/>
				</form>
			</div>
		</div>
		<div class="panel panel-info">
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th> URL请求 </th>
						<th> 响应结果 </th>
					</tr>
				</thead>
				<tbody>
					<tr class="success" v-if="postfile_flag">
						<td> {{default_postfile_request}} </td>
						<td> {{postfile_response}} </td>
					</tr>
				</tbody>
			</table>
		</div>
		
	</div>

</body>
</html>

<script type="text/javascript">
	var vm = new Vue({
		el: '#app',
		data: {
			/* GET */
			flag: false,
			default_get_request: 'http://geojson.io',
			default_get_response: '',
			get_request: '',
			get_response: '',
			
			/* POST-JSON */
			post_flag: false,
			post_request: '',
			post_param: '',
			default_post_request: '',
			post_response: '',
			
			/* POST-FILE */
			postfile_flag: false,
			postfile_request: '',
			default_postfile_request: '',
			postfile_param_key: '',
			postfile_response: ''
		},
		methods: {
			searchGet(){
				this.default_get_response = "请求中，请稍候...";
				/* var requestUrl = "${protocolIp}" + "/demo?param1=" + (this.param1!="" ? this.param1 : this.default_param1); */
				this.default_get_request = this.get_request !=""? this.get_request : this.default_get_request;
				var requestUrl = this.default_get_request;
				this.get_request = '';
				var _this = this;
				/* jquery方式 */
				$.ajax({
					type: "GET",
					url: requestUrl,
					success : function (obj) {
						_this.flag = true;
						_this.get_response = obj;
						_this.default_get_response = "请求成功";
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						_this.flag = false;
						_this.default_get_response = "服务异常，未查询到结果";
						console.log(JSON.stringify(errorThrown)+JSON.stringify(textStatus)+JSON.stringify(XMLHttpRequest));
					}
				});
			},
			searchPost(){
				var postDatas = this.post_param;
				var config = {
					headers : {
						'Content-Type' : 'application/json'
					}
				}
				var requestUrl = this.post_request !=""? this.post_request : this.default_get_request;
				var _this = this;
				this.post_request = '',
				/* axios方式 */
				axios.post(requestUrl, postDatas, config).then(
					function(response) {
						_this.post_flag = true;
						_this.default_post_request = requestUrl;
						_this.post_response = response;
					}).catch(
			            function(error) {
			            	_this.post_flag = false;
			            	alert("请求失败，需检查JSON参数是否遗漏或格式错误->JSON=" + postDatas);
			            	console.error(error.stack);
			        });
			},
			//上传事件
			importData : function(event) {
				event.preventDefault();
				$("#uploadEventFile").trigger("click")
			},
			//上传文件
			fileChange : function(el) {
				//取消默认行为
				el.preventDefault();
				var uploadEventFile = $("#uploadEventFile").val()
				this.file = el.target.files[0]
				if (uploadEventFile == '') {
					alert("请先选择文件，再上传");
				} else {
					var formData = new FormData();
					var fileKey = this.postfile_param_key !="" ? this.postfile_param_key : 'file';
					formData.append(fileKey, this.file);
					var config = {
						headers : {
							'Content-Type' : 'multipart/form-data'
						}
					}
					var requestUrl =  this.postfile_request !=""? this.postfile_request : this.default_get_request;
					/* axios方式 */
					console.log("url=" + requestUrl + "; fileKey=" + fileKey);
					var _this = this;
					axios.post(requestUrl, formData, config).then(
						function(response) {
							alert('上传成功');
							_this.postfile_flag = true;
							_this.default_postfile_request = requestUrl;
							_this.postfile_response = response;
							
						}).catch(
				            function(error) {
				            	alert("请求出错了; 请检查URL是否正确->URL=" + requestUrl);
				            	console.error(error.stack);
				            	 _this.postfile_flag = false;
				        });
				}
			},
			
		}
	});
	
</script>
