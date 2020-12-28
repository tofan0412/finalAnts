<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js">
</script>
<%@include file="/WEB-INF/views/layout/commonLib.jsp"%>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
<!-- main_header -->
<%@include file="/WEB-INF/views/layout/header.jsp"%>
<!-- left Sidebar Container -->
<%@include file="/WEB-INF/views/layout/left.jsp"%>
<!-- Main content -->
	<div class="wrapper">
	<section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>500 Error Page</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item san jg"><a href="${pageContext.request.contextPath}/member/mainpage">Home</a></li>
              <li class="breadcrumb-item active jg">500 Error Page</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
     <div class="content-wrapper" style="background: white;">
    <section class="content">
    <div style="padding-top: 5%;">
        <div style="float: left; width: 35%;">
        <img src="/dist/img/logo.png"  style="float: right; width: 300px; margin-right: 10%; height: 250px;">
        </div>
        <div style="float: left; width: 55%; ">
          <h3 class="jg"><i class="fas fa-exclamation-triangle text-warning"></i> 죄송합니다.<br>요청하신 페이지를 찾을 수 없습니다.</h3><br>
          <p class="jg" style="line-height: 2.5em;">
                     방문하시려는 페이지의 주소가 잘못 입력되었거나,<br>페이지의 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.<br>입력하신 주소가 정확한지 다시 한번 확인해 주시기 바랍니다.<br>
                     관련 문의사항은 고객센터에 알려주시면 친절하게 안내해 드리겠습니다.<br>감사합니다. 
          </p>
        </div>
      </div>
    </section>
		</div>
	</div>
    <!-- /.content -->
<!-- Control Sidebar -->
<%@include file="/WEB-INF/views/layout/right.jsp"%>
<!-- Main Footer -->
<%@include file="/WEB-INF/views/layout/footer.jsp"%>
	</div>
	
  </body>
</html>
 
