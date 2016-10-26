此工具类包含GET/POST网络请求/文件上传
GET使用方法:
[YXNetworkManager getRequestWithURL:url
params:params
success:successBlock
faildBlock:failureBlock;]
POST使用方法:
[YXNetworkManager postRequestWithURL:=url 
params:=params 
success:=successBlock 
faildBlock:=failureBlock]
文件请求使用方法:
1.不带进度条
[YXNetworkManager uploadFileWithURL:url
params:params
uploadParam:uploadParam
successBlock:successBlock
failureBlock:failureBlock]
2.带进度条
[YXNetworkManager uploadFileWithURL:url
params:params
uploadParam:uploadParam
progressBlock:progressBlock
successBlock:successBlock
failureBlock:failureBlock]
具体DEMO在项目中也有体现,欢迎下载使用

