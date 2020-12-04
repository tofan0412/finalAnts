<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){	
	 	$('#summernote').summernote();
	 	});
	
</script>	 		
</head>
			<%@include file="../layout/contentmenu.jsp"%>
			<div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title"><c:out value="${projectVo.proName}"/></h3>
              </div>
              <div class="card-body">
                <div class="form-group">
                  <input class="form-control" placeholder="Subject:" name="hissueTitle">
                  <input type="hidden" name="writer" value="${SMEMBER.memId }">
                </div>
                <div class="form-group">
                <textarea id="summernote" name="hissuetCont"></textarea>
                </div>
                <div class="form-group">
                  <div class="btn btn-default btn-file">
                    <input type="file">
                  </div>
                </div>
              </div>
              <div class="card-footer">
                <div class="float-right">
                  <button type="button" class="btn btn-default" id="back"><i class="fas fa-times"></i> 취소</button>
                  <button type="button" class="btn btn-primary" id=""><i class="far fa-pencil-alt"></i> 작성</button>
                </div>
              </div>
            </div>


</html>