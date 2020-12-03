<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

</head>
<title>협업관리프로젝트</title>
	<form:form commandName="reqVo" id="DetailForm" name="DetailForm" method="post">

		    <!-- Content Header (Page header) -->
		    <section class="content-header" style="
											border-bottom: 1px solid #dee2e6;
											background: white;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1 class="jg">요구사항 정의서</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">요구사항 정의서</li>
		            </ol>
		          </div>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		

    		<!-- Main content -->
		    <section class="content">
		      <!-- Default box -->
		      <div class="card">
		        <div class="card-header">
		          <a class="jg" href="/todo/projectgetReq?reqId=${reqVo.reqId }" style="color: #0BB783;">프로젝트 공간으로 가시겠습니까?</a>
		
		          <div class="card-tools">
		            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
		              <i class="fas fa-minus"></i>
		            </button>
		            <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
		              <i class="fas fa-times"></i>
		            </button>
		          </div>
		        </div>
		        <div class="card-body">
		          <div class="row">
		            <div class="col-12 col-md-12 col-lg-8 order-2 order-md-1">
		              <div class="row">
		                <div class="col-12 col-sm-4">
		                  <div class="info-box bg-light">
		                    <div class="info-box-content">
		                      <span class="info-box-text text-center text-muted">예상 기간</span>
		                      <span class="info-box-number text-center text-muted mb-0">${reqVo.reqPeriod }일</span>
		                    </div>
		                  </div>
		                </div>
		                <div class="col-12 col-sm-4">
		                  <div class="info-box bg-light">
		                    <div class="info-box-content">
		                      <span class="info-box-text text-center text-muted">Project Leader </span>
		                      <span class="info-box-number text-center text-muted mb-0">${reqVo.plId }</span>
		                    </div>
		                  </div>
		                </div>
		                <div class="col-12 col-sm-4">
		                  <div class="info-box bg-light">
		                    <div class="info-box-content">
		                      <span class="info-box-text text-center text-muted">응답 상태</span>
		                      <span class="info-box-number text-center text-muted mb-0">${reqVo.status }</span>
		                    </div>
		                  </div>
		                </div>
		              </div>
		              <div class="row">
		                <div class="col-12">
		                  <h4>Recent Activity</h4>
		                    <div class="post">
		                      <div class="user-block">
		                        <img class="img-circle img-bordered-sm" src="../../dist/img/user1-128x128.jpg" alt="user image">
		                        <span class="username">
		                          <a href="#">Jonathan Burke Jr.</a>
		                        </span>
		                        <span class="description">Shared publicly - 7:45 PM today</span>
		                      </div>
		                      <!-- /.user-block -->
		                      <p>
		                        Lorem ipsum represents a long-held tradition for designers,
		                        typographers and the like. Some people hate it and argue for
		                        its demise, but others ignore.
		                      </p>
		
		                      <p>
		                        <a href="#" class="link-black text-sm"><i class="fas fa-link mr-1"></i> Demo File 1 v2</a>
		                      </p>
		                    </div>
		
		                    <div class="post clearfix">
		                      <div class="user-block">
		                        <img class="img-circle img-bordered-sm" src="../../dist/img/user7-128x128.jpg" alt="User Image">
		                        <span class="username">
		                          <a href="#">Sarah Ross</a>
		                        </span>
		                        <span class="description">Sent you a message - 3 days ago</span>
		                      </div>
		                      <!-- /.user-block -->
		                      <p>
		                        Lorem ipsum represents a long-held tradition for designers,
		                        typographers and the like. Some people hate it and argue for
		                        its demise, but others ignore.
		                      </p>
		                      <p>
		                        <a href="#" class="link-black text-sm"><i class="fas fa-link mr-1"></i> Demo File 2</a>
		                      </p>
		                    </div>
		
		                    <div class="post">
		                      <div class="user-block">
		                        <img class="img-circle img-bordered-sm" src="../../dist/img/user1-128x128.jpg" alt="user image">
		                        <span class="username">
		                          <a href="#">Jonathan Burke Jr.</a>
		                        </span>
		                        <span class="description">Shared publicly - 5 days ago</span>
		                      </div>
		                      <!-- /.user-block -->
		                      <p>
		                        Lorem ipsum represents a long-held tradition for designers,
		                        typographers and the like. Some people hate it and argue for
		                        its demise, but others ignore.
		                      </p>
		
		                      <p>
		                        <a href="#" class="link-black text-sm"><i class="fas fa-link mr-1"></i> Demo File 1 v1</a>
		                      </p>
		                    </div>
		                </div>
		              </div>
		            </div>
		            <!-- 요구사항정의서 title, content -->
		            <div class="col-12 col-md-12 col-lg-4 order-1 order-md-2">
		              <h3 class="text-primary" ><i class="fas fa-paint-brush"></i> ${reqVo.reqTitle }</h3>
		              <p class="text-muted">${reqVo.reqCont }</p>
		              <br> 
		              <div class="text-muted">
		                <p class="text-sm">Project Leader
		                  <b class="d-block">${reqVo.plId }</b>
		                </p>
		              </div>
						
					<!-- 파일 목록 -->
		              <h5 class="mt-5 text-muted">요구사항 정의서 파일</h5>
		              <ul class="list-unstyled">
		                <li>
		                  <a href="" class="btn-link text-secondary"><i class="far fa-fw fa-file-word"></i> Functional-requirements.docx</a>
		                </li>
		                <li>
		                  <a href="" class="btn-link text-secondary"><i class="far fa-fw fa-file-pdf"></i> UAT.pdf</a>
		                </li>
		                <li>
		                  <a href="" class="btn-link text-secondary"><i class="far fa-fw fa-envelope"></i> Email-from-flatbal.mln</a>
		                </li>
		                <li>
		                  <a href="" class="btn-link text-secondary"><i class="far fa-fw fa-image "></i> Logo.png</a>
		                </li>
		                <li>
		                  <a href="" class="btn-link text-secondary"><i class="far fa-fw fa-file-word"></i> Contract-10_12_2014.docx</a>
		                </li>
		              </ul>
		              <div class="text-center mt-5 mb-3">
		                <a href="#" class="btn btn-sm btn-primary">Add files</a>
		                <a href="#" class="btn btn-sm btn-warning">Report contact</a>
		              </div>
		            </div>
		          </div>
		        </div>
		        <!-- /.card-body -->
		        <div class="card-footer">
			        <a href="/req/reqList" class="btn btn-secondary" id="back">목록</a>
		        </div>
		      </div>
		      <!-- /.card -->
		
		    </section>
	</form:form>
</body>
</html>
